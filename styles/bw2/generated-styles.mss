
#roads-fill[zoom >= 0],
#bridges[zoom >= 0],
#tunnels[zoom >= 0] {
  ::fill {
    [feature = 'highway_motorway'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #383838;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #383838;
      } [zoom >= 2] {
        line-width: 0.05;
        line-color: #383838;
      } [zoom >= 3] {
        line-width: 0.1;
        line-color: #373737;
      } [zoom >= 4] {
        line-width: 0.18;
        line-color: #363636;
      } [zoom >= 5] {
        line-width: 0.28;
        line-color: #363636;
      } [zoom >= 6] {
        line-width: 0.41;
        line-color: #353535;
      } [zoom >= 7] {
        line-width: 0.57;
        line-color: #333333;
      } [zoom >= 8] {
        line-width: 0.75;
        line-color: #323232;
      } [zoom >= 9] {
        line-width: 0.97;
        line-color: #303030;
      } [zoom >= 10] {
        line-width: 1.22;
        line-color: #2e2e2e;
      } [zoom >= 11] {
        line-width: 1.51;
        line-color: #2b2b2b;
      } [zoom >= 12] {
        line-width: 1.86;
        line-color: #282828;
      } [zoom >= 13] {
        line-width: 2.29;
        line-color: #252525;
      } [zoom >= 14] {
        line-width: 2.82;
        line-color: #202020;
      } [zoom >= 15] {
        line-width: 3.56;
        line-color: #1a1a1a;
      } [zoom >= 16] {
        line-width: 5.5;
        line-color: #0a0a0a;
      }
    }
        
    [feature = 'highway_trunk'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #4b4b4b;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #4b4b4b;
      } [zoom >= 2] {
        line-width: 0.03;
        line-color: #4b4b4b;
      } [zoom >= 3] {
        line-width: 0.07;
        line-color: #4a4a4a;
      } [zoom >= 4] {
        line-width: 0.13;
        line-color: #494949;
      } [zoom >= 5] {
        line-width: 0.21;
        line-color: #484848;
      } [zoom >= 6] {
        line-width: 0.3;
        line-color: #474747;
      } [zoom >= 7] {
        line-width: 0.41;
        line-color: #454545;
      } [zoom >= 8] {
        line-width: 0.55;
        line-color: #434343;
      } [zoom >= 9] {
        line-width: 0.7;
        line-color: #414141;
      } [zoom >= 10] {
        line-width: 0.88;
        line-color: #3e3e3e;
      } [zoom >= 11] {
        line-width: 1.1;
        line-color: #3b3b3b;
      } [zoom >= 12] {
        line-width: 1.35;
        line-color: #373737;
      } [zoom >= 13] {
        line-width: 1.66;
        line-color: #323232;
      } [zoom >= 14] {
        line-width: 2.05;
        line-color: #2d2d2d;
      } [zoom >= 15] {
        line-width: 2.59;
        line-color: #252525;
      } [zoom >= 16] {
        line-width: 4;
        line-color: #101010;
      }
    }
        
    [feature = 'highway_primary'],
    [feature = 'highway_secondary'],
    [feature = 'highway_tertiary'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #595959;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #595959;
      } [zoom >= 2] {
        line-width: 0.03;
        line-color: #595959;
      } [zoom >= 3] {
        line-width: 0.06;
        line-color: #585858;
      } [zoom >= 4] {
        line-width: 0.12;
        line-color: #575757;
      } [zoom >= 5] {
        line-width: 0.18;
        line-color: #565656;
      } [zoom >= 6] {
        line-width: 0.26;
        line-color: #555555;
      } [zoom >= 7] {
        line-width: 0.36;
        line-color: #545454;
      } [zoom >= 8] {
        line-width: 0.48;
        line-color: #525252;
      } [zoom >= 9] {
        line-width: 0.61;
        line-color: #505050;
      } [zoom >= 10] {
        line-width: 0.77;
        line-color: #4e4e4e;
      } [zoom >= 11] {
        line-width: 0.96;
        line-color: #4b4b4b;
      } [zoom >= 12] {
        line-width: 1.19;
        line-color: #484848;
      } [zoom >= 13] {
        line-width: 1.46;
        line-color: #444444;
      } [zoom >= 14] {
        line-width: 1.8;
        line-color: #3f3f3f;
      } [zoom >= 15] {
        line-width: 2.27;
        line-color: #393939;
      } [zoom >= 16] {
        line-width: 3.5;
        line-color: #272727;
      }
    }
        
    [feature = 'highway_residential'],
    [feature = 'highway_living_street'],
    [feature = 'highway_unclassified'],
    [feature = 'highway_road'],
    [feature = 'highway_service'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #bcbcbc;
      } [zoom >= 1] {
        line-width: 0;
        line-color: #bcbcbc;
      } [zoom >= 2] {
        line-width: 0.01;
        line-color: #bbbbbb;
      } [zoom >= 3] {
        line-width: 0.02;
        line-color: #b9b9b9;
      } [zoom >= 4] {
        line-width: 0.03;
        line-color: #b7b7b7;
      } [zoom >= 5] {
        line-width: 0.05;
        line-color: #b4b4b4;
      } [zoom >= 6] {
        line-width: 0.08;
        line-color: #b1b1b1;
      } [zoom >= 7] {
        line-width: 0.1;
        line-color: #adadad;
      } [zoom >= 8] {
        line-width: 0.14;
        line-color: #a8a8a8;
      } [zoom >= 9] {
        line-width: 0.18;
        line-color: #a2a2a2;
      } [zoom >= 10] {
        line-width: 0.22;
        line-color: #9b9b9b;
      } [zoom >= 11] {
        line-width: 0.44;
        line-color: #616161;
      } [zoom >= 12] {
        line-width: 0.54;
        line-color: #5a5a5a;
      } [zoom >= 13] {
        line-width: 0.67;
        line-color: #535353;
      } [zoom >= 14] {
        line-width: 0.82;
        line-color: #494949;
      } [zoom >= 15] {
        line-width: 1.04;
        line-color: #3c3c3c;
      } [zoom >= 16] {
        line-width: 1.6;
        line-color: #191919;
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
      [zoom >= 16] {
        line-width: 0.6;
        line/line-dasharray: 2,2;
        line-color: #191919;
      }
    }
        
    [feature = 'railway_rail'],
    [feature = 'railway_INT-spur-siding-yard'],
    [feature = 'railway_light_rail'],
    [feature = 'railway_funicular'],
    [feature = 'railway_narrow_gauge'],
    [feature = 'railway_miniature'],
    [feature = 'railway_preserved'],
    [feature = 'railway_INT-preserved-ssy'],
    [feature = 'railway_monorail'],
    [feature = 'railway_construction'],
    [feature = 'railway_disused'],
    [feature = 'railway_platform'],
    [feature = 'railway_turntable'] {
      [zoom >= 10] {
        line-width: 0.11;
        line-color: #747474;
      } [zoom >= 11] {
        line-width: 0.14;
        line-color: #727272;
      } [zoom >= 12] {
        line-width: 0.17;
        line-color: #707070;
      } [zoom >= 13] {
        line-width: 0.21;
        line-color: #6d6d6d;
      } [zoom >= 14] {
        line-width: 0.26;
        line-color: #6a6a6a;
      } [zoom >= 15] {
        line-width: 0.32;
        line-color: #656565;
      } [zoom >= 16] {
        line-width: 0.5;
        line-color: #595959;
      }
    }
        
    [feature = 'aeroway_runway'],
    [feature = 'aeroway_taxiway'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #666;
      } [zoom >= 1] {
        line-width: 0;
        line-color: #666;
      } [zoom >= 2] {
        line-width: 0.01;
        line-color: #666;
      } [zoom >= 3] {
        line-width: 0.02;
        line-color: #666;
      } [zoom >= 4] {
        line-width: 0.03;
        line-color: #666;
      } [zoom >= 5] {
        line-width: 0.05;
        line-color: #666;
      } [zoom >= 6] {
        line-width: 0.08;
        line-color: #666;
      } [zoom >= 7] {
        line-width: 0.1;
        line-color: #666;
      } [zoom >= 8] {
        line-width: 0.14;
        line-color: #666;
      } [zoom >= 9] {
        line-width: 0.18;
        line-color: #666;
      } [zoom >= 10] {
        line-width: 0.22;
        line-color: #666;
      } [zoom >= 11] {
        line-width: 0.28;
        line-color: #666;
      } [zoom >= 12] {
        line-width: 0.34;
        line-color: #666;
      } [zoom >= 13] {
        line-width: 0.42;
        line-color: #666;
      } [zoom >= 14] {
        line-width: 0.51;
        line-color: #666;
      } [zoom >= 15] {
        line-width: 0.65;
        line-color: #666;
      } [zoom >= 16] {
        line-width: 1;
        line-color: #666;
      }
    }
  }
}

