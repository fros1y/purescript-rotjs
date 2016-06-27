"use strict";

exports.onDOMContentLoaded =
  function onDOMContentLoaded(action) {
    return function() {
      if (document.readyState === "interactive") {
        action();
      } else {
        document.addEventListener("DOMContentLoaded", action);
      }
      return {};
    };
  };
