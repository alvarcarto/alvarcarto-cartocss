const { scale } = require('../js/utils');

const ROADS = [
  {
    /* Real motorway, speed limit 120 */
    features: ['highway_motorway'],
    styles: (zoom) => {
      return {
        'line-width': scale(zoom, 0.2, 7),
        'line-color': '#FFCD01',
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
        'line-color': '#FFCD01',
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
        'line-width': scale(zoom, 0.1, 5.5),
        'line-color': '#FFCD01',
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
        'line-width': scale(zoom, 0.1, 5),
        'line-color': '#FFCD01',
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
        'line-color': '#FFCD01',
      };
    },
  }
]

module.exports = ROADS;