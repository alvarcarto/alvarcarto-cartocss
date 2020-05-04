const _ = require('lodash');
const BezierEasing = require('bezier-easing');
const { scaleFromEasing, extendStyle } = require('./utils');

const FEATURE_GROUPS = {
  // Real motorway, speed limit 120
  roadLevel1: ['highway_motorway'],
  // Big road, speed limit 80-100
  roadLevel2: ['highway_trunk'],
  roadLevel3: [
    /* e.g. Mannerheimintie, speed limit 40-80 */
    'highway_primary',
    /* e.g. Kaivokatu, speed limit 40-80 */
    'highway_secondary',
    /* e.g. Simonkatu, speed limit 30-80 */
    'highway_tertiary',
  ],
  roadLevel4: [
    /* e.g. Annankatu, speed limit 30-60 */
    'highway_residential',
    /*
    Street in a residental area, speed limit max 30km/h
    e.g. Paimentie
    */
    'highway_living_street',
    'highway_unclassified',
    'highway_road',
    'highway_service',
  ],
  // Other walking paths
  roadLevel5: [
    'highway_pedestrian',
    'highway_raceway',
    'highway_platform',
    'highway_steps',
    'highway_bridleway',
    'highway_footway',
    'highway_cycleway',
    'highway_track',
  ],
  railway: [
    'railway_rail',
    'railway_INT-spur-siding-yard',
    'railway_light_rail',
    'railway_funicular',
    'railway_narrow_gauge',
    'railway_miniature',
    'railway_preserved',
    'railway_INT-preserved-ssy',
    'railway_monorail',
    'railway_construction',
    'railway_disused',
    'railway_platform',
    'railway_turntable',
  ],
  aeroway: [
    'aeroway_runway',
    'aeroway_taxiway',
  ]
}

const DEFAULT_STYLE = {
  roadLevel1: {
    // `from` is the value at zoom level 0, `to` is the value at zoom level 16.
    'line-width': { from: 0, to: 5.5 },
    'line-color': { from: '#383838', to: '#0a0a0a' }
  },
  roadLevel2: {
    'line-width': { from: 0, to: 4.0 },
    'line-color': { from: '#555', to: '#1a1a1a' }
  },
  roadLevel3: {
    'line-width': { from: 0, to: 3.5 },
    'line-color': { from: '#666', to: '#272727' }
  },
  // Matching order happens from the highest minZ to lowest
  // "The street-level details override the country level ones"
  roadLevel4: [
    {
      minZ: 11,
      values: {
        'line-width': { from: 0, to: 1.6 },
        'line-color': { from: '#555555', to: '#191919' }
      }
    },
    {
      minZ: 8,
      values: {
        'line-width': { from: 0, to: 0.9 },
        'line-color': { from: '#ccc', to: '#222' }
      }
    },
  ],
  roadLevel5: [
    {
      minZ: 16,
      values: {
        'line-width': { from: 0, to: 0.6 },
        'line-color': { from: '#191919', to: '#191919' },
        'line/line-dasharray': '2,2',
      }
    },
  ],
  railway: {
    'line-width': { from: 0, to: 0.5 },
    'line-color': { from: '#999', to: '#666' }
  },
  aeroway: {
    'line-width': { from: 0, to: 0.5 },
    'line-color': { from: '#999', to: '#666' }
  },
  // Edited with http://greweb.me/bezier-easing-editor/example/
  // Idea is that in lower zoom levels the roads should be thin and exponentially get thicker at
  // higher zoom levels
  easing: {
    // The default easing to use if no attribute specific easing found
    default: BezierEasing(0.55, 0.0, 1.0, 0.4),
    // 'line-width': BezierEasing(0.5, 0.0, 1.0, 0.4),
  },
  featureGroups: FEATURE_GROUPS,
};


function getDefaultStyle() {
  return _.cloneDeep(DEFAULT_STYLE);
}

function extendDefaultStyle(newStyle) {
  return extendStyle(getDefaultStyle(), newStyle);
}

function createFeatureStyles(_opts) {
  const opts = _opts
    ? _opts
    : DEFAULT_STYLE;

  const scalers = {};
  _.forEach(opts.easing, (val, key) => {
    scalers[key] = scaleFromEasing(val);
  });

  function getScaler(attr) {
    return _.get(scalers, attr, scalers.default);
  }

  // Mutates `attributes`
  function setAttrs(attributes, groupOpts, zoom) {
    _.forEach(groupOpts, (val, attrKey) => {
      if (_.isPlainObject(val)) {
        // Interpolate the values
        attributes[attrKey] = getScaler(attrKey)(zoom, val.from, val.to);
      } else {
        // Not an interpolateable value
        attributes[attrKey] = val;
      }
    });
  }

  // This is quite meta-meta, but we already had a generator that converts this array format to
  // .mss styles, so this setup first creates that array format, which is then converted
  return _.map(opts.featureGroups, (features, group) => {
    const groupOpts = opts[group];

    // In case the group has been set to null
    if (!groupOpts) {
      return {
        features,
        styles: () => null,
      };
    }

    return {
      features,
      styles: (zoom) => {
        const attributes = {};

        if (_.isPlainObject(groupOpts)) {
          setAttrs(attributes, groupOpts, zoom);
        } else if (_.isArray(groupOpts)) {
          const sorted = _.orderBy(groupOpts, item => item.minZ, 'desc');

          const matching = _.find(sorted, (item) => zoom >= item.minZ);
          if (!matching) {
            return null;
          }

          setAttrs(attributes, matching.values, zoom);
        } else {
          throw new Error(`Unknown type for group options, array or object expected. Group: ${group}`);
        }

        return attributes;
      }
    }
  });
}

function createStyles(opts) {
  const styles = [];

  styles.push({
    template: `
      #roads-fill[zoom >= 0],
      #bridges[zoom >= 0],
      #tunnels[zoom >= 0] {
        ::fill {
          {{featureStyles}}
        }
      }
    `,
    featureStyles: createFeatureStyles(opts)
  });

  if (!opts.skipBridgeCasing) {
    styles.push({
      template: `
        #bridges[zoom >= 0] {
          ::casing {
            {{featureStyles}}
          }
        }
      `,
      featureStyles: createFeatureStyles(opts)
    });
  }

  return styles;
}

module.exports = {
  createStyles,
  createFeatureStyles,
  getDefaultStyle,
  extendDefaultStyle,
};
