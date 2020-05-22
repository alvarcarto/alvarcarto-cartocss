const _ = require('lodash');
const BezierEasing = require('bezier-easing');
const { scaleFromEasing, extendStyle } = require('./utils');

// To find out how many road rows there are on the planet per feature type, see README.md
const FEATURE_GROUPS = {
  // Real motorway, speed limit 120
  // count: 1 186 943 rows
  roadLevel1: ['highway_motorway'],
  // Big road, speed limit 80-100
  // count: 1 308 437 rows
  roadLevel2: ['highway_trunk'],
  roadLevel3: [
    // e.g. Mannerheimintie, speed limit 40-80
    // count: 2 729 494 rows
    'highway_primary',
    // e.g. Kaivokatu, speed limit 40-80
    // count: 3 836 121 rows
    'highway_secondary',
    // e.g. Simonkatu, speed limit 30-80
    // count: 5 767 143 rows
    'highway_tertiary',
  ],
  roadLevel4: [
    // e.g. Annankatu, speed limit 30-60
    // count: 50 597 088 rows
    'highway_residential',
    // Street in a residental area e.g. Paimentie, speed limit max 30km/h
    // count: 1 161 247 rows
    'highway_living_street',
    'highway_unclassified',  // count: 12 722 846 rows
    'highway_road',  // count: 164 102 rows
    'highway_service',  // count: 31 264 766 rows
  ],
  // Other walking paths
  roadLevel5: [
    'highway_pedestrian',  // count: 393 204 rows
    'highway_raceway',  // count: 24 778 rows
    'highway_platform',  // count: 70 193 rows
    'highway_steps',  // count: 991 131 rows
    'highway_bridleway',  // count: 83 592 rows
    'highway_footway',  // count: 11 255 651 rows
    'highway_cycleway',  // count: 1 048 213 rows
    'highway_track',  // count: 18 033 944 rows
  ],
  railway: [
    'railway_rail',  // count: 724 638 rows
    'railway_INT-spur-siding-yard',  // count: 886 862 rows
    'railway_light_rail',  // count: 20 815 rows
    'railway_funicular',  // count: 1 070 rows
    'railway_narrow_gauge',  // count: 33 430 rows
    'railway_miniature',  // count: 5 742 rows
    'railway_preserved',  // count: 5 135 rows
    'railway_INT-preserved-ssy',  // count: 2 680 rows
    'railway_monorail',  // count: 1 614 rows
    'railway_construction',  // count: 9 523 rows
    'railway_disused',  // count: 92 697 rows
    'railway_platform',  // count: 56 093 rows
    'railway_turntable',  // count: 2 104 rows
  ],
}

const AEROWAY_FEATURE_GROUPS = {
  aeroway: [
    'runway',
    'taxiway',
  ]
};

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
  roadLevel3: [
    {
      minZ: 0,
      features: ['highway_primary', 'highway_secondary', 'highway_tertiary'],
      values: {
        'line-width': { from: 0, to: 3.5 },
        'line-color': { from: '#666', to: '#272727' }
      }
    },
    /*
    // This is not needed after we did SQL query optimisations for low level roads
    // Limit the amount of features we show at very low zoom levels
    {
      minZ: 6,
      features: ['highway_primary', 'highway_secondary', 'highway_tertiary'],
      values: {
        'line-width': { from: 0, to: 3.5 },
        'line-color': { from: '#666', to: '#272727' }
      }
    },
    */
  ],
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
    'line-width': { from: 0, to: 1 },
    'line-color': { from: '#777', to: '#222' }
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
      return () => ({ features, styles: null });
    }

    return (zoom) => {
      let attributes = {};
      let resolvedFeatures = features;

      if (!_.isPlainObject(groupOpts) && !_.isArray(groupOpts)) {
        throw new Error(`Unknown type for group options, array or object expected. Group: ${group}`);
      }

      if (_.isPlainObject(groupOpts)) {
        setAttrs(attributes, groupOpts, zoom);
      } else if (_.isArray(groupOpts)) {
        const sorted = _.orderBy(groupOpts, item => item.minZ, 'desc');

        const matching = _.find(sorted, (item) => zoom >= item.minZ);
        if (matching) {
          setAttrs(attributes, matching.values, zoom);
          if (matching.features) {
            resolvedFeatures = matching.features;
          }
        } else {
          attributes = null;
        }
      }

      return {
        features: resolvedFeatures,
        styles: attributes
      };
    }
  });
}

function createStyles(opts) {
  const styles = [];

  // The visibility zoom levels are controlled via project-template.mml
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

  styles.push({
    template: `
      #roads-fill-optimized[zoom >= 0],
      #bridges-optimized[zoom >= 0],
      #tunnels-optimized[zoom >= 0] {
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
        #bridges-optimized[zoom >= 0] {
          ::casing {
            {{featureStyles}}
          }
        }
      `,
      featureStyles: createFeatureStyles(opts)
    });
  }

  const aerowayOpts = _.extend({}, opts, {
    featureGroups: AEROWAY_FEATURE_GROUPS
  });
  styles.push({
    template: `
      #aeroways[zoom >= 0] {
        ::fill {
          {{featureStyles}}
        }
      }
    `,
    featureStyles: createFeatureStyles(aerowayOpts),
    keyword: 'aeroway'
  });

  return styles;
}

module.exports = {
  createStyles,
  createFeatureStyles,
  getDefaultStyle,
  extendDefaultStyle,
};
