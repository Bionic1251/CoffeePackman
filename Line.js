// Generated by CoffeeScript 1.4.0
(function() {

  window.Line = (function() {

    function Line(startPoint, endPoint) {
      this.startPoint = startPoint;
      this.endPoint = endPoint;
    }

    Line.prototype.getX0 = function() {
      return this.startPoint.x;
    };

    Line.prototype.getX1 = function() {
      return this.endPoint.x;
    };

    Line.prototype.getY0 = function() {
      return this.startPoint.y;
    };

    Line.prototype.getY1 = function() {
      return this.endPoint.y;
    };

    Line.prototype.isVertical = function() {
      return this.getX0() === this.getX1();
    };

    Line.prototype.isPointOnLine = function(point, step) {
      return point.x <= this.getX1() + step && point.x >= this.getX0() - step && point.y <= this.getY1() + step && point.y >= this.getY0() - step;
    };

    return Line;

  })();

}).call(this);
