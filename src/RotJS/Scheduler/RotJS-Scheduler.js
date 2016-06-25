"use strict";

var ROT = require('rot-js');

exports.newSimpleScheduler = function() {
  return function() {
    var scheduler = new ROT.Scheduler.Simple();
    return scheduler;
  };
};

exports.newActionScheduler = function() {
  return function() {
    var scheduler = new ROT.Scheduler.Action();
    return scheduler;
  };
};

/*
exports.newSpeedScheduler = function() {
  return function() {
    var scheduler = new ROT.Scheduler.Speed();
    return scheduler;
  };
};*/

exports.removeRaw = function(scheduler, actor) {
  return function() {
    scheduler.remove(actor);
  };
};

exports.addRaw = function(scheduler, actor, repeat) {
  return function() {
    scheduler.add(actor, repeat);
  };
};

exports.clearRaw = function(scheduler) {
  return function() {
    scheduler.clear();
  }
}

exports.nextRaw = function(scheduler) {
  return function() {
    return scheduler.next();
  };
};

exports.setDurationRaw = function(scheduler, duration) {
  return function() {
    return scheduler.setDuration(duration);
  };
};
