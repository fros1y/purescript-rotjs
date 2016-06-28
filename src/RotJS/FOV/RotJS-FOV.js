"use strict";

var ROT = require('rot-js');

exports.preciseShadowCast = function (map) {
  var transparencyCheck = function (x, y) {
    var key = x * map.height + y;
    return map.cells[key];
  };

  var fov = new ROT.FOV.PreciseShadowcasting(transparencyCheck);
  fov.height = map.height;
  fov.width = map.width;
  return fov;
};

exports.recursiveShadowCast = function (map) {
  var transparencyCheck = function (x, y) {
      var key = x * map.height + y;
      return map.cells[key];
  };

  var fov = new ROT.FOV.RecursiveShadowcasting(transparencyCheck);
  fov.height = map.height;
  fov.width = map.width;
  return fov;
};

exports.computeRaw = function(fov, x, y, r) {
  var visibilityMap = {};
  visibilityMap.height = fov.height;
  visibilityMap.width = fov.width;
  visibilityMap.cells = [];

  var callback = function(x, y, r, visibility) {
    var key = x * fov.height + y;
    visibilityMap.cells[key] = visibility;
  };

  fov.compute(x, y, r, callback);
  return visibilityMap;
};
