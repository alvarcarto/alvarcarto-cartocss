const { scaleBetween, MAX_ZOOM } = require('../js/utils');

const STYLES = [
  {
    template: `
      .roads-fill[zoom >= 0],
      .bridges-fill[zoom >= 0],
      .tunnels-fill[zoom >= 0] {
        ::fill {
          {{featureStyles}}
        }
      }

      .bridges-fill[zoom >= 0] {
        ::casing {
          {{featureStyles}}
        }
      }

      #junctions {
        [highway = 'motorway_junction'] {
          line-color: #fff;
        }
      }
    `,
    featureStyles: [
      {
        /* Real motorway, speed limit 120 */
        features: ['highway_motorway'],
        styles: (zoom) => {
          const minZoom = 5;
          if (zoom < minZoom) {
            return null
          }

          return {
            'line-width': scaleBetween(zoom, 1, 7, minZoom, MAX_ZOOM),
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
          const minZoom = 10;
          if (zoom < minZoom) {
            return null
          }

          return {
            'line-width': scaleBetween(zoom, 4, 6, minZoom, MAX_ZOOM),
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
          const minZoom = 12;
          if (zoom < minZoom) {
            return null
          }

          return {
            'line-width': scaleBetween(zoom, 3.5, 5.5, minZoom, MAX_ZOOM),
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
          const minZoom = 13;
          if (zoom < minZoom) {
            return null
          }

          return {
            'line-width': scaleBetween(zoom, 3, 5, minZoom, MAX_ZOOM),
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
          const minZoom = 15;
          if (zoom < minZoom) {
            return null
          }

          return {
            'line-width': scaleBetween(zoom, 3, 4, minZoom, 17),
            'line-color': '#fff',
          };
        },
      }
    ]
  },

  {
    template: `
      #admin-countries {
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
            'line-width': scaleBetween(zoom, 0.2, 5, 5, 10),
            'line-color': '#fff',
          };
        },
      },
    ]
  }
]

module.exports = STYLES;