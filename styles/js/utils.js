const _ = require('lodash');

const MIN_ZOOM = 0;
const MAX_ZOOM = 16;

function scaleBetween(unscaledNum, minAllowed, maxAllowed, min, max) {
  return (maxAllowed - minAllowed) * (unscaledNum - min) / (max - min) + minAllowed;
}

function scale(zoomLevel, min, max) {
  return Number(scaleBetween(zoomLevel, min, max, MIN_ZOOM, MAX_ZOOM).toFixed(2));
}

function indentExceptFirst(str, level) {
  const lines = str.split('\n')
  const firstLine = _.head(lines)
  const tail = _.tail(lines)
  const indentStr = _.repeat('  ', level);
  if (lines.length === 1) {
    return firstLine;
  }

  return `${firstLine}\n${indentStr}${tail.join(`\n${indentStr}`)}`;
}

function indent(str, level) {
  const lines = str.split('\n')
  const indentStr = _.repeat('  ', level);
  return _.map(lines, l => `${indentStr}${l}`).join('\n')
}

module.exports = {
  scaleBetween,
  scale,
  indent,
  indentExceptFirst,
  MIN_ZOOM,
  MAX_ZOOM,
};
