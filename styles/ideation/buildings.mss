@building-fill: #fff; //Lch(84, 5, 70)
@building-line: darken(@building-fill, 15%);
@building-low-zoom: darken(@building-fill, 4%);

@building-major-fill: darken(@building-fill, 5%);
@building-major-line: darken(@building-major-fill, 25%);

@building-aeroway-fill: #fff;
@building-aeroway-line: darken(@building-aeroway-fill, 8%);


#buildings {
  [zoom >= 17] {
    polygon-fill: @building-low-zoom;
    polygon-clip: false;
    [zoom >= 15] {
      line-color: @building-line;
      polygon-fill: @building-fill;
      line-width: .75;
      line-clip: false;
    }
  }
}

#buildings-major {
  [zoom >= 17] {
    [aeroway = 'terminal'] {
      polygon-fill: @building-aeroway-fill;
      polygon-clip: false;
      [zoom >= 17] {
        line-width: .75;
        line-clip: false;
        line-color: @building-aeroway-line;
      }
    }
    [amenity = 'place_of_worship'],
    [building = 'train_station'] {
      polygon-fill: @building-major-fill;
      polygon-clip: false;
      [zoom >= 17] {
        line-width: .75;
        line-clip: false;
        line-color: @building-major-line;
      }
    }
  }
}

#bridge {
  [zoom >= 15] {
    polygon-fill: #fff;
  }
}
