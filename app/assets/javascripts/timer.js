function Timer() {
  var startTime, endTime;

  this.start = function() {
    startTime = Date.now();
  };

  this.stop = function() {
    endTime = Date.now();
  };

  this.resultTime = function() {
    return endTime - startTime;
  };
}

var timer = new Timer();