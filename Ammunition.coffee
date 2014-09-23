class window.Ammunition
  STEP: 0

  WIDTH: 40
  HEIGHT: 40

  constructor: (@person, @blocks, @x, @y) ->
    @width = @WIDTH
    @height = @HEIGHT
    @isAlive = true

  move: () ->
    @destroyIfBumpedToPerson(@person)

  isNextXStepMoreThanEdge: (edge) ->
    @x + @width >= edge

  isNextYStepMoreThanEdge: (edge) ->
    @y + @height >= edge

  isNextXStepLessThanEdge: (edge) ->
    @x <= edge

  isNextYStepLessThanEdge: (edge) ->
    @y <= edge

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

  destroyIfBumpedToPerson: (person) ->
    x0 = @x
    y0 = @y
    w0 = @width
    h0 = @height
    x1 = @person.x
    y1 = @person.y
    w1 = @person.width
    h1 = @person.height
    if x0 < x1 and x0 + w0 > x1 and
    (y1 + h1 > y0 and y1 < y0 or y1 > y0 and y1 < y0 + h0) or
    x1 < x0 and x1 + w1 > x0 and
    (y1 < y0 and y1 + h1 > y0 or y1 > y0 and y1 < y0 + h0)
      @person.bulletCount += 2
      @isAlive = false