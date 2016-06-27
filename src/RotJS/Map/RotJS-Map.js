"use strict";

var ROT = require('rot-js');

var mapExport = function (map) {
    var xsize = map._width;
    var ysize = map._height;
    var mapStorage = {
      width: xsize,
      height: ysize,
      grid: [],
      rooms: [],
      corridors: []
    };

    var callback = function(x, y, value) {
      var key = x * ysize + y;
      mapStorage.grid[key] = value;
    }

    map.create(callback);

    if(map.getRooms) {
      var rooms = map.getRooms();
      for (var i=0; i<rooms.length; i++) {
        var room = {
            left: rooms[i].getLeft(),
            top: rooms[i].getTop(),
            right: rooms[i].getRight(),
            bottom: rooms[i].getBottom(),
            doors: []
          };
          if(rooms[i].getDoors) {
            var doorCallback = function(x, y) {
              room.doors.push({x: x, y: y});
            }
            rooms[i].getDoors(doorCallback);
          }
          mapStorage.rooms.push(room);
        }
      }

    if(map.getCorridors) {
      var corridors = map.getCorridors();
      for (var i=0; i<corridors.length; i++) {
        var corridor = {
          startX: corridors[i]._startX,
          startY: corridors[i]._startY,
          endX: corridors[i]._endX,
          endY: corridors[i]._endY
        }
        mapStorage.corridors.push(corridor);
      }
    }

    return mapStorage;
  }

exports.buildArenaRaw = function (xsize, ysize) {
  return function() {
    var map = new ROT.Map.Arena(xsize, ysize);
    return mapExport(map);
  };
};

exports.buildDiggerRaw = function(xsize, ysize, config) {
  return function() {
    var map = new ROT.Map.Digger(xsize, ysize, config);
    return mapExport(map);
  };
};

exports.buildUniformRaw = function(xsize, ysize, config) {
  return function() {
    var map = new ROT.Map.Uniform(xsize, ysize, config);
    return mapExport(map);
  };
};

exports.buildRogueRaw = function(xsize, ysize) {
  return function() {
    var map = new ROT.Map.Rogue(xsize, ysize);
    return mapExport(map);
  };
};
