/*
To simplify the borders, see https://github.com/gravitystorm/openstreetmap-carto/blob/ea73a44105ad1c3a0ebff817d4a8e9ea9233124b/admin.mss
*/

#custom-alvar-countries {
  [zoom >= 1] {
    line-width: 3;
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
