class window.GameController
  LEFT_KEY: 37
  UP_KEY: 38
  RIGHT_KEY: 39
  DOWN_KEY: 40
  SPACE_KEY: 32

  GAME_INTRO = "intro"
  GAME_NOT_STARTED = "gameNotStarted"
  GAME_STARTED = "gameStarted"
  GAME_FINISHED = "gameFinished"

  constructor: (@canvas) ->
    @gameState = GAME_INTRO
    @context = @canvas.getContext("2d")
    @paddingTop = 100
    @canvasWidth = @canvas.width
    @canvasHeight = @canvas.height - @paddingTop

  init: () ->
    @frameNumber = 0
    @ghosts = []
    @blocks = []
    @bullets = []
    @lines = []
    @ammunitions = []
    @generateBlocks()
    @generateLines()
    @generateGhosts()
    @person = new Person(33, 33, @blocks, @canvasWidth, @canvasHeight)
    @picsLoader = new PicsLoader()
    @painter = new Painter(@context, @canvasWidth, @canvasHeight, @person,
      @ghosts, @blocks, @bullets, @lines, @ammunitions, @picsLoader,
      @paddingTop)

  generateGhosts: () ->
    for i in [0..4]
      @createGhost()

  createGhost: () ->
    line = @lines[7]
    if !line.isVertical()
      y = line.getY0()
      x = line.getX0() + Math.random() * (line.getX1() - line.getX0())
    else
      x = line.getX0()
      y = line.getY0() + Math.random() * (line.getY1() - line.getY0())
    @ghosts.push(new Ghost(x, y, @blocks, @canvasWidth, @canvasHeight, line,
      @lines))

  getRandomLine: ()->
    for line in @lines
      if Math.random() > 0.5
        return line
    return line

  repaint: () ->
    @painter.repaint(@frameNumber, @gameState)

  moveEveryone: () ->
    @updateDeadHeroes()
    @generateAmmunitionIfNecessary()
    if(@isPersonCaught())
      @gameState = GAME_FINISHED
    @person.move()
    for person in @ghosts
      person.move()
    for bullet in @bullets
      bullet.move()
    for ammunition in @ammunitions
      ammunition.move()

  generateAmmunitionIfNecessary: () ->
    line = @getRandomLine()
    if @frameNumber % 220 == 0
      line = @getRandomLine()
      if !line.isVertical()
        y = line.getY0()
        x = line.getX0() + Math.random() * (line.getX1() - line.getX0())
      else
        x = line.getX0()
        y = line.getY0() + Math.random() * (line.getY1() - line.getY0())
      @ammunitions.push(new Ammunition(@person, @blocks, x, y))

  updateDeadHeroes: () ->
    for ghost in @ghosts
      if !ghost.isAlive
        @ghosts.splice(@ghosts.indexOf(ghost), 1)
        @createGhost()
    for bullet in @bullets
      if !bullet.isAlive
        @bullets.splice(@bullets.indexOf(bullet), 1)
    for ammunition in @ammunitions
      if !ammunition.isAlive
        @ammunitions.splice(@ammunitions.indexOf(ammunition), 1)

  isPersonCaught: () ->
    pX = @person.x
    pY = @person.y
    pH = @person.height
    pW = @person.width
    for ghost in @ghosts
      gX = ghost.x
      gY = ghost.y
      gW = ghost.width
      gH = ghost.height
      if((gX + gW >= pX and gX <= pX and
      ((gY <= pY + pH and gY + gH >= pY + pH) or
      (gY <= pY and gY + gH >= pY))) or
      (gX + gW >= pX + pW and gX <= pX + pW and
      ((gY <= pY + pH and gY + gH >= pY + pH) or (gY <= pY and gY + gH >= pY))))
        return true
    return false

  updateGame: () ->
    if !@picsLoader.isReady() || @gameState != GAME_STARTED
      @repaint()
      return
    @frameNumber++
    @moveEveryone()
    @repaint()

  shoot: () ->
    if@person.bulletCount > 0
      @bullets.push(new Bullet(@person, @blocks, @canvasWidth, @canvasHeight,
        @ghosts))

  processKeyBoardEvent: (key) ->
    if key == @LEFT_KEY
      @person.turnLeft()
      return
    if key == @UP_KEY
      @person.turnUp()
      return
    if key == @RIGHT_KEY
      @person.turnRight()
      return
    if key == @DOWN_KEY
      @person.turnDown()
      return
    if key == @SPACE_KEY
      if @gameState == GAME_INTRO
        @gameState = GAME_NOT_STARTED
        return
      if @gameState == GAME_NOT_STARTED
        @gameState = GAME_STARTED
        return
      if @gameState == GAME_FINISHED
        @init()
        @gameState = GAME_STARTED
        return
      if @gameState == GAME_STARTED
        @shoot()
        return
    return

  generateBlocks: () ->
    block = new Block(100, 100, 200, 200)
    @blocks.push(block)
    block = new Block(400, 100, 200, 50)
    @blocks.push(block)
    block = new Block(100, 400, 200, 100)
    @blocks.push(block)
    block = new Block(400, 250, 200, 50)
    @blocks.push(block)
    block = new Block(400, 400, 50, 100)
    @blocks.push(block)
    block = new Block(550, 400, 50, 100)
    @blocks.push(block)

  generateLines: () ->
    startPoint =
      x: 50
      y: 50
    endPoint =
      x: 650
      y: 50
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 650
      y: 50
    endPoint =
      x: 650
      y: 550
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 50
      y: 550
    endPoint =
      x: 650
      y: 550
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 50
      y: 50
    endPoint =
      x: 50
      y: 550
    @lines.push(new Line(startPoint, endPoint))

    startPoint =
      x: 350
      y: 50
    endPoint =
      x: 350
      y: 550
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 50
      y: 350
    endPoint =
      x: 650
      y: 350
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 350
      y: 200
    endPoint =
      x: 650
      y: 200
    @lines.push(new Line(startPoint, endPoint))
    startPoint =
      x: 500
      y: 350
    endPoint =
      x: 500
      y: 550
    @lines.push(new Line(startPoint, endPoint))