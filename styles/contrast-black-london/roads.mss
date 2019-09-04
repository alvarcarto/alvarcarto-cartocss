.roads-fill,
.tunnels-fill {
  /* Real motorway, speed limit 120 */
  [feature = 'highway_motorway'] {
    line-width: 0.6; line-color: #fff;

    [zoom >= 10] { line-width: 1.8; line-color: #fff; }
    [zoom >= 12] { line-width: 2; line-color: #fff; }
    [zoom >= 14] { line-width: 3; line-color: #fff; }
    [zoom >= 15] { line-width: 4; line-color: #fff; }
  }

  /*
  Big road, speed limit 80-100
  e.g. Hämeenlinnantie
  */
  [feature = 'highway_trunk'] {
    line-width: 1; line-color: #fff;

    [zoom >= 10] { line-width: 3.2; line-color: #fff; }
    [zoom >= 12] { line-width: 3.6; line-color: #fff; }
    [zoom >= 14] { line-width: 5.6; line-color: #fff; }
    [zoom >= 16] { line-width: 7; line-color: #fff; }
  }
}

.bridges-fill {
  /* Real motorway, speed limit 120 */
  [feature = 'highway_motorway'] {
    line-width: 0.6; line-color: #000;

    [zoom >= 10] { line-width: 1.8; line-color: #000; }
    [zoom >= 12] { line-width: 2; line-color: #000; }
    [zoom >= 14] { line-width: 3; line-color: #000; }
    [zoom >= 15] { line-width: 4; line-color: #000; }
  }

  /*
  Big road, speed limit 80-100
  e.g. Hämeenlinnantie
  */
  [feature = 'highway_trunk'] {
    line-width: 1; line-color: #000;

    [zoom >= 10] { line-width: 3.2; line-color: #000; }
    [zoom >= 12] { line-width: 3.6; line-color: #000; }
    [zoom >= 14] { line-width: 5.6; line-color: #000; }
    [zoom >= 16] { line-width: 7; line-color: #000; }
  }
}
