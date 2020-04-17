const { createStyles } = require('../../js/styles');
const bgBlack = require('../bg-black/styles');

module.exports = {
  style: bgBlack.style,
  stylesArray: createStyles(bgBlack.style),
};
