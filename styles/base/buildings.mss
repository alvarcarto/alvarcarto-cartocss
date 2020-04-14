
@building-line: darken(@building-fill, 15%);
@building-low-zoom: darken(@building-fill, 4%);

@building-major-fill: darken(@building-fill, 5%);
@building-major-line: darken(@building-major-fill, 25%);

@building-aeroway-fill: #fff;
@building-aeroway-line: darken(@building-aeroway-fill, 8%);


#buildings {
  [zoom >= 16] {
    polygon-fill: @building-low-zoom;
    polygon-clip: false;
    [zoom >= 15] {
      line-color: @building-line;
      polygon-fill: @building-fill;
      line-width: .75;
      line-clip: false;
    }

    [amenity = 'place_of_worship'],
    [aeroway = 'terminal'],
    [aerialway = 'station'],
    [building = 'train_station'],
    [public_transport = 'station'] {
      polygon-fill: @building-major-fill;
      [zoom >= 15] {
        polygon-fill: @building-major-fill;
        line-color: @building-major-line;
      }
    }
  }
}

#bridge {
  [zoom >= 15] {
    polygon-fill: #B8B8B8;
  }
}
