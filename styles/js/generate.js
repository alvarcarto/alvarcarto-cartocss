const path = require('path');
const _ = require('lodash');
const stripIndent = require('strip-indent');
const { indent } = require('./utils');

function createStyleForZoomLevel(group, level) {
  const levelStyles = group.styles(level);
  if (!levelStyles) {
    return null;
  }

  const stylesArr = _.map(levelStyles, (val, key) => `${key}: ${val};`)
  return stripIndent(`
    [zoom >= ${level}] {
      ${indent(stylesArr.join('\n'), 3)}
    }
  `).trim()
}

function createZoomLevelsForGroup(group, indent) {
  const arr = _.map(_.range(0, 17), (level) => {
    const zoomStyle = createStyleForZoomLevel(group, level)
    return zoomStyle
  });

  return _.filter(arr, i => !_.isNull(i)).join(' ')
}

function renderStyle(style) {
  const featureStyles = _.map(style.featureStyles, (group) => {
    const features = _.map(group.features, name => `[feature = '${name}']`).join(',\n').trim()
    const a = stripIndent(`
      ${indent(features, 3)} {
        ${indent(createZoomLevelsForGroup(group), 4)}
      }
    `)
    return a
  }).join('').trim()

  const { template } = style;
  const lines = _.map(template.split('\n'), line => {
    if (line.indexOf('{{featureStyles}}') === -1) {
      return line;
    }
    const indentLevel = (line.length - _.trimStart(line, ' ').length) / 2;
    return indent(featureStyles, indentLevel);
  });

  console.log(lines.join('\n'))
}

function render(styles) {
  _.forEach(styles, s => renderStyle(s));
}

const filePath = path.join(process.cwd(), process.argv[2])
const styles = require(filePath)

render(styles);
