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
To simplify the borders, see https://github.com/gravitystorm/openstreetmap-carto/blob/ea73a44105ad1c3a0ebff817d4a8e9ea9233124b/admin.mss
*/

#admin-countries {
  [zoom >= 1] {
    line-width: 5;
    line-color: @admin-boundaries;
  }
}

/* Uncomment to draw country areas, like Lappi */
/*
#admin-low-zoom {
  [zoom >= 1] {
    line-width: 5;
    line-color: @admin-boundaries;
  }
}
*/