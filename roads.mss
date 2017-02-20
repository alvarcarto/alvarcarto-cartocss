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
      line-color: #222;
      line-width: 2.3;

      [zoom >= 14] { line-width: 4; }
      [zoom >= 15] { line-width: 3; }
    }

    /*
    Big road, speed limit 80-100
    e.g. Hämeenlinnantie
    */
    [feature = 'highway_trunk'] {
      line-color: #555;
      line-width: 2;

      [zoom >= 14] { line-width: 2.5; }
      [zoom >= 15] { line-width: 3; }
    }


    /* e.g. Mannerheimintie, speed limit 40-80 */
    [feature = 'highway_primary'],
    /* e.g. Kaivokatu, speed limit 40-80 */
    [feature = 'highway_secondary'],
    /* e.g. Simonkatu, speed limit 30-80 */
    [feature = 'highway_tertiary'] {
      line-color: #666;
      line-width: 0.8;

      [zoom >= 15] { line-width: 4; }
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
    [feature = 'highway_service']
    {
      line-color: #999;
      line-width: 0.4;

      [zoom >= 10] {
        line-width: 0.5;
      }
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
      [zoom>=16] {
        line-color: #555;
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
      line-color: #aaa;
      line-width: 0.5;

      [zoom >= 10] {
        line-width: 0.4;
      }
    }

    [feature = 'aeroway_runway'],
    [feature = 'aeroway_taxiway'] {
      line-color: #333;
      line-width: 0.8;
    }
  }
}
