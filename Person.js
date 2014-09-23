// Generated by CoffeeScript 1.4.0
(function() {

  window.Person = (function() {

    Person.prototype.STEP = 10;

    Person.prototype.WIDTH = 40;

    Person.prototype.HEIGHT = 40;

    Person.prototype.BULLET_COUNT = 2;

    function Person(x, y, blocks, canvasWidth, canvasHeight) {
      this.x = x;
      this.y = y;
      this.blocks = blocks;
      this.canvasWidth = canvasWidth;
      this.canvasHeight = canvasHeight;
      this.dx = this.STEP;
      this.dy = 0;
      this.width = this.WIDTH;
      this.height = this.HEIGHT;
      this.bulletCount = this.BULLET_COUNT;
    }

    Person.prototype.turnLeft = function() {
      this.dx = -this.STEP;
      return this.dy = 0;
    };

    Person.prototype.turnRight = function() {
      this.dx = this.STEP;
      return this.dy = 0;
    };

    Person.prototype.turnUp = function() {
      this.dx = 0;
      return this.dy = -this.STEP;
    };

    Person.prototype.turnDown = function() {
      this.dx = 0;
      return this.dy = this.STEP;
    };

    Person.prototype.isLeft = function() {
      return this.dx < 0;
    };

    Person.prototype.isRight = function() {
      return this.dx > 0;
    };

    Person.prototype.isUp = function() {
      return this.dy < 0;
    };

    Person.prototype.isDown = function() {
      return this.dy > 0;
    };

    Person.prototype.move = function() {
      var block, _i, _len, _ref;
      if (this.changePersonsDirectionDependingOnEdge()) {
        return;
      }
      _ref = this.blocks;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        block = _ref[_i];
        if (this.changePersonsDirectionDependingOnBlock(block)) {
          return;
        }
      }
      this.x += this.dx;
      return this.y += this.dy;
    };

    Person.prototype.isNextXStepMoreThanEdge = function(edge) {
      return this.x + this.width + this.dx >= edge;
    };

    Person.prototype.isNextYStepMoreThanEdge = function(edge) {
      return this.y + this.height + this.dy >= edge;
    };

    Person.prototype.isNextXStepLessThanEdge = function(edge) {
      return this.x + this.dx <= edge;
    };

    Person.prototype.isNextYStepLessThanEdge = function(edge) {
      return this.y + this.dy <= edge;
    };

    Person.prototype.isPersonOnTheRightSide = function(edge) {
      return this.x >= edge;
    };

    Person.prototype.isPersonOnTheLeftSide = function(edge) {
      return this.x + this.width <= edge;
    };

    Person.prototype.isPersonHigher = function(edge) {
      return this.y + this.height <= edge;
    };

    Person.prototype.isPersonLower = function(edge) {
      return this.y >= edge;
    };

    Person.prototype.isPersonOnTheLineOfBlock = function(block) {
      return (this.y + this.height > block.y && this.y + this.height < block.y + block.height) || (this.y < block.y + block.height && this.y > block.y);
    };

    Person.prototype.isPersonOnTheRowOfBlock = function(block) {
      return (this.x + this.width > block.x && this.x + this.width < block.x + block.width) || (this.x < block.x + block.width && this.x > block.x);
    };

    Person.prototype.changePersonsDirectionDependingOnBlock = function(block) {
      if (this.isNextXStepMoreThanEdge(block.x) && this.isPersonOnTheLeftSide(block.x) && this.isPersonOnTheLineOfBlock(block)) {
        this.x = block.x - 2 * this.width - this.dx + block.x - this.x;
        this.dx = -this.dx;
        return true;
      }
      if (this.isNextXStepLessThanEdge(block.x + block.width) && this.isPersonOnTheRightSide(block.x + block.width) && this.isPersonOnTheLineOfBlock(block)) {
        this.x = block.x + block.width - this.dx - (this.x - block.x - block.width);
        this.dx = -this.dx;
        return true;
      }
      if (this.isNextYStepMoreThanEdge(block.y) && this.isPersonHigher(block.y) && this.isPersonOnTheRowOfBlock(block)) {
        this.y = block.y - 2 * this.height - this.dy + block.y - this.y;
        this.dy = -this.dy;
        return true;
      }
      if (this.isNextYStepLessThanEdge(block.y + block.height) && this.isPersonLower(block.y + block.height) && this.isPersonOnTheRowOfBlock(block)) {
        this.y = block.y + block.height - this.dy - (this.y - block.y - block.height);
        this.dy = -this.dy;
        return true;
      }
      return false;
    };

    Person.prototype.changePersonsDirectionDependingOnEdge = function(person) {
      if (this.isNextXStepMoreThanEdge(this.canvasWidth)) {
        this.x = this.canvasWidth - 2 * this.width - this.dx + this.canvasWidth - this.x;
        this.dx = -this.dx;
        return true;
      }
      if (this.isNextXStepLessThanEdge(0)) {
        this.x = -this.x - this.dx;
        this.dx = -this.dx;
        return true;
      }
      if (this.isNextYStepMoreThanEdge(this.canvasHeight)) {
        this.y = this.canvasHeight - 2 * this.height - this.dy + this.canvasHeight - this.y;
        this.dy = -this.dy;
        return true;
      }
      if (this.isNextYStepLessThanEdge(0)) {
        this.y = -this.y - this.dy;
        this.dy = -this.dy;
        return true;
      }
      return false;
    };

    return Person;

  })();

}).call(this);