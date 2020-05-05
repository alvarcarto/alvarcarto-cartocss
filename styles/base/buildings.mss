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
  [zoom >= 10] {
    polygon-fill: @bridge-color;
  }
}
