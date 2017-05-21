# Alvar Carto CartoCSS styles

![screenshot](docs/screenshot.png)

These are the CartoCSS map stylesheets for Alvar Carto. They are used to render maps, which you can see at https://design.alvarcarto.com.

Services which are using these styles:

* https://github.com/kimmobrunfeldt/alvarcarto-tile-service
* https://github.com/kimmobrunfeldt/alvarcarto-render-service

Forked from: https://github.com/gravitystorm/openstreetmap-carto

## Usage

To compile CartoCSS projects to mapnik XML styles, run:

```bash
npm install
npm run build
```

## CI setup

On each push to master, these mapnik styles are deployed to `alvar-map-qa` server.

