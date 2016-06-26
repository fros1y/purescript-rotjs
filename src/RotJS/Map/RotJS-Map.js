"use strict";

var ROT = require('rot-js');

exports.buildArenaRaw = function (xsize, ysize) {
    var map = new ROT.Map.Arena(xsize, ysize);
    var mapStorage = [];

    var callback = function(x, y, value) {
      var key = x * ysize + y;
      mapStorage[key] = value;
    }

    map.create(callback);
    return mapStorage;
};
