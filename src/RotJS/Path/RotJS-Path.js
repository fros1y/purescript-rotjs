"use strict";

var ROT = require('rot-js');

exports.dijkstraRaw = function(map, targetx, targety) {
    var traverseCheck = function (x, y) {
      var key = x * map.height + y;
      return map.cells[key];
    };

    var pathgen = new ROT.Path.Dijkstra(targetx, targety, traverseCheck);
    return pathgen;
};

exports.aStarRaw = function(map, targetx, targety) {
    var traverseCheck = function (x, y) {
      var key = x * map.height + y;
      return map.cells[key];
    };

    var pathgen = new ROT.Path.AStar(targetx, targety, traverseCheck);
    return pathgen;
};

exports.computeRaw = function(pathgen, x, y) {
  var path = [];

  var callback = function(x, y) {
    path.push({x: x, y: y});
  };

  fov.compute(x, y, path);
  return path;
};
