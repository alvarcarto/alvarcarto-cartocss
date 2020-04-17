const _ = require('lodash');
const chroma = require('chroma-js');
const chart = require('asciichart');

const steps = 64;

// Setting luminance works in an exponential scale, because
// of percieved darkness.
console.log('\n\nSetting luminance:\n')
const lums = _.map(_.range(0, steps), num => {
  const color = [255, 255, 255];
  const newColor = chroma(color).luminance(num / steps);
  return newColor.get('hsl.l') * 100;
});

console.log(chart.plot(lums));

const lums2 = _.map(_.range(0, steps), num => {
  const color = [255, 255, 255];
  const newColor = chroma(color).set('hsl.l', num / steps);
  return newColor.get('hsl.l') * 100;
});

console.log('\n\nSetting HSL lightness:\n')
console.log(chart.plot(lums2));
