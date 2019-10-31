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

function render(roads) {
  const fills = _.map(roads, (group) => {
    const features = _.map(group.features, name => `[feature = '${name}']`).join(',\n').trim()
    const a = stripIndent(`
      ${indent(features, 3)} {
        ${indent(createZoomLevelsForGroup(group), 4)}
      }
    `)
    return a
  }).join('').trim()

  const styles = stripIndent(`
    .roads-fill[zoom >= 0],
    .bridges-fill[zoom >= 0],
    .tunnels-fill[zoom >= 0] {
      ::fill {
        ${indent(fills, 4)}
      }
    }

    .bridges-fill[zoom >= 0] {
      ::casing {
        ${indent(fills, 4)}
      }
    }

    #junctions {
      [highway = 'motorway_junction'] {
        line-color: #fff;
      }
    }
  `);

  console.log(styles)
}

const filePath = path.join(process.cwd(), process.argv[1])
const roads = require(filePath)

render(roads);
