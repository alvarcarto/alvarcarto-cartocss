
#roads-fill[zoom >= 0],
#bridges[zoom >= 0],
#tunnels[zoom >= 0] {
  ::fill {
    [feature = 'highway_motorway'] {
      [zoom >= 6] {
        line-width: 1.88;
        line-color: #fff;
      } [zoom >= 7] {
        line-width: 2.19;
        line-color: #fff;
      } [zoom >= 8] {
        line-width: 2.5;
        line-color: #fff;
      } [zoom >= 9] {
        line-width: 2.81;
        line-color: #fff;
      } [zoom >= 10] {
        line-width: 3.13;
        line-color: #fff;
      } [zoom >= 11] {
        line-width: 3.44;
        line-color: #fff;
      } [zoom >= 12] {
        line-width: 3.75;
        line-color: #fff;
      } [zoom >= 13] {
        line-width: 4.06;
        line-color: #fff;
      } [zoom >= 14] {
        line-width: 4.38;
        line-color: #fff;
      } [zoom >= 15] {
        line-width: 4.69;
        line-color: #fff;
      } [zoom >= 16] {
        line-width: 5;
        line-color: #fff;
      }
    }
        
    [feature = 'highway_trunk'] {
      [zoom >= 10] {
        line-width: 2.5;
        line-color: #fff;
      } [zoom >= 11] {
        line-width: 2.75;
        line-color: #fff;
      } [zoom >= 12] {
        line-width: 3;
        line-color: #fff;
      } [zoom >= 13] {
        line-width: 3.25;
        line-color: #fff;
      } [zoom >= 14] {
        line-width: 3.5;
        line-color: #fff;
      } [zoom >= 15] {
        line-width: 3.75;
        line-color: #fff;
      } [zoom >= 16] {
        line-width: 4;
        line-color: #fff;
      }
    }
        
    [feature = 'highway_primary'],
    [feature = 'highway_secondary'],
    [feature = 'highway_tertiary'] {
      [zoom >= 10] {
        line-width: 2.19;
        line-color: #fff;
      } [zoom >= 11] {
        line-width: 2.41;
        line-color: #fff;
      } [zoom >= 12] {
        line-width: 2.63;
        line-color: #fff;
      } [zoom >= 13] {
        line-width: 2.84;
        line-color: #fff;
      } [zoom >= 14] {
        line-width: 3.06;
        line-color: #fff;
      } [zoom >= 15] {
        line-width: 3.28;
        line-color: #fff;
      } [zoom >= 16] {
        line-width: 3.5;
        line-color: #fff;
      }
    }
        
    [feature = 'highway_residential'],
    [feature = 'highway_living_street'],
    [feature = 'highway_road'] {
      [zoom >= 12] {
        line-width: 2.25;
        line-color: #fff;
      } [zoom >= 13] {
        line-width: 2.44;
        line-color: #fff;
      } [zoom >= 14] {
        line-width: 2.63;
        line-color: #fff;
      } [zoom >= 15] {
        line-width: 2.81;
        line-color: #fff;
      } [zoom >= 16] {
        line-width: 3;
        line-color: #fff;
      }
    }
        
    [feature = 'highway_pedestrian'],
    [feature = 'highway_raceway'],
    [feature = 'highway_platform'],
    [feature = 'highway_steps'],
    [feature = 'highway_bridleway'],
    [feature = 'highway_footway'],
    [feature = 'highway_cycleway'],
    [feature = 'highway_track'] {
      [zoom >= 15] {
        line-width: 1.41;
        line-color: #fff;
      } [zoom >= 16] {
        line-width: 1.5;
        line-color: #fff;
      }
    }
  }
}

#junctions {
  [highway = 'motorway_junction'] {
    line-color: #fff;
  }
}
    

#bridges[zoom >= 0] {
  ::casing {
    [feature = 'highway_motorway'] {
      [zoom >= 6] {
        line-width: 1.88;
        line-color: #000;
      } [zoom >= 7] {
        line-width: 2.19;
        line-color: #000;
      } [zoom >= 8] {
        line-width: 2.5;
        line-color: #000;
      } [zoom >= 9] {
        line-width: 2.81;
        line-color: #000;
      } [zoom >= 10] {
        line-width: 3.13;
        line-color: #000;
      } [zoom >= 11] {
        line-width: 3.44;
        line-color: #000;
      } [zoom >= 12] {
        line-width: 3.75;
        line-color: #000;
      } [zoom >= 13] {
        line-width: 4.06;
        line-color: #000;
      } [zoom >= 14] {
        line-width: 4.38;
        line-color: #000;
      } [zoom >= 15] {
        line-width: 4.69;
        line-color: #000;
      } [zoom >= 16] {
        line-width: 5;
        line-color: #000;
      }
    }
        
    [feature = 'highway_trunk'] {
      [zoom >= 10] {
        line-width: 2.5;
        line-color: #000;
      } [zoom >= 11] {
        line-width: 2.75;
        line-color: #000;
      } [zoom >= 12] {
        line-width: 3;
        line-color: #000;
      } [zoom >= 13] {
        line-width: 3.25;
        line-color: #000;
      } [zoom >= 14] {
        line-width: 3.5;
        line-color: #000;
      } [zoom >= 15] {
        line-width: 3.75;
        line-color: #000;
      } [zoom >= 16] {
        line-width: 4;
        line-color: #000;
      }
    }
        
    [feature = 'highway_primary'],
    [feature = 'highway_secondary'],
    [feature = 'highway_tertiary'] {
      [zoom >= 10] {
        line-width: 2.19;
        line-color: #000;
      } [zoom >= 11] {
        line-width: 2.41;
        line-color: #000;
      } [zoom >= 12] {
        line-width: 2.63;
        line-color: #000;
      } [zoom >= 13] {
        line-width: 2.84;
        line-color: #000;
      } [zoom >= 14] {
        line-width: 3.06;
        line-color: #000;
      } [zoom >= 15] {
        line-width: 3.28;
        line-color: #000;
      } [zoom >= 16] {
        line-width: 3.5;
        line-color: #000;
      }
    }
  }
}
    

#custom-alvar-countries {
  [zoom >= 0] {
    line-width: 0;
  } [zoom >= 1] {
    line-width: 0;
  } [zoom >= 2] {
    line-width: 0;
  } [zoom >= 3] {
    line-width: 0;
  } [zoom >= 4] {
    line-width: 0;
  } [zoom >= 5] {
    line-width: 2.5;
    line-color: #fff;
  } [zoom >= 6] {
    line-width: 3;
    line-color: #fff;
  } [zoom >= 7] {
    line-width: 3.5;
    line-color: #fff;
  } [zoom >= 8] {
    line-width: 4;
    line-color: #fff;
  } [zoom >= 9] {
    line-width: 4.5;
    line-color: #fff;
  } [zoom >= 10] {
    line-width: 5;
    line-color: #fff;
  } [zoom >= 11] {
    line-width: 0;
  } [zoom >= 12] {
    line-width: 0;
  } [zoom >= 13] {
    line-width: 0;
  } [zoom >= 14] {
    line-width: 0;
  } [zoom >= 15] {
    line-width: 0;
  } [zoom >= 16] {
    line-width: 0;
  }
}
    
