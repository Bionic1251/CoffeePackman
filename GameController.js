// Generated by CoffeeScript 1.4.0
(function() {

  window.GameController = (function() {
    var GAME_FINISHED, GAME_INTRO, GAME_NOT_STARTED, GAME_STARTED;

    GameController.prototype.LEFT_KEY = 37;

    GameController.prototype.UP_KEY = 38;

    GameController.prototype.RIGHT_KEY = 39;

    GameController.prototype.DOWN_KEY = 40;

    GameController.prototype.SPACE_KEY = 32;

    GAME_INTRO = "intro";

    GAME_NOT_STARTED = "gameNotStarted";

    GAME_STARTED = "gameStarted";

    GAME_FINISHED = "gameFinished";

    function GameController(canvas) {
      this.canvas = canvas;
      this.gameState = GAME_INTRO;
      this.context = this.canvas.getContext("2d");
      this.paddingTop = 100;
      this.canvasWidth = this.canvas.width;
      this.canvasHeight = this.canvas.height - this.paddingTop;
    }

    GameController.prototype.init = function() {
      this.frameNumber = 0;
      this.ghosts = [];
      this.blocks = [];
      this.bullets = [];
      this.lines = [];
      this.ammunitions = [];
      this.generateBlocks();
      this.generateLines();
      this.generateGhosts();
      this.person = new Person(33, 33, this.blocks, this.canvasWidth, this.canvasHeight);
      this.picsLoader = new PicsLoader();
      return this.painter = new Painter(this.context, this.canvasWidth, this.canvasHeight, this.person, this.ghosts, this.blocks, this.bullets, this.lines, this.ammunitions, this.picsLoader, this.paddingTop);
    };

    GameController.prototype.generateGhosts = function() {
      var i, _i, _results;
      _results = [];
      for (i = _i = 0; _i <= 4; i = ++_i) {
        _results.push(this.createGhost());
      }
      return _results;
    };

    GameController.prototype.createGhost = function() {
      var line, x, y;
      line = this.lines[7];
      if (!line.isVertical()) {
        y = line.getY0();
        x = line.getX0() + Math.random() * (line.getX1() - line.getX0());
      } else {
        x = line.getX0();
        y = line.getY0() + Math.random() * (line.getY1() - line.getY0());
      }
      return this.ghosts.push(new Ghost(x, y, this.blocks, this.canvasWidth, this.canvasHeight, line, this.lines));
    };

    GameController.prototype.getRandomLine = function() {
      var line, _i, _len, _ref;
      _ref = this.lines;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        line = _ref[_i];
        if (Math.random() > 0.5) {
          return line;
        }
      }
      return line;
    };

    GameController.prototype.repaint = function() {
      return this.painter.repaint(this.frameNumber, this.gameState);
    };

    GameController.prototype.moveEveryone = function() {
      var ammunition, bullet, person, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
      this.updateDeadHeroes();
      this.generateAmmunitionIfNecessary();
      if (this.isPersonCaught()) {
        this.gameState = GAME_FINISHED;
      }
      this.person.move();
      _ref = this.ghosts;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        person = _ref[_i];
        person.move();
      }
      _ref1 = this.bullets;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        bullet = _ref1[_j];
        bullet.move();
      }
      _ref2 = this.ammunitions;
      _results = [];
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        ammunition = _ref2[_k];
        _results.push(ammunition.move());
      }
      return _results;
    };

    GameController.prototype.generateAmmunitionIfNecessary = function() {
      var line, x, y;
      line = this.getRandomLine();
      if (this.frameNumber % 220 === 0) {
        line = this.getRandomLine();
        if (!line.isVertical()) {
          y = line.getY0();
          x = line.getX0() + Math.random() * (line.getX1() - line.getX0());
        } else {
          x = line.getX0();
          y = line.getY0() + Math.random() * (line.getY1() - line.getY0());
        }
        return this.ammunitions.push(new Ammunition(this.person, this.blocks, x, y));
      }
    };

    GameController.prototype.updateDeadHeroes = function() {
      var ammunition, bullet, ghost, _i, _j, _k, _len, _len1, _len2, _ref, _ref1, _ref2, _results;
      _ref = this.ghosts;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ghost = _ref[_i];
        if (!ghost.isAlive) {
          this.ghosts.splice(this.ghosts.indexOf(ghost), 1);
          this.createGhost();
        }
      }
      _ref1 = this.bullets;
      for (_j = 0, _len1 = _ref1.length; _j < _len1; _j++) {
        bullet = _ref1[_j];
        if (!bullet.isAlive) {
          this.bullets.splice(this.bullets.indexOf(bullet), 1);
        }
      }
      _ref2 = this.ammunitions;
      _results = [];
      for (_k = 0, _len2 = _ref2.length; _k < _len2; _k++) {
        ammunition = _ref2[_k];
        if (!ammunition.isAlive) {
          _results.push(this.ammunitions.splice(this.ammunitions.indexOf(ammunition), 1));
        } else {
          _results.push(void 0);
        }
      }
      return _results;
    };

    GameController.prototype.isPersonCaught = function() {
      var gH, gW, gX, gY, ghost, pH, pW, pX, pY, _i, _len, _ref;
      pX = this.person.x;
      pY = this.person.y;
      pH = this.person.height;
      pW = this.person.width;
      _ref = this.ghosts;
      for (_i = 0, _len = _ref.length; _i < _len; _i++) {
        ghost = _ref[_i];
        gX = ghost.x;
        gY = ghost.y;
        gW = ghost.width;
        gH = ghost.height;
        if ((gX + gW >= pX && gX <= pX && ((gY <= pY + pH && gY + gH >= pY + pH) || (gY <= pY && gY + gH >= pY))) || (gX + gW >= pX + pW && gX <= pX + pW && ((gY <= pY + pH && gY + gH >= pY + pH) || (gY <= pY && gY + gH >= pY)))) {
          return true;
        }
      }
      return false;
    };

    GameController.prototype.updateGame = function() {
      if (!this.picsLoader.isReady() || this.gameState !== GAME_STARTED) {
        this.repaint();
        return;
      }
      this.frameNumber++;
      this.moveEveryone();
      return this.repaint();
    };

    GameController.prototype.shoot = function() {
      if (this.person.bulletCount > 0) {
        return this.bullets.push(new Bullet(this.person, this.blocks, this.canvasWidth, this.canvasHeight, this.ghosts));
      }
    };

    GameController.prototype.processKeyBoardEvent = function(key) {
      if (key === this.LEFT_KEY) {
        this.person.turnLeft();
        return;
      }
      if (key === this.UP_KEY) {
        this.person.turnUp();
        return;
      }
      if (key === this.RIGHT_KEY) {
        this.person.turnRight();
        return;
      }
      if (key === this.DOWN_KEY) {
        this.person.turnDown();
        return;
      }
      if (key === this.SPACE_KEY) {
        if (this.gameState === GAME_INTRO) {
          this.gameState = GAME_NOT_STARTED;
          return;
        }
        if (this.gameState === GAME_NOT_STARTED) {
          this.gameState = GAME_STARTED;
          return;
        }
        if (this.gameState === GAME_FINISHED) {
          this.init();
          this.gameState = GAME_STARTED;
          return;
        }
        if (this.gameState === GAME_STARTED) {
          this.shoot();
          return;
        }
      }
    };

    GameController.prototype.generateBlocks = function() {
      var block;
      block = new Block(100, 100, 200, 200);
      this.blocks.push(block);
      block = new Block(400, 100, 200, 50);
      this.blocks.push(block);
      block = new Block(100, 400, 200, 100);
      this.blocks.push(block);
      block = new Block(400, 250, 200, 50);
      this.blocks.push(block);
      block = new Block(400, 400, 50, 100);
      this.blocks.push(block);
      block = new Block(550, 400, 50, 100);
      return this.blocks.push(block);
    };

    GameController.prototype.generateLines = function() {
      var endPoint, startPoint;
      startPoint = {
        x: 50,
        y: 50
      };
      endPoint = {
        x: 650,
        y: 50
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 650,
        y: 50
      };
      endPoint = {
        x: 650,
        y: 550
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 50,
        y: 550
      };
      endPoint = {
        x: 650,
        y: 550
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 50,
        y: 50
      };
      endPoint = {
        x: 50,
        y: 550
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 350,
        y: 50
      };
      endPoint = {
        x: 350,
        y: 550
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 50,
        y: 350
      };
      endPoint = {
        x: 650,
        y: 350
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 350,
        y: 200
      };
      endPoint = {
        x: 650,
        y: 200
      };
      this.lines.push(new Line(startPoint, endPoint));
      startPoint = {
        x: 500,
        y: 350
      };
      endPoint = {
        x: 500,
        y: 550
      };
      return this.lines.push(new Line(startPoint, endPoint));
    };

    return GameController;

  })();

}).call(this);
