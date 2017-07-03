/* For performance reasons, the admin border layers are split into three groups
for low, middle and high zoom levels.
For each zoomlevel, all borders come from a single attachment, to handle
overlapping borders correctly.
*/

#admin-low-zoom[zoom < 11],
#admin-mid-zoom[zoom >= 11][zoom < 13],
#admin-high-zoom[zoom >= 13] {
  [admin_level = '2'] {
    [zoom >= 4] {
      background/line-join: bevel;
      background/line-color: red;
      background/line-width: 4;
      line-join: bevel;
      line-color: red;
      line-width: 4;
    }
    [zoom >= 5] {
      background/line-width: 5;
      line-width: 5;
    }
    [zoom >= 6] {
      background/line-width: 6;
      line-width: 6;
    }
    [zoom >= 7] {
      background/line-width: 7;
      line-width: 7;
    }
    [zoom >= 10] {
      background/line-width: 10;
      line-width: 10;
    }
  }

  /*
  The following code prevents admin boundaries from being rendered on top of
  each other. Comp-op works on the entire attachment, not on the individual
  border. Therefore, this code generates an attachment containing a set of
  red/white dashed lines (of which only the top one is visible),
  and with `comp-op: darken` the white part is ignored, while the
  red colored part is rendered (as long as the background is not
  darker than red).
  The SQL has `ORDER BY admin_level`, so the boundary with the lowest
  admin_level is rendered on top, and therefore the only visible boundary.
  */
  opacity: 1;
  comp-op: darken;
}
