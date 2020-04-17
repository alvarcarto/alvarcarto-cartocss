const _ = require('lodash');
const chroma = require('chroma-js');
const { createStyles } = require('../../js/styles');
const { extendStyle } = require('../../js/utils');
const bgBlack = require('../bg-black/styles');

const newStyle = extendStyle(bgBlack.style, {
  roadLevel1: {
    'line-color': { from: '#555', to: '#333' }
  },
  roadLevel2: {
    'line-color': { from: '#777', to: '#555' }
  },
  roadLevel3: {
    'line-color': { from: '#aaa', to: '#666' }
  },
  roadLevel4: [{
    minZ: 9,
    values: {
      // When array format is used, we need to set all attributes,
      // these are not merged
      'line-width': { from: 0.3, to: 1.5 },
      'line-color': { from: '#ccc', to: '#999' }
    },
  }],
  railway: {
    'line-color': { from: '#ccc', to: '#999' }
  },
  aeroway: {
    'line-color': { from: '#ccc', to: '#999' }
  },
})

module.exports = {
  style: newStyle,
  stylesArray: createStyles(newStyle),
};
