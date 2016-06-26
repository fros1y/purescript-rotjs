"use strict";

var ROT = require('rot-js');

var mapExport = function (map) {
    var mapStorage = [];
    var xsize = map._width;
    var ysize = map._height;
    var callback = function(x, y, value) {
      var key = x * ysize + y;
      mapStorage[key] = value;
    }
    map.create(callback);
    return mapStorage;
  }

exports.buildArenaRaw = function (xsize, ysize) {
  return function() {
    var map = new ROT.Map.Arena(xsize, ysize);
    return mapExport(map);
  };
};

exports.buildDiggerRaw = function(xsize, ysize) {
  return function() {
    var map = new ROT.Map.Digger(xsize, ysize);
    return mapExport(map);
  };
};

exports.buildUniformRaw = function(xsize, ysize) {
  return function() {
    var map = new ROT.Map.Uniform(xsize, ysize);
    return mapExport(map);
  };
};

exports.buildRogueRaw = function(xsize, ysize) {
  var map = new ROT.Map.Rogue(xsize, ysize);
  return mapExport(map);
};
