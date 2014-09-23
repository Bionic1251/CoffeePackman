class window.Person
  STEP: 10

  WIDTH: 40
  HEIGHT: 40
  BULLET_COUNT: 2

  constructor: (@x, @y, @blocks, @canvasWidth, @canvasHeight) ->
    @dx = @STEP
    @dy = 0
    @width = @WIDTH
    @height = @HEIGHT
    @bulletCount = @BULLET_COUNT

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
    if @changePersonsDirectionDependingOnEdge()
      return
    for block in @blocks
      if @changePersonsDirectionDependingOnBlock(block)
        return
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
    (@y + @height > block.y and
    @y + @height < block.y + block.height) or
    (@y < block.y + block.height and @y > block.y)

  isPersonOnTheRowOfBlock: (block) ->
    (@x + @width > block.x and
    @x + @width < block.x + block.width) or
    (@x < block.x + block.width and @x > block.x)

  changePersonsDirectionDependingOnBlock: (block) ->
    if @isNextXStepMoreThanEdge(block.x) and
    @isPersonOnTheLeftSide(block.x) and
    @isPersonOnTheLineOfBlock(block)
      @x = block.x - 2 * @width - @dx + block.x - @x
      @dx = -@dx
      return true
    if @isNextXStepLessThanEdge(block.x + block.width) and
    @isPersonOnTheRightSide(block.x + block.width) and
    @isPersonOnTheLineOfBlock(block)
      @x = block.x + block.width - @dx -
      (@x - block.x - block.width)
      @dx = -@dx
      return true
    if @isNextYStepMoreThanEdge(block.y) and
    @isPersonHigher(block.y) and @isPersonOnTheRowOfBlock(block)
      @y = block.y - 2 * @height - @dy + block.y - @y
      @dy = -@dy
      return true
    if @isNextYStepLessThanEdge(block.y + block.height) and
    @isPersonLower(block.y + block.height) and
    @isPersonOnTheRowOfBlock(block)
      @y = block.y + block.height - @dy -
      (@y - block.y - block.height)
      @dy = -@dy
      return true
    return false

  changePersonsDirectionDependingOnEdge: (person) ->
    if @isNextXStepMoreThanEdge(@canvasWidth)
      @x = @canvasWidth - 2 * @width - @dx + @canvasWidth -
      @x
      @dx = -@dx
      return true
    if @isNextXStepLessThanEdge(0)
      @x = -@x - @dx
      @dx = -@dx
      return true
    if @isNextYStepMoreThanEdge(@canvasHeight)
      @y = @canvasHeight - 2 * @height - @dy + @canvasHeight -
      @y
      @dy = -@dy
      return true
    if @isNextYStepLessThanEdge(0)
      @y = -@y - @dy
      @dy = -@dy
      return true
    return false