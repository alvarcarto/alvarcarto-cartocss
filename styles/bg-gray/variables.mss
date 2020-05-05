// Main variables

Map {
  background-color: @land-color;
}

@water-color: #f4f4f4;
@land-color: #ddd;

@glacier: @water-color;
@glacier-line: darken(@water-color, 8%);

@admin-boundaries: #000;

@building-fill: #888;
@bridge-color: @land-color;

@bridge-color: @land-color;
@building-fill: darken(@land-color, 10%);
@building-line: darken(@building-fill, 15%);
@building-low-zoom: darken(@building-fill, 4%);
@building-major-fill: darken(@land-color, 5%);
@building-major-line: darken(@building-major-fill, 25%);
