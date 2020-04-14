const _ = require('lodash');
const chroma = require('chroma-js');
const BezierEasing = require('bezier-easing');
const { scaleFromEasing } = require('../js/utils');

// Edited with http://greweb.me/bezier-easing-editor/example/
// Idea is that in lower zoom levels the roads should be thin and exponentially get thicker at
// higher zoom levels
const easing = BezierEasing(0.5, 0.0, 1.0, 0.4);
const scale = scaleFromEasing(easing);

function createRoads(lineColor, shouldScaleColor = true) {
  return [
    {
      /* Real motorway, speed limit 120 */
      features: ['highway_motorway'],
      styles: (zoom) => {
        return {
          'line-width': scale(zoom, 0, 5.5),
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.04).hex(), chroma(lineColor).luminance(0.003).hex())
            : lineColor
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
          'line-width': scale(zoom, 0, 4),
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.07).hex(), chroma(lineColor).luminance(0.005).hex())
            : lineColor
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
          'line-width': scale(zoom, 0, 3.5),
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.1).hex(), chroma(lineColor).luminance(0.02).hex())
            : lineColor
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
        'highway_unclassified',
        'highway_road',
        'highway_service',
      ],
      styles: (zoom) => {
        // This is the only discountinuity needed for getting a pleasing result
        // with automatic scaling. Many combinations were tried byt
        if (zoom < 11) {
          return {
            'line-width': scale(zoom, 0, 1),
            'line-color': shouldScaleColor
              ? scale(zoom, chroma(lineColor).luminance(0.5).hex(), chroma(lineColor).luminance(0.02).hex())
              : lineColor
          };
        }

        return {
          'line-width': scale(zoom, 0, 1.6),
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.2).hex(), chroma(lineColor).luminance(0.01).hex())
            : lineColor
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
        const minZoom = 16;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 0.6),
          'line/line-dasharray': '2,2',
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.1).hex(), chroma(lineColor).luminance(0.01).hex())
            : lineColor
        };
      },
    },
    {
      /* Railways */
      features: [
        'railway_rail',
        'railway_INT-spur-siding-yard',
        'railway_light_rail',
        'railway_funicular',
        'railway_narrow_gauge',
        'railway_miniature',
        'railway_preserved',
        'railway_INT-preserved-ssy',
        'railway_monorail',
        'railway_construction',
        'railway_disused',
        'railway_platform',
        'railway_turntable',
      ],
      styles: (zoom) => {
        const minZoom = 10;
        if (zoom < minZoom) {
          return null
        }

        return {
          'line-width': scale(zoom, 0, 0.5),
          'line-color': shouldScaleColor
            ? scale(zoom, chroma(lineColor).luminance(0.2).hex(), chroma(lineColor).luminance(0.1).hex())
            : lineColor
        };
      },
    },
    {
      features: [
        'aeroway_runway',
        'aeroway_taxiway',
      ],
      styles: (zoom) => {
        return {
          'line-width': scale(zoom, 0, 1),
          'line-color': '#666',
        };
      },
    },
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

      #bridges[zoom >= 0] {
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
    featureStyles: createRoads('#000')
  }
]

module.exports = STYLES;
