class window.Bullet
  STEP: 15

  WIDTH: 20
  HEIGHT: 20

  constructor: (@person, @blocks, @canvasWidth, @canvasHeight, @ghosts) ->
    @width = @WIDTH
    @height = @HEIGHT
    @isAlive = true
    @initialize()
    @person.bulletCount--

  initialize: () ->
    if @person.dx > 0
      @x = @person.x + @person.width
      @y = @person.y + @person.height / 2 - @height / 2
      @dx = @STEP
      @dy = 0
      return
    if @person.dx < 0
      @x = @person.x - @width
      @y = @person.y + @person.height / 2 - @height / 2
      @dx = -@STEP
      @dy = 0
      return
    if @person.dy > 0
      @x = @person.x + @person.width / 2 - @width / 2
      @y = @person.y + @person.height
      @dx = 0
      @dy = @STEP
      return
    if @person.dy < 0
      @x = @person.x + @person.width / 2 - @width / 2
      @y = @person.y - @height
      @dx = 0
      @dy = -@STEP
      return

  turnLeft: () ->
    @dx = -@STEP
    @dy = 0

  turnRight: () ->
    @dx = @STEP
    @dy = 0

  turnUp: () ->
    @dx = 0
    @dy = -@STEP

  turnDown: () ->
    @dx = 0
    @dy = @STEP

  isLeft: ()->
    @dx < 0

  isRight: ()->
    @dx > 0

  isUp: ()->
    @dy < 0

  isDown: ()->
    @dy > 0

  move: () ->
    @destroyIfBumpedToEdge()
    for block in @blocks
      @destroyIfBumpedToBlock(block)
    for ghost in @ghosts
      @destroyIfBumpedToGhost(ghost)
    @x += @dx
    @y += @dy

  isNextXStepMoreThanEdge: (edge) ->
    @x + @width + @dx >= edge

  isNextYStepMoreThanEdge: (edge) ->
    @y + @height + @dy >= edge

  isNextXStepLessThanEdge: (edge) ->
    @x + @dx <= edge

  isNextYStepLessThanEdge: (edge) ->
    @y + @dy <= edge

  isPersonOnTheRightSide: (edge) ->
    @x >= edge

  isPersonOnTheLeftSide: (edge) ->
    @x + @width <= edge

  isPersonHigher: (edge) ->
    @y + @height <= edge

  isPersonLower: (edge) ->
    @y >= edge

  isPersonOnTheLineOfBlock: (block) ->
    (@y + @height >= block.y and
    @y + @height <= block.y + block.height) or
    (@y <= block.y + block.height and @y >= block.y)

  isPersonOnTheRowOfBlock: (block) ->
    (@x + @width >= block.x and
    @x + @width <= block.x + block.width) or
    (@x <= block.x + block.width and @x >= block.x)

  destroyIfBumpedToBlock: (block) ->
    if @isNextXStepMoreThanEdge(block.x) and
    @isPersonOnTheLeftSide(block.x + block.width) and
    @isPersonOnTheLineOfBlock(block) or
    @isNextXStepLessThanEdge(block.x + block.width) and
    @isPersonOnTheRightSide(block.x + block.width) and
    @isPersonOnTheLineOfBlock(block) or @isNextYStepMoreThanEdge(block.y) and
    @isPersonHigher(block.y) and @isPersonOnTheRowOfBlock(block) or
    @isNextYStepLessThanEdge(block.y + block.height) and
    @isPersonLower(block.y + block.height) and
    @isPersonOnTheRowOfBlock(block)
      @isAlive = false
      return true
    return false

  destroyIfBumpedToGhost: (ghost) ->
    x0 = @x
    y0 = @y
    w0 = @width
    h0 = @height
    x1 = ghost.x
    y1 = ghost.y
    w1 = ghost.width
    h1 = ghost.height
    if x0 < x1 and x0 + w0 > x1 and
    (y1 + h1 > y0 and y1 < y0 or y1 > y0 and y1 < y0 + h0) or
    x1 < x0 and x1 + w1 > x0 and
    (y1 < y0 and y1 + h1 > y0 or y1 > y0 and y1 < y0 + h0)
      if @isAlive
        ghost.isAlive = false
      @isAlive = false
      return true
    return false

  destroyIfBumpedToEdge: (person) ->
    if @isNextXStepMoreThanEdge(@canvasWidth) or @isNextXStepLessThanEdge(0) or
    @isNextYStepMoreThanEdge(@canvasHeight) or
    @isNextYStepLessThanEdge(0)
      @isAlive = false
      return true
    return false