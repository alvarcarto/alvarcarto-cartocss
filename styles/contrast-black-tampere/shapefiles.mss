#world {
  [zoom >= 0][zoom < 10] {
    polygon-fill: @land-color;
  }
}

#coast-poly {
  [zoom >= 10] {
    polygon-fill: @land-color;
  }
}

#icesheet-poly {
  [zoom >= 6] {
    polygon-fill: @glacier;
  }
}

#icesheet-outlines {
  [zoom >= 6] {
    [ice_edge = 'ice_ocean'],
    [ice_edge = 'ice_land'] {
      line-width: 0.375;
      line-color: @glacier-line;
      [zoom >= 8] {
        line-width: 0.5;
      }
      [zoom >= 10] {
        line-dasharray: 4,2;
        line-width: 0.75;
      }
    }
  }
}

#builtup {
  [zoom >= 8][zoom < 10] {
    polygon-fill: #000;
  }
}


/*
 * Uncomment to enable country boundaries which
 * can be cut with photoshop
*/

/*
#necountries {
  line-color: #f00;
  line-width: 8;
}
*/

#necountries {
  [zoom >= 1][zoom < 8] {
    line-width: 10;
    line-color: @admin-boundaries;
  }
}

#admin-medium-zoom {
  [zoom >= 1] {
    line-width: 10;
    line-color: @admin-boundaries;
  }
}