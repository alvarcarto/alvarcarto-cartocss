.bridges-fill {
  ::fill {
    line-color: #fff;
  }
  ::casing {
    line-color: #000;
  }
}

.roads-fill,
.tunnels-fill {
  ::fill {
    line-color: #000;
  }
}

.roads-fill,
.tunnels-fill,
.bridges-fill {
  ::fill,
  ::casing {
    /* Real motorway, speed limit 120 */
    [feature = 'highway_motorway'] {
      line-width: 0.6;

      [zoom >= 10] { line-width: 1.8; }
      [zoom >= 12] { line-width: 2; }
      [zoom >= 14] { line-width: 3; }
      [zoom >= 15] { line-width: 4; }
    }

    /*
    Big road, speed limit 80-100
    e.g. Hämeenlinnantie
    */
    [feature = 'highway_trunk'] {
      line-width: 1;

      [zoom >= 10] { line-width: 3.2; }
      [zoom >= 12] { line-width: 3.6; }
      [zoom >= 14] { line-width: 5.6; }
      [zoom >= 16] { line-width: 7; }
    }


    /* e.g. Mannerheimintie, speed limit 40-80 */
    [feature = 'highway_primary'],
    /* e.g. Kaivokatu, speed limit 40-80 */
    [feature = 'highway_secondary'],
    /* e.g. Simonkatu, speed limit 30-80 */
    [feature = 'highway_tertiary'] {
      line-width: 0.6;

      [zoom >= 8] { line-width: 1.0; }
      [zoom >= 10] { line-width: 1.6; }
      [zoom >= 11] { line-width: 2.4; }
      [zoom >= 12] { line-width: 3.2; }
      [zoom >= 14] { line-width: 3.6; }
      [zoom >= 15] { line-width: 4; }
      [zoom >= 16] { line-width: 6; }
    }
  }
}

#junctions {
  [highway = 'motorway_junction'] {
    line-color: #fff;
  }
}
