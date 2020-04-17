const path = require('path');
const _ = require('lodash');
const stripIndent = require('strip-indent');
const { indent, indentExceptFirst } = require('./utils');

function createStyleForZoomLevel(group, level) {
  const levelStyles = group.styles(level);
  if (!levelStyles) {
    return null;
  }

  const stylesArr = _.map(levelStyles, (val, key) => `${key}: ${val};`)
  return stripIndent(`
    [zoom >= ${level}] {
      ${indentExceptFirst(stylesArr.join('\n'), 3)}
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
    if (!group.features) {
      return createZoomLevelsForGroup(group)
    }

    const features = _.map(group.features, name => `[feature = '${name}']`).join(',\n').trim()
    const a = stripIndent(`
      ${indentExceptFirst(features, 3)} {
        ${indentExceptFirst(createZoomLevelsForGroup(group), 4)}
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

  console.log(stripIndent(lines.join('\n')))
}

function render(styles) {
  if (!_.isArray(styles) || styles.length < 1) {
    throw new Error(`Empty styles found. You need to export a styles array from the style modyle.`);
  }

  _.forEach(styles, s => renderStyle(s));
}

const filePath = path.join(process.cwd(), process.argv[2])
const styleModule = require(filePath)

render(styleModule.stylesArray);
