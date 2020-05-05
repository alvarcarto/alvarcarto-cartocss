const _ = require('lodash');
const BezierEasing = require('bezier-easing');
const { createStyles, createFeatureStyles, getDefaultStyle } = require('../../js/styles');
const { scale, deepReplaceAttributes } = require('../../js/utils');

const defaultStyle = getDefaultStyle();

const newFeatureGroups = _.extend({}, defaultStyle.featureGroups, {
  roadLevel4: null,
  roadLevel4Simple: ['highway_residential', 'highway_living_street'],
  roadLevel4Detailed: defaultStyle.featureGroups.roadLevel4,
});

const contrastBlackStyle = {
  roadLevel1: {
    'line-width': { from: 0.5, to: 10 },
    'line-color': { from: '#fff', to: '#fff' }
  },
  roadLevel2: [
    {
      minZ: 4,
      values: {
        'line-width': { from: 0.2, to: 9 },
        'line-color': { from: '#fff', to: '#fff' }
      },
    }
  ],
  roadLevel3: [
    {
      minZ: 10,
      values: {
        'line-width': { from: 0, to: 8.5 },
        'line-color': { from: '#fff', to: '#fff' }
      },
    }
  ],
  roadLevel4: null,
  roadLevel4Simple: [
    {
      minZ: 14,
      values: null
    },
    {
      minZ: 12,
      values: {
        'line-width': { from: 0, to: 5 },
        'line-color': { from: '#fff', to: '#fff' }
      }
    },
  ],
  roadLevel4Detailed: [
    {
      minZ: 14,
      values: {
        'line-width': { from: 0, to: 5 },
        'line-color': { from: '#fff', to: '#fff' }
      }
    },
  ],
  roadLevel5: null,
  railway: [
    {
      minZ: 10,
      values: {
        'line-width': { from: 0, to: 2 },
        'line-color': { from: '#fff', to: '#fff' }
      },
    }
  ],
  aeroway: [
    {
      minZ: 10,
      values: {
        'line-width': { from: 0, to: 2 },
        'line-color': { from: '#fff', to: '#fff' }
      },
    }
  ],
  easing: {
    default: BezierEasing(0.03, 0.00, 1.00, 0.20),
  },
  featureGroups: newFeatureGroups,
};

const bridgeStyle = deepReplaceAttributes(contrastBlackStyle, 'line-color', () => ({ from: '#000', to: '#000' }));
bridgeStyle.featureGroups = {};
_.forEach(defaultStyle.featureGroups, (features, group) => {
  const isLargeEnough = _.includes(['roadLevel1', 'roadLevel2', 'roadLevel3'], group);
  if (isLargeEnough) {
    bridgeStyle.featureGroups[group] = features;
  }
});

// First add default styles
const stylesArray = createStyles(_.extend({}, contrastBlackStyle, { skipBridgeCasing: true }));

// Then make bridges black
stylesArray.push({
  template: `
    #bridges[zoom >= 0] {
      ::casing {
        {{featureStyles}}
      }
    }
  `,
  featureStyles: createFeatureStyles(bridgeStyle)
});

stylesArray.push({
  template: `
    #custom-alvar-countries {
      {{featureStyles}}
    }
  `,
  featureStyles: [
    (zoom) => {
      if (zoom < 5 || zoom > 10) {
        return {
          features: null,
          styles: {
            'line-width': 0,
          }
        };
      }

      return {
        features: null,
        styles: {
          'line-width': scale(zoom, 2, 7),
          'line-color': '#fff',
        }
      };
    }
  ]
});

module.exports = {
  style: contrastBlackStyle,
  stylesArray,
};
