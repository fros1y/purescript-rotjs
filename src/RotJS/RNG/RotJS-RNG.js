"use strict";

var ROT = require('rot-js');

exports.setSeed = function (seed) {
  return function () {
    ROT.RNG.setSeed(seed);
  };
}

exports.getSeed = function () {
    return ROT.RNG.getSeed();
};

exports.getUniform = function () {
    return ROT.RNG.getUniform();
};

exports.getNormalRaw = function(mean, stddev) {
  return function () {
    return ROT.RNG.getNormal(mean, stddev);
  };
};

exports.getPercentage = function() {
    return ROT.RNG.getPercentage();
};
