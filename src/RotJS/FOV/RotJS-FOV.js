"use strict";

var ROT = require('rot-js');

exports.preciseShadowCast = function (transparencyCheck) {
  var fov = new ROT.FOV.PreciseShadowcasting(transparencyCheck);
  return fov;
};

exports.recursiveShadowCast = function (transparencyCheck) {
  var fov = new ROT.FOV.RecursiveShadowcasting(transparencyCheck);
  return fov;
};

exports.computeRaw = function(fov, x, y, r) {
  var visibilityMap = [];

  var callback = function(x, y, r, visibility) {
    var key = x * ysize + y;
    visibilityMap[key] = {
                            visible: visibility,
                            distance: r
                          };
  };

  fov.compute(x, y, r, callback);
  return visibilityMap;
};
