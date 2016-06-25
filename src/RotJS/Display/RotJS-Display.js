"use strict";

var ROT = require('rot-js');

exports.initDisplay = function (dimensions) {
  return function() {
    var display = new ROT.Display(dimensions);
    document.body.appendChild(display.getContainer());
    return display;
  };
};

exports.setOptionsRaw = function (display, options) {
  return function() {
    display.setOptions(options);
  };
};


exports.drawRaw = function (display, coord, string, color) {
  return function() {
    display.draw(coord.x, coord.y, string, color);
  };
};
