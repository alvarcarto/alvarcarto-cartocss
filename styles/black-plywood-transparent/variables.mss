Map {
  background-color: @land-color;
}

@land-color: #222;
// Full white will render transparent in plywood, hence the name
@water-color: #fff;

@glacier: @water-color;
@glacier-line: darken(@water-color, 8%);

@admin-boundaries: #fff;

@bridge-color: @land-color;
@building-fill: #eee;
@building-line: lighten(@building-fill, 15%);
@building-low-zoom: lighten(@building-fill, 4%);
@building-major-fill: lighten(@building-fill, 5%);
@building-major-line: lighten(@building-major-fill, 25%);
