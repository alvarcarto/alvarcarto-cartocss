const _ = require('lodash');
const { scaleBetweenRanges, scale } = require('../js/utils');

function createRoads(lineColor) {
  return [
    {
      /* Real motorway, speed limit 120 */
      features: ['highway_motorway'],
      styles: (zoom) => {
        const minZoom = 6;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 5),
          'line-color': lineColor,
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
        const minZoom = 10;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 4),
          'line-color': lineColor,
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
        const minZoom = 10;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 3.5),
          'line-color': lineColor,
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
        const minZoom = 12;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 3),
          'line-color': lineColor,
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
        const minZoom = 15;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 1.5),
          'line-color': lineColor,
        };
      },
    }
  ]
}

const STYLES = [
  {
    template: `
      #roads-fill[zoom >= 0],
      #bridges[zoom >= 0],
      #tunnels[zoom >= 0] {
        ::fill {
          {{featureStyles}}
        }
      }

      #junctions {
        [highway = 'motorway_junction'] {
          line-color: #fff;
        }
      }
    `,
    featureStyles: createRoads('#fff')
  },

  {
    template: `
      #bridges[zoom >= 0] {
        ::casing {
          {{featureStyles}}
        }
      }
    `,
    featureStyles: _.take(createRoads('#000'), 3)
  },

  {
    template: `
      #custom-alvar-countries {
        {{featureStyles}}
      }
    `,
    featureStyles: [
      {
        styles: (zoom) => {
          if (zoom < 5 || zoom > 10) {
            return {
              'line-width': 0,
            };
          }

          return {
            // This scaling is done in zoom ranges 5-10, instead of the regular 0-16
            'line-width': scaleBetweenRanges(zoom, 5, 10, 2.5, 5),
            'line-color': '#fff',
          };
        },
      },
    ]
  }
]

module.exports = STYLES;