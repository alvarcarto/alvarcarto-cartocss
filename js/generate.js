const path = require('path');
const _ = require('lodash');
const stripIndent = require('strip-indent');
const { indent, indentExceptFirst } = require('./utils');

// This is a debug flag, which shouldn't be turned on in normal operation
const DISALLOW_STYLE_OVERRIDING = false;


function createStyleForZoomLevel(levelStyles, level) {
  const stylesArr = _.map(levelStyles, (val, key) => `${key}: ${val};`)
  return stripIndent(`
    [zoom >= ${level}] {
      ${indentExceptFirst(stylesArr.join('\n'), 3)}
    }
  `).trim()
}

// This produces unoptimized carto css, but makes generation easier
function renderStyle(style) {
  const stylesByFeature = {};
  _.forEach(_.range(0, 17), (zoomLevel) => {
    _.forEach(style.featureStyles, (styleForGroup) => {
      // This iterates roadLevel1, roadLevel2 group etc..
      const group = styleForGroup(zoomLevel);

      const resolvedFeatures = group.features
        ? group.features
        : ['ALL']  // Special case where the feature is already set in the template (e.g. contrast black countries)

      _.forEach(resolvedFeatures, (featureName) => {
        if (DISALLOW_STYLE_OVERRIDING) {
          const existingStyles = _.get(stylesByFeature, [featureName, zoomLevel]);
          if (!_.isUndefined(existingStyles) && !_.isEqual(existingStyles, group.styles)) {
            // This might be an issue if styles accidentally override each other
            console.error(stylesByFeature);
            console.error(style.template)
            console.error(group.styles, existingStyles)
            console.warn(`Duplicate non-equal styles found, ${featureName} and z${zoomLevel} already exists!`);
          }
        }

        if (!group.styles) {
          return;
        }

        if (!_.has(stylesByFeature, featureName)) {
          stylesByFeature[featureName] = { [zoomLevel]: group.styles }
        } else {
          stylesByFeature[featureName][zoomLevel] = group.styles;
        }
      });
    });
  });

  const featureStylesArr = _.map(stylesByFeature, (zoomLevelStyles, featureName) => {
    if (featureName === 'ALL') {
      return _.map(zoomLevelStyles, (levelStyle, zoomLevel) => {
        return createStyleForZoomLevel(levelStyle, zoomLevel);
      }).join('\n');
    }

    const featureStr = `[feature = '${featureName}']`;

    const levelsStyleArr = _.map(zoomLevelStyles, (levelStyle, zoomLevel) => {
      return createStyleForZoomLevel(levelStyle, zoomLevel);
    });

    const styleStr = stripIndent(`
      ${indentExceptFirst(featureStr, 3)} {
        ${indentExceptFirst(levelsStyleArr.join('\n'), 4)}
      }
    `)
    return styleStr;
  });

  const featureStylesStr = _.flatten(featureStylesArr).join('').trim();

  const { template } = style;
  const lines = _.map(template.split('\n'), line => {
    if (line.indexOf('{{featureStyles}}') === -1) {
      return line;
    }
    const indentLevel = (line.length - _.trimStart(line, ' ').length) / 2;
    return indent(featureStylesStr, indentLevel);
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
