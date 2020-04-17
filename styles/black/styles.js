const _ = require('lodash');
const { createStyles, getDefaultStyle } = require('../../js/styles');
const { deepReplaceAttributes } = require('../../js/utils');

const newStyle = deepReplaceAttributes(getDefaultStyle(), 'line-color', () => ({ from: '#fff', to: '#fff' }));
const styles = createStyles(newStyle);

module.exports = {
  style: newStyle,
  stylesArray: styles,
};
