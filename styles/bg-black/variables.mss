Map {
  background-color: @land-color;
}

@land-color: #000;
@water-color: #777;

@glacier: @water-color;
@glacier-line: darken(@water-color, 8%);

@admin-boundaries: #000;

@bridge-color: @land-color;
@building-fill: @land-color;
@building-line: lighten(@building-fill, 15%);
@building-low-zoom: lighten(@building-fill, 4%);
@building-major-fill: @land-color;
@building-major-line: lighten(@building-major-fill, 25%);
