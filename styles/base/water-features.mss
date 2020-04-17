#water-barriers-point, #water-barriers-line, #water-barriers-poly {
  [waterway = 'dam'] {
    #water-barriers-poly[zoom >= 13] {
      line-width: 2;
      line-color: @dam-line;
      line-join: round;
      line-cap: round;
      polygon-fill: @dam;
    }
    #water-barriers-line[zoom >= 13] {
      line-width: 2;
      line-color: @dam-line;
      line-join: round;
      line-cap: round;
    }
    #water-barriers-point[zoom >= 17] {
      marker-fill: @dam;
      marker-line-color: @dam-line;
      marker-line-width: 1;
      marker-width: 8;
      [zoom >= 18] { marker-width: 10; }
      marker-allow-overlap: true;
      marker-ignore-placement: true;
    }
  }

  [waterway = 'weir'] {
    #water-barriers-line[zoom >= 13] {
      line-color: @weir-line;
      line-width: 2;
      line-dasharray: 2,2;
    }
    #water-barriers-point[zoom >= 17] {
      marker-fill: @water-color;
      marker-line-color: @weir-line;
      marker-line-width: 1;
      marker-width: 8;
      [zoom >= 18] { marker-width: 10; }
      marker-allow-overlap: true;
      marker-ignore-placement: true;
    }
  }

  [waterway = 'lock_gate'] {
    #water-barriers-line[zoom >= 13] {
      line-color: @lock-gate-line;
      line-width: 2;
    }
    #water-barriers-point[zoom >= 17] {
      marker-fill: @lock-gate;
      marker-line-width: 0;
      marker-width: 8;
      [zoom >= 18] { marker-width: 10; }
      marker-allow-overlap: true;
      marker-ignore-placement: true;
    }
  }
}

#piers-poly, #piers-line {
  [man_made = 'pier'][zoom >= 12] {
    #piers-poly {
      polygon-fill: @land-color;
    }
    #piers-line {
      line-width: 0.5;
      line-color: @land-color;
      line-cap: square;
      [zoom >= 13] { line-width: 1; }
      [zoom >= 15] { line-width: 2; }
      [zoom >= 17] { line-width: 4; }
    }
  }

  [man_made = 'breakwater'][zoom >= 12],
  [man_made = 'groyne'][zoom >= 12] {
    #piers-poly {
      polygon-fill: @breakwater-color;
    }
    #piers-line {
      line-width: 1;
      line-color: @breakwater-color;
      [zoom >= 13] { line-width: 2; }
      [zoom >= 16] { line-width: 4; }
    }
  }
}