#bridges[zoom >= 0] {
  ::casing {
    [feature = 'highway_motorway'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #383838;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #383838;
      } [zoom >= 2] {
        line-width: 0.05;
        line-color: #383838;
      } [zoom >= 3] {
        line-width: 0.1;
        line-color: #373737;
      } [zoom >= 4] {
        line-width: 0.18;
        line-color: #363636;
      } [zoom >= 5] {
        line-width: 0.28;
        line-color: #363636;
      } [zoom >= 6] {
        line-width: 0.41;
        line-color: #353535;
      } [zoom >= 7] {
        line-width: 0.57;
        line-color: #333333;
      } [zoom >= 8] {
        line-width: 0.75;
        line-color: #323232;
      } [zoom >= 9] {
        line-width: 0.97;
        line-color: #303030;
      } [zoom >= 10] {
        line-width: 1.22;
        line-color: #2e2e2e;
      } [zoom >= 11] {
        line-width: 1.51;
        line-color: #2b2b2b;
      } [zoom >= 12] {
        line-width: 1.86;
        line-color: #282828;
      } [zoom >= 13] {
        line-width: 2.29;
        line-color: #252525;
      } [zoom >= 14] {
        line-width: 2.82;
        line-color: #202020;
      } [zoom >= 15] {
        line-width: 3.56;
        line-color: #1a1a1a;
      } [zoom >= 16] {
        line-width: 5.5;
        line-color: #0a0a0a;
      }
    }
        
    [feature = 'highway_trunk'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #4b4b4b;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #4b4b4b;
      } [zoom >= 2] {
        line-width: 0.03;
        line-color: #4b4b4b;
      } [zoom >= 3] {
        line-width: 0.07;
        line-color: #4a4a4a;
      } [zoom >= 4] {
        line-width: 0.13;
        line-color: #494949;
      } [zoom >= 5] {
        line-width: 0.21;
        line-color: #484848;
      } [zoom >= 6] {
        line-width: 0.3;
        line-color: #474747;
      } [zoom >= 7] {
        line-width: 0.41;
        line-color: #454545;
      } [zoom >= 8] {
        line-width: 0.55;
        line-color: #434343;
      } [zoom >= 9] {
        line-width: 0.7;
        line-color: #414141;
      } [zoom >= 10] {
        line-width: 0.88;
        line-color: #3e3e3e;
      } [zoom >= 11] {
        line-width: 1.1;
        line-color: #3b3b3b;
      } [zoom >= 12] {
        line-width: 1.35;
        line-color: #373737;
      } [zoom >= 13] {
        line-width: 1.66;
        line-color: #323232;
      } [zoom >= 14] {
        line-width: 2.05;
        line-color: #2d2d2d;
      } [zoom >= 15] {
        line-width: 2.59;
        line-color: #252525;
      } [zoom >= 16] {
        line-width: 4;
        line-color: #101010;
      }
    }
        
    [feature = 'highway_primary'],
    [feature = 'highway_secondary'],
    [feature = 'highway_tertiary'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #595959;
      } [zoom >= 1] {
        line-width: 0.01;
        line-color: #595959;
      } [zoom >= 2] {
        line-width: 0.03;
        line-color: #595959;
      } [zoom >= 3] {
        line-width: 0.06;
        line-color: #585858;
      } [zoom >= 4] {
        line-width: 0.12;
        line-color: #575757;
      } [zoom >= 5] {
        line-width: 0.18;
        line-color: #565656;
      } [zoom >= 6] {
        line-width: 0.26;
        line-color: #555555;
      } [zoom >= 7] {
        line-width: 0.36;
        line-color: #545454;
      } [zoom >= 8] {
        line-width: 0.48;
        line-color: #525252;
      } [zoom >= 9] {
        line-width: 0.61;
        line-color: #505050;
      } [zoom >= 10] {
        line-width: 0.77;
        line-color: #4e4e4e;
      } [zoom >= 11] {
        line-width: 0.96;
        line-color: #4b4b4b;
      } [zoom >= 12] {
        line-width: 1.19;
        line-color: #484848;
      } [zoom >= 13] {
        line-width: 1.46;
        line-color: #444444;
      } [zoom >= 14] {
        line-width: 1.8;
        line-color: #3f3f3f;
      } [zoom >= 15] {
        line-width: 2.27;
        line-color: #393939;
      } [zoom >= 16] {
        line-width: 3.5;
        line-color: #272727;
      }
    }
        
    [feature = 'highway_residential'],
    [feature = 'highway_living_street'],
    [feature = 'highway_unclassified'],
    [feature = 'highway_road'],
    [feature = 'highway_service'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #bcbcbc;
      } [zoom >= 1] {
        line-width: 0;
        line-color: #bcbcbc;
      } [zoom >= 2] {
        line-width: 0.01;
        line-color: #bbbbbb;
      } [zoom >= 3] {
        line-width: 0.02;
        line-color: #b9b9b9;
      } [zoom >= 4] {
        line-width: 0.03;
        line-color: #b7b7b7;
      } [zoom >= 5] {
        line-width: 0.05;
        line-color: #b4b4b4;
      } [zoom >= 6] {
        line-width: 0.08;
        line-color: #b1b1b1;
      } [zoom >= 7] {
        line-width: 0.1;
        line-color: #adadad;
      } [zoom >= 8] {
        line-width: 0.14;
        line-color: #a8a8a8;
      } [zoom >= 9] {
        line-width: 0.18;
        line-color: #a2a2a2;
      } [zoom >= 10] {
        line-width: 0.22;
        line-color: #9b9b9b;
      } [zoom >= 11] {
        line-width: 0.44;
        line-color: #616161;
      } [zoom >= 12] {
        line-width: 0.54;
        line-color: #5a5a5a;
      } [zoom >= 13] {
        line-width: 0.67;
        line-color: #535353;
      } [zoom >= 14] {
        line-width: 0.82;
        line-color: #494949;
      } [zoom >= 15] {
        line-width: 1.04;
        line-color: #3c3c3c;
      } [zoom >= 16] {
        line-width: 1.6;
        line-color: #191919;
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
      [zoom >= 16] {
        line-width: 0.6;
        line/line-dasharray: 2,2;
        line-color: #191919;
      }
    }
        
    [feature = 'railway_rail'],
    [feature = 'railway_INT-spur-siding-yard'],
    [feature = 'railway_light_rail'],
    [feature = 'railway_funicular'],
    [feature = 'railway_narrow_gauge'],
    [feature = 'railway_miniature'],
    [feature = 'railway_preserved'],
    [feature = 'railway_INT-preserved-ssy'],
    [feature = 'railway_monorail'],
    [feature = 'railway_construction'],
    [feature = 'railway_disused'],
    [feature = 'railway_platform'],
    [feature = 'railway_turntable'] {
      [zoom >= 10] {
        line-width: 0.11;
        line-color: #747474;
      } [zoom >= 11] {
        line-width: 0.14;
        line-color: #727272;
      } [zoom >= 12] {
        line-width: 0.17;
        line-color: #707070;
      } [zoom >= 13] {
        line-width: 0.21;
        line-color: #6d6d6d;
      } [zoom >= 14] {
        line-width: 0.26;
        line-color: #6a6a6a;
      } [zoom >= 15] {
        line-width: 0.32;
        line-color: #656565;
      } [zoom >= 16] {
        line-width: 0.5;
        line-color: #595959;
      }
    }
        
    [feature = 'aeroway_runway'],
    [feature = 'aeroway_taxiway'] {
      [zoom >= 0] {
        line-width: 0;
        line-color: #666;
      } [zoom >= 1] {
        line-width: 0;
        line-color: #666;
      } [zoom >= 2] {
        line-width: 0.01;
        line-color: #666;
      } [zoom >= 3] {
        line-width: 0.02;
        line-color: #666;
      } [zoom >= 4] {
        line-width: 0.03;
        line-color: #666;
      } [zoom >= 5] {
        line-width: 0.05;
        line-color: #666;
      } [zoom >= 6] {
        line-width: 0.08;
        line-color: #666;
      } [zoom >= 7] {
        line-width: 0.1;
        line-color: #666;
      } [zoom >= 8] {
        line-width: 0.14;
        line-color: #666;
      } [zoom >= 9] {
        line-width: 0.18;
        line-color: #666;
      } [zoom >= 10] {
        line-width: 0.22;
        line-color: #666;
      } [zoom >= 11] {
        line-width: 0.28;
        line-color: #666;
      } [zoom >= 12] {
        line-width: 0.34;
        line-color: #666;
      } [zoom >= 13] {
        line-width: 0.42;
        line-color: #666;
      } [zoom >= 14] {
        line-width: 0.51;
        line-color: #666;
      } [zoom >= 15] {
        line-width: 0.65;
        line-color: #666;
      } [zoom >= 16] {
        line-width: 1;
        line-color: #666;
      }
    }
  }
}

#junctions {
  [highway = 'motorway_junction'] {
    line-color: #fff;
  }
}
    
