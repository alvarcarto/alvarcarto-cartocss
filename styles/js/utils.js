const _ = require('lodash');
const chroma = require('chroma-js');

const MIN_ZOOM = 0;
const MAX_ZOOM = 16;

function scaleBetweenRanges(range1Val, range1Min, range1Max, range2Min, range2Max, easing)  {
  // range1Val position from 0.0 - 1.0 in the range 1
  const range1Pos = (range1Val - range1Min) / (range1Max - range1Min);

  // Normalize in case value was out of range bounds
  const normRange1Pos = Math.max(Math.min(range1Pos, 1), 0);
  const easedPos = easing(normRange1Pos);

  const range2Val = easedPos * (range2Max - range2Min) + range2Min;
  return range2Val;
}

function scaleFromEasing(easing) {
  return (zoomLevel, minVal, maxVal, opts = {}) => {
    const newOpts = _.extend({}, opts, { easing });
    return scale(zoomLevel, minVal, maxVal, newOpts);
  }
}

function scale(zoomLevel, minVal, maxVal, _opts = {}) {
  const opts = _.extend({
    easing: val => val,
  }, _opts);

  if (_.isString(minVal) && _.isString(maxVal)) {
    const scale = chroma.scale([minVal, maxVal]);

    // Chroma scale takes value between 0.0 and 1.0
    const scaleValue = scaleBetweenRanges(zoomLevel, MIN_ZOOM, MAX_ZOOM, 0, 1, opts.easing);
    return scale(scaleValue).hex();
  }

  const value = scaleBetweenRanges(zoomLevel, MIN_ZOOM, MAX_ZOOM, minVal, maxVal, opts.easing);
  return Number(value.toFixed(2));
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
  scaleBetweenRanges,
  scale,
  scaleFromEasing,
  indent,
  indentExceptFirst,
  MIN_ZOOM,
  MAX_ZOOM,
};
