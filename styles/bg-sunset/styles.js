const _ = require('lodash');
const chroma = require('chroma-js');
const { createStyles } = require('../../js/styles');
const { extendStyle } = require('../../js/utils');
const bgBlack = require('../bg-black/styles');

const light = '#BD8273'

const newStyle = extendStyle(bgBlack.style, {
  roadLevel1: {
    'line-color': { from: chroma(light).darken(0.1).hex(), to: light }
  },
  roadLevel2: {
    'line-color': { from: chroma(light).darken(0.2).hex(), to: light }
  },
  roadLevel3: {
    'line-color': { from: chroma(light).darken(0.3).hex(), to: light }
  },
  roadLevel4: [{
    minZ: 9,
    values: {
      // When array format is used, we need to set all attributes,
      // these are not merged
      'line-width': { from: 0.3, to: 1.5 },
      'line-color': { from: chroma(light).darken(3).hex(), to: light }
    },
  }],
  railway: {
    'line-color': { from: chroma(light).darken(2).hex(), to: light }
  },
  aeroway: {
    'line-color': { from: chroma(light).darken(2).hex(), to: light }
  },
})

module.exports = {
  style: newStyle,
  stylesArray: createStyles(newStyle),
};
