const _ = require('lodash');
const stripIndent = require('strip-indent');

const MIN_ZOOM = 0;
const MAX_ZOOM = 16

function indent(str, level) {
  const lines = str.split('\n')
  const firstLine = _.head(lines)
  const tail = _.tail(lines)
  const indentStr = _.repeat('  ', level);
  if (lines.length === 1) {
    return firstLine;
  }

  return `${firstLine}\n${indentStr}${tail.join(`\n${indentStr}`)}`;
}

function scaleBetween(unscaledNum, minAllowed, maxAllowed, min, max) {
  return (maxAllowed - minAllowed) * (unscaledNum - min) / (max - min) + minAllowed;
}

function scale(zoomLevel, min, max) {
  return Number(scaleBetween(zoomLevel, min, max, MIN_ZOOM, MAX_ZOOM).toFixed(2));
}

const ROADS = [
  {
    /* Real motorway, speed limit 120 */
    features: ['highway_motorway'],
    styles: (zoom) => {
      return {
        'line-width': scale(zoom, 0.2, 7),
        'line-color': '#fff',
      };
    },
  },
  {
    /*
    Big road, speed limit 80-100
    e.g. Hämeenlinnantie
    */
    features: ['highway_trunk'],
    styles: (zoom) => {
      return {
        'line-width': scale(zoom, 0.15, 6),
        'line-color': '#fff',
      };
    },
  },
  {
    features: [
      /* e.g. Mannerheimintie, speed limit 40-80 */
      'highway_primary',
      /* e.g. Kaivokatu, speed limit 40-80 */
      'highway_secondary',
      /* e.g. Simonkatu, speed limit 30-80 */
      'highway_tertiary',
    ],
    styles: (zoom) => {
      return {
        'line-width': scale(zoom, 0.1, 4),
        'line-color': '#fff',
      };
    },
  },
  {
    features: [
      /* e.g. Annankatu, speed limit 30-60 */
      'highway_residential',
      /*
      Street in a residental area, speed limit max 30km/h
      e.g. Paimentie
      */
      'highway_living_street',
      'highway_road',
    ],
    styles: (zoom) => {
      if (zoom < 5) {
        return null
      }

      return {
        'line-width': scale(zoom, 0.1, 4),
        'line-color': '#fff',
      };
    },
  },
  {
    /*
    "Other" minor paths and roads
    */
    features: [
      'highway_pedestrian',
      'highway_raceway',
      'highway_platform',
      'highway_steps',
      'highway_bridleway',
      'highway_footway',
      'highway_cycleway',
      'highway_track',
    ],
    styles: (zoom) => {
      if (zoom < 15) {
        return null
      }

      return {
        'line-width': scale(zoom, 0, 0.5),
        'line-color': '#fff',
      };
    },
  }
]

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

function render() {
  const fills = _.map(ROADS, (group) => {
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

render();
