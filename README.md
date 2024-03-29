# Alvar Carto CartoCSS styles

![screenshot](docs/screenshot.png)

These are the CartoCSS map stylesheets for Alvar Carto. They are used to render maps, which you can see at https://design.alvarcarto.com.

Services which are using these styles:

* https://github.com/kimmobrunfeldt/alvarcarto-tile-service
* https://github.com/kimmobrunfeldt/alvarcarto-render-service

The scale of these styles is designed so that rendering to 256x256 pixels with
scale 1 provides correct result. When rendering the final posters, where canvas size
is thousands of pixels, we're applying a scale multiplier to mapnik rendering.

*Forked from: https://github.com/gravitystorm/openstreetmap-carto*

## Differences to original openstreetmap-carto project

* No labels or texts
* Roads, tunnels and bridges are shown already at zoom level 5 for artistic reasons
* Different postgis connection details
* Our customized country borders in project.mml (custom-alvar-countries)
* Optimized roads and tunnels SQL queries, we basically removed [ORDER BY](https://github.com/gravitystorm/openstreetmap-carto/blob/597d138c85eb11428a41ea332332b284e8041f48/project.mml#L751-L758) to increase performance.


### How build process works

The aim is that each style contains only the necessary declarations for that style. All common parts
are under [styles/base/](styles/base/) directory. The base styles can be configured via variables.

[tools/build.sh](tools/build.sh):

1. Convert template MMLs to full project files

    CartoCSS style's index file is project.mml. This file contains the SQL queries to get
    roads, buildings, etc. The project file is 99% same for all our styles, except the "Stylesheet"
    declaration. That's why our individual styles only define `project-sheet.mml` and it will
    be injected into `styles/base/project-template.mml`.

2. Convert `styles.js` declaration to actual CartoCSS to `generated-styles.mss` file.

    The `styles.js` uses our internal convenience format for generating styles for roads. It can
    be used for other generation as well.

    The main benefit of using this automation is to be able to generate consistent styles for each
    zoom level, using line color and thicnkess intepolation with given easing function. It removes
    the need to fine tune each zoom level color and thickness manually.

3. Compile the CartoCSS project with [https://github.com/mapbox/carto] to Mapnik XML stylesheet.



### Developing a new style

* First start the docker environment (postgres and render service)
* `cp -r styles/bw styles/new-style`
* Check that `project-sheet.mml` contains everything you need. Optionally add e.g. `../base/landcover.mss`.
* Edit `variables.mss` for land, water, and building colors
* Edit roads with `styles.js`. Other files already contain examples how to modify or extend the styles.
* Run `bash tools/build.sh new-style` to build the style
* Run `node tools/diff.js bw new-style` to render comparison images of different zoom levels

    The script will output images under `images/diff/` directory. It will fetch `new-style` from local
    docker environment and `bw` style from the current production environment for comparison.


## Usage

To compile CartoCSS projects to mapnik XML styles, run:

```bash
npm run bash

# Inside docker:
npm install
npm run build
```

Many warnings are generated by newer carto version, see: https://github.com/gravitystorm/openstreetmap-carto/issues/3183.


## Local development

Install docker setup first, then run:

```bash
npm run watch
```

## Docker setup

To download data files

```bash
npm run bash

# Note: for some reason get-shapefiles.py needs to be inside a directory, instead of being in the root
#       of the repo. Probably some bug in path joining code.
curl -o tools/get-shapefiles.py https://raw.githubusercontent.com/gravitystorm/openstreetmap-carto/master/scripts/get-shapefiles.py
python3 tools/get-shapefiles.py -f -d ../dist/data/
```

## Debugging maps

To see exact names of data layers, use OpenStreeMap Editor: https://www.openstreetmap.org/edit. You need to login first.



## Analyzing road counts

To estimate how many roads there are with certain feature, use the explain query below.
The query has been formed from the `base/project-template.mml` roads_sql table. ORDER BY was manually
removed from the query since it's not needed here and makes it very intensive.

The response will look like:
```
   ->  Append  (cost=1000.00..33820224.54 rows=767782 width=0)
         ->  Subquery Scan on "*SELECT* 1"  (cost=1000.00..13811514.83 rows=754462 width=0)
```

the total estimated rows is written as `rows=767782`. You can optionally use `EXPLAIN analyze` to actually
execute the query. It took 200 seconds with highway_motorway.

**Query:**

```sql
EXPLAIN
    SELECT COUNT(*) FROM
        (SELECT
          way,
          (CASE WHEN feature IN ('highway_motorway_link', 'highway_trunk_link', 'highway_primary_link', 'highway_secondary_link', 'highway_tertiary_link') THEN substr(feature, 0, length(feature)-4) ELSE feature END) AS feature,
          horse,
          foot,
          bicycle,
          tracktype,
          int_surface,
          access,
          construction,
          service,
          link,
          layernotnull
        FROM ( -- subselect that contains both roads and rail/aero
          SELECT
              way,
              ('highway_' || highway) AS feature, --only motorway to tertiary links are accepted later on
              horse,
              foot,
              bicycle,
              tracktype,
              CASE WHEN surface IN ('unpaved', 'compacted', 'dirt', 'earth', 'fine_gravel', 'grass', 'grass_paver', 'gravel', 'ground',
                                    'mud', 'pebblestone', 'salt', 'sand', 'woodchips', 'clay', 'ice', 'snow') THEN 'unpaved'
                WHEN surface IN ('paved', 'asphalt', 'cobblestone', 'cobblestone:flattened', 'sett', 'concrete', 'concrete:lanes',
                                    'concrete:plates', 'paving_stones', 'metal', 'wood', 'unhewn_cobblestone') THEN 'paved'
              END AS int_surface,
              CASE WHEN access IN ('destination') THEN 'destination'::text
                WHEN access IN ('no', 'private') THEN 'no'::text
              END AS access,
              construction,
              CASE
                WHEN service IN ('parking_aisle', 'drive-through', 'driveway') OR leisure IN ('slipway') THEN 'INT-minor'::text
                ELSE 'INT-normal'::text
              END AS service,
              CASE
                WHEN highway IN ('motorway_link', 'trunk_link', 'primary_link', 'secondary_link', 'tertiary_link') THEN 'yes'
                ELSE 'no'
              END AS link,
              COALESCE(layer,0) AS layernotnull,
              osm_id,
              z_order
            FROM planet_osm_line
            WHERE (tunnel IS NULL OR NOT tunnel IN ('yes', 'building_passage'))
              AND (covered IS NULL OR NOT covered = 'yes')
              AND (bridge IS NULL OR NOT bridge IN ('yes', 'boardwalk', 'cantilever', 'covered', 'low_water_crossing', 'movable', 'trestle', 'viaduct'))
              AND highway IS NOT NULL -- end of road select
          UNION ALL
          SELECT
              way,
              ('railway_' || (CASE WHEN railway = 'preserved' AND service IN ('spur', 'siding', 'yard') THEN 'INT-preserved-ssy'::text
                                    WHEN (railway = 'rail' AND service IN ('spur', 'siding', 'yard')) THEN 'INT-spur-siding-yard'
                                    WHEN (railway = 'tram' AND service IN ('spur', 'siding', 'yard')) THEN 'tram-service'
                                    ELSE railway END)) AS feature,
              horse,
              foot,
              bicycle,
              tracktype,
              'null',
              CASE
                WHEN access IN ('destination') THEN 'destination'::text
                WHEN access IN ('no', 'private') THEN 'no'::text
              END AS access,
              construction,
              CASE WHEN service IN ('parking_aisle', 'drive-through', 'driveway') OR leisure IN ('slipway') THEN 'INT-minor'::text ELSE 'INT-normal'::text END AS service,
              'no' AS link,
              COALESCE(layer,0) AS layernotnull,
              osm_id,
              z_order
            FROM planet_osm_line
            WHERE (tunnel IS NULL OR NOT tunnel IN ('yes', 'building_passage'))
              AND (covered IS NULL OR NOT covered = 'yes')
              AND (bridge IS NULL OR NOT bridge IN ('yes', 'boardwalk', 'cantilever', 'covered', 'low_water_crossing', 'movable', 'trestle', 'viaduct'))
              AND railway IS NOT NULL -- end of rail select
          ) AS features
        ) AS roads_sql
    WHERE roads_sql.feature = 'highway_motorway';
```



## Optimizing roads query

The query below returns all roads for given area (limited with ST_SetSRID if I understand correctly). The query is part of the OSM render stack, originated from here: https://github.com/gravitystorm/openstreetmap-carto/blob/597d138c85eb11428a41ea332332b284e8041f48/project.mml#L672.
It will be executed when map tile is requested and the tile image has not been yet cached to disk.

The whole database containing osm planet data is around 500GB on disk. However the query only fetches roads from `osm_planet_line` table,
which contains `200 919 055` rows.



### Explain analyze results

```sql
                                                                                                                                                                                                                                                                            QUERY PLAN
------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
 Subquery Scan on roads_sql  (cost=10795766.32..10961186.81 rows=4411213 width=64) (actual time=85682.250..88754.771 rows=4305385 loops=1)
   ->  Sort  (cost=10795766.32..10806794.35 rows=4411213 width=635) (actual time=85682.232..86446.105 rows=4305385 loops=1)
         Sort Key: "*SELECT* 1".layernotnull, "*SELECT* 1".z_order, (CASE WHEN ("substring"("*SELECT* 1".feature, 1, 8) = 'railway_'::text) THEN 2 ELSE 1 END), (CASE WHEN ("*SELECT* 1".feature = ANY ('{railway_INT-preserved-ssy,railway_INT-spur-siding-yard,railway_tram-service}'::text[])) THEN 0 ELSE 1 END), (CASE WHEN ("*SELECT* 1".access = ANY ('{no,private}'::text[])) THEN 0 WHEN ("*SELECT* 1".access = 'destination'::text) THEN 1 ELSE 2 END), (CASE WHEN ("*SELECT* 1".int_surface = 'unpaved'::text) THEN 0 ELSE 2 END), "*SELECT* 1".osm_id
         Sort Method: quicksort  Memory: 1849486kB
         ->  Result  (cost=133014.27..10308928.44 rows=4411213 width=635) (actual time=8817.394..17055.073 rows=4305385 loops=1)
               ->  Append  (cost=133014.27..10132479.92 rows=4411213 width=395) (actual time=8817.385..15310.492 rows=4305385 loops=1)
                     ->  Subquery Scan on "*SELECT* 1"  (cost=133014.27..5223847.72 rows=4334682 width=395) (actual time=8817.384..13603.950 rows=4239303 loops=1)
                           ->  Bitmap Heap Scan on planet_osm_line  (cost=133014.27..5180500.90 rows=4334682 width=619) (actual time=8817.384..13274.341 rows=4239303 loops=1)
                                 Recheck Cond: (way && '01030000A0110F00000100000005000000CC183A68F4A92C41D257E2E334785B410000000000000000CC183A68F4A92C41066FF8FE585161410000000000000000A4922B4E777F4541066FF8FE585161410000000000000000A4922B4E777F4541D257E2E334785B410000000000000000CC183A68F4A92C41D257E2E334785B410000000000000000'::geometry)
                                 Filter: ((highway IS NOT NULL) AND ((tunnel IS NULL) OR (tunnel <> ALL ('{yes,building_passage}'::text[]))) AND ((covered IS NULL) OR (covered <> 'yes'::text)) AND ((bridge IS NULL) OR (bridge <> ALL ('{yes,boardwalk,cantilever,covered,low_water_crossing,movable,trestle,viaduct}'::text[]))))
                                 Rows Removed by Filter: 1723208
                                 Heap Blocks: exact=255256
                                 ->  Bitmap Index Scan on planet_osm_line_way_idx  (cost=0.00..131930.60 rows=5771793 width=0) (actual time=8748.727..8748.727 rows=5962511 loops=1)
                                       Index Cond: (way && '01030000A0110F00000100000005000000CC183A68F4A92C41D257E2E334785B410000000000000000CC183A68F4A92C41066FF8FE585161410000000000000000A4922B4E777F4541066FF8FE585161410000000000000000A4922B4E777F4541D257E2E334785B410000000000000000CC183A68F4A92C41D257E2E334785B410000000000000000'::geometry)
                     ->  Subquery Scan on "*SELECT* 2"  (cost=132949.73..4908632.20 rows=76531 width=395) (actual time=740.626..1485.598 rows=66082 loops=1)
                           ->  Gather  (cost=132949.73..4907866.89 rows=76531 width=619) (actual time=740.625..1483.965 rows=66082 loops=1)
                                 Workers Planned: 2
                                 Workers Launched: 2
                                 ->  Parallel Bitmap Heap Scan on planet_osm_line planet_osm_line_1  (cost=131949.73..4898041.91 rows=31888 width=619) (actual time=736.054..1515.276 rows=22027 loops=3)
                                       Recheck Cond: (way && '01030000A0110F00000100000005000000CC183A68F4A92C41D257E2E334785B410000000000000000CC183A68F4A92C41066FF8FE585161410000000000000000A4922B4E777F4541066FF8FE585161410000000000000000A4922B4E777F4541D257E2E334785B410000000000000000CC183A68F4A92C41D257E2E334785B410000000000000000'::geometry)
                                       Filter: ((railway IS NOT NULL) AND ((tunnel IS NULL) OR (tunnel <> ALL ('{yes,building_passage}'::text[]))) AND ((covered IS NULL) OR (covered <> 'yes'::text)) AND ((bridge IS NULL) OR (bridge <> ALL ('{yes,boardwalk,cantilever,covered,low_water_crossing,movable,trestle,viaduct}'::text[]))))
                                       Rows Removed by Filter: 1965476
                                       Heap Blocks: exact=77480
                                       ->  Bitmap Index Scan on planet_osm_line_way_idx  (cost=0.00..131930.60 rows=5771793 width=0) (actual time=643.579..643.579 rows=5962511 loops=1)
                                             Index Cond: (way && '01030000A0110F00000100000005000000CC183A68F4A92C41D257E2E334785B410000000000000000CC183A68F4A92C41066FF8FE585161410000000000000000A4922B4E777F4541066FF8FE585161410000000000000000A4922B4E777F4541D257E2E334785B410000000000000000CC183A68F4A92C41D257E2E334785B410000000000000000'::geometry)
 Planning time: 1.762 ms
 Execution time: 89015.260 ms
(27 rows)
```


### Actual query

```sql
EXPLAIN analyze SELECT ST_AsBinary("way") AS geom,"feature" FROM (SELECT
    way,
    (CASE WHEN feature IN ('highway_motorway_link', 'highway_trunk_link', 'highway_primary_link', 'highway_secondary_link', 'highway_tertiary_link') THEN substr(feature, 0, length(feature)-4) ELSE feature END) AS feature,
    horse,
    foot,
    bicycle,
    tracktype,
    int_surface,
    access,
    construction,
    service,
    link,
    layernotnull
  FROM ( -- subselect that contains both roads and rail/aero
    SELECT
        way,
        ('highway_' || highway) AS feature, --only motorway to tertiary links are accepted later on
        horse,
        foot,
        bicycle,
        tracktype,
        CASE WHEN surface IN ('unpaved', 'compacted', 'dirt', 'earth', 'fine_gravel', 'grass', 'grass_paver', 'gravel', 'ground',
                              'mud', 'pebblestone', 'salt', 'sand', 'woodchips', 'clay', 'ice', 'snow') THEN 'unpaved'
          WHEN surface IN ('paved', 'asphalt', 'cobblestone', 'cobblestone:flattened', 'sett', 'concrete', 'concrete:lanes',
                              'concrete:plates', 'paving_stones', 'metal', 'wood', 'unhewn_cobblestone') THEN 'paved'
        END AS int_surface,
        CASE WHEN access IN ('destination') THEN 'destination'::text
          WHEN access IN ('no', 'private') THEN 'no'::text
        END AS access,
        construction,
        CASE
          WHEN service IN ('parking_aisle', 'drive-through', 'driveway') OR leisure IN ('slipway') THEN 'INT-minor'::text
          ELSE 'INT-normal'::text
        END AS service,
        CASE
          WHEN highway IN ('motorway_link', 'trunk_link', 'primary_link', 'secondary_link', 'tertiary_link') THEN 'yes'
          ELSE 'no'
        END AS link,
        COALESCE(layer,0) AS layernotnull,
        osm_id,
        z_order
      FROM planet_osm_line
      WHERE (tunnel IS NULL OR NOT tunnel IN ('yes', 'building_passage'))
        AND (covered IS NULL OR NOT covered = 'yes')
        AND (bridge IS NULL OR NOT bridge IN ('yes', 'boardwalk', 'cantilever', 'covered', 'low_water_crossing', 'movable', 'trestle', 'viaduct'))
        AND highway IS NOT NULL -- end of road select
    UNION ALL
    SELECT
        way,
        ('railway_' || (CASE WHEN railway = 'preserved' AND service IN ('spur', 'siding', 'yard') THEN 'INT-preserved-ssy'::text
                              WHEN (railway = 'rail' AND service IN ('spur', 'siding', 'yard')) THEN 'INT-spur-siding-yard'
                              WHEN (railway = 'tram' AND service IN ('spur', 'siding', 'yard')) THEN 'tram-service'
                              ELSE railway END)) AS feature,
        horse,
        foot,
        bicycle,
        tracktype,
        'null',
        CASE
          WHEN access IN ('destination') THEN 'destination'::text
          WHEN access IN ('no', 'private') THEN 'no'::text
        END AS access,
        construction,
        CASE WHEN service IN ('parking_aisle', 'drive-through', 'driveway') OR leisure IN ('slipway') THEN 'INT-minor'::text ELSE 'INT-normal'::text END AS service,
        'no' AS link,
        COALESCE(layer,0) AS layernotnull,
        osm_id,
        z_order
      FROM planet_osm_line
      WHERE (tunnel IS NULL OR NOT tunnel IN ('yes', 'building_passage'))
        AND (covered IS NULL OR NOT covered = 'yes')
        AND (bridge IS NULL OR NOT bridge IN ('yes', 'boardwalk', 'cantilever', 'covered', 'low_water_crossing', 'movable', 'trestle', 'viaduct'))
        AND railway IS NOT NULL -- end of rail select
    ) AS features
  ORDER BY
    layernotnull,
    z_order,
    CASE WHEN substring(feature for 8) = 'railway_' THEN 2 ELSE 1 END,
    CASE WHEN feature IN ('railway_INT-preserved-ssy', 'railway_INT-spur-siding-yard', 'railway_tram-service') THEN 0 ELSE 1 END,
    CASE WHEN access IN ('no', 'private') THEN 0 WHEN access IN ('destination') THEN 1 ELSE 2 END,
    CASE WHEN int_surface IN ('unpaved') THEN 0 ELSE 2 END,
    osm_id
) AS roads_sql WHERE "way" && ST_SetSRID('BOX3D(939258.2035682439 7200979.560689883,2817774.610704737 9079495.967826378)'::box3d, 3857);
```

By removing ORDER BY from the query at low zoom levels, we were able to increase the performance.

