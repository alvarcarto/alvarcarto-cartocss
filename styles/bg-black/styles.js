const { createStyles, extendDefaultStyle } = require('../../js/styles');

const style = extendDefaultStyle({
  roadLevel1: {
    'line-color': { from: '#aaa', to: '#bbb' }
  },
  roadLevel2: {
    'line-color': { from: '#888', to: '#aaa' }
  },
  roadLevel3: {
    'line-color': { from: '#777', to: '#aaa' },
  },
  roadLevel4: [{
    minZ: 9,
    // When array format is used, we need to set all attributes,
    // these are not merged
    values: {
      'line-width': { from: 0.3, to: 1.5 },
      'line-color': { from: '#222', to: '#aaa' }
    },
  }],
  roadLevel5: null,
  railway: {
    'line-width': { from: 0.3, to: 1 },
    'line-color': { from: '#222', to: '#999' }
  },
  aeroway: {
    'line-width': { from: 0.3, to: 1 },
    'line-color': { from: '#222', to: '#999' }
  }
});

module.exports = {
  style,
  stylesArray: createStyles(style)
};
