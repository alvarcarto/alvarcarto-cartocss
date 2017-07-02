.roads-fill[zoom >= 5],
.bridges-fill[zoom >= 5],
.tunnels-fill[zoom >= 5] {
  ::fill {
    /*
    All features for reference:

    [feature = 'highway_motorway'],
    [feature = 'highway_trunk'],
    [feature = 'highway_primary'],
    [feature = 'highway_secondary'],
    [feature = 'highway_tertiary'],
    [feature = 'highway_residential'],
    [feature = 'highway_unclassified'],
    [feature = 'highway_living_street'],
    [feature = 'highway_road'],
    [feature = 'highway_service'],
    [feature = 'highway_pedestrian'],
    [feature = 'highway_raceway'],
    [feature = 'highway_platform'],
    [feature = 'highway_steps'],
    [feature = 'highway_bridleway'],
    [feature = 'highway_footway'],
    [feature = 'highway_cycleway'],
    [feature = 'highway_track'],
    [feature = 'railway_rail'],
    [feature = 'railway_INT-spur-siding-yard'],
    [feature = 'railway_light_rail'],
    [feature = 'railway_funicular'],
    [feature = 'railway_narrow_gauge'],
    [feature = 'railway_miniature'],
    [feature = 'railway_tram'],
    [feature = 'railway_tram-service'],
    [feature = 'railway_subway'],
    [feature = 'railway_preserved'],
    [feature = 'railway_INT-preserved-ssy'],
    [feature = 'railway_monorail'],
    [feature = 'railway_construction'],
    [feature = 'railway_disused'],
    [feature = 'railway_platform'],
    [feature = 'railway_turntable'],
    [feature = 'aeroway_runway'],
    [feature = 'aeroway_taxiway']
    */


    /* Real motorway, speed limit 120 */
    [feature = 'highway_motorway'] {
      line-color: #fff;
      line-width: 0.6;

      [zoom >= 10] {
        line-color: #fff;
        line-width: 1.8;
      }
      [zoom >= 12] {
        line-color: #fff;
        line-width: 2;
      }
      [zoom >= 14] { line-width: 3; }
      [zoom >= 15] { line-width: 4; }
    }

    /*
    Big road, speed limit 80-100
    e.g. Hämeenlinnantie
    */
    [feature = 'highway_trunk'] {
      line-color: #fff;
      line-width: 0.5;

      [zoom >= 10] {
        line-color: #fff;
        line-width: 1.6;
      }
      [zoom >= 12] {
        line-color: #fff;
        line-width: 1.8;
      }
      [zoom >= 14] { line-width: 2.8; }
      [zoom >= 16] { line-width: 3.5; }
    }


    /* e.g. Mannerheimintie, speed limit 40-80 */
    [feature = 'highway_primary'],
    /* e.g. Kaivokatu, speed limit 40-80 */
    [feature = 'highway_secondary'],
    /* e.g. Simonkatu, speed limit 30-80 */
    [feature = 'highway_tertiary'] {
      line-color: #fff;
      line-width: 0.3;

      [zoom >= 8] {
        line-color: #fff;
        line-width: 0.5;
      }
      [zoom >= 10] {
        line-color: #fff;
        line-width: 0.8;
      }
      [zoom >= 11] {
        line-color: #fff;
        line-width: 1.2;
      }
      [zoom >= 12] {
        line-color: #fff;
        line-width: 1.6;
      }
      [zoom >= 14] {
        line-color: #fff;
        line-width: 1.8;
      }
      [zoom >= 15] { line-width: 2; }
      [zoom >= 16] { line-width: 3; }
    }


    /* e.g. Annankatu, speed limit 30-60 */
    [feature = 'highway_residential'],
    /*
    Street in a residental area, speed limit max 30km/h
    e.g. Paimentie
    */
    [feature = 'highway_living_street'],
    [feature = 'highway_unclassified'],
    [feature = 'highway_road'],
    [feature = 'highway_service'] {
      line-color: #fff;
      line-width: 0.1;

      [zoom >= 8] {
        line-color: #fff;
        line-width: 0.1;
      }
      [zoom >= 10] {
        line-color: #fff;
        line-width: 0.2;
      }
      [zoom >= 11] {
        line-color: #fff;
        line-width: 0.5;
      }
      [zoom >= 12] {
        line-color: #fff;
      }
      [zoom >= 13] { line-width: 1; }
    }

    /*
    "Other" minor paths and roads
    */
    [feature = 'highway_pedestrian'],
    [feature = 'highway_raceway'],
    [feature = 'highway_platform'],
    [feature = 'highway_steps'],
    [feature = 'highway_bridleway'],
    [feature = 'highway_footway'],
    [feature = 'highway_cycleway'],
    [feature = 'highway_track'] {
      line-color: #fff;

      ::line, ::dash  {
        line-color: #fff;
      }

      [zoom>=16] {
        line-color: #fff;
        line-width: 0.5;
        line/line-dasharray: 2,2;
      }
    }

    /* Trams */
    [feature = 'railway_tram'],
    [feature = 'railway_tram-service'] {

    }

    /* Railways */
    [feature = 'railway_rail'],
    [feature = 'railway_INT-spur-siding-yard'],
    [feature = 'railway_light_rail'],
    [feature = 'railway_funicular'],
    [feature = 'railway_narrow_gauge'],
    [feature = 'railway_miniature'],
    [feature = 'railway_subway'],
    [feature = 'railway_preserved'],
    [feature = 'railway_INT-preserved-ssy'],
    [feature = 'railway_monorail'],
    [feature = 'railway_construction'],
    [feature = 'railway_disused'],
    [feature = 'railway_platform'],
    [feature = 'railway_turntable'] {
      line-color: #fff;
      line-width: 0.2;

      [zoom >= 10] {
        line-color: #fff;
        line-width: 0.4;
      }
    }

    [feature = 'aeroway_runway'],
    [feature = 'aeroway_taxiway'] {
      line-color: #fff;
      line-width: 0.4;
    }
  }
}

#junctions {
  [highway = 'motorway_junction'] {
    line-color: #fff;
  }
}