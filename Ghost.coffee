class window.Ghost extends Person

  constructor: (@x, @y, @blocks, @canvasWidth, @canvasHeight, @line, @lines) ->
    @STEP = 8
    @isAlive = true
    super(@x, @y, @blocks, @canvasWidth, @canvasHeight)
    @x -= @WIDTH / 2
    @y -= @HEIGHT / 2
    @setUpNewLine(@line)
    @picNumber = Math.ceil(Math.random() * 4)

  setUpNewLine: (line) ->
    @dx = @dy = 0
    @line = line
    if @line.isVertical()
      @x = line.getX0() - @WIDTH / 2
      if Math.random() > 0.5
        @dy = -@STEP
      else
        @dy = @STEP
    else
      @y = line.getY0() - @HEIGHT / 2
      if Math.random() > 0.5
        @dx = -@STEP
      else
        @dx = @STEP

  move: () ->
    anotherLine = @getAnotherLine(@line)
    if anotherLine
      if Math.random() > 0.5
        @setUpNewLine(anotherLine)

    if @line.isVertical()
      if @y + @dy + @HEIGHT / 2 >= @line.getY1() or
      @y + @dy + @HEIGHT / 2 <= @line.getY0()
        anotherLine = @getAnotherLine(@line)
        if anotherLine
          @setUpNewLine(anotherLine)
        else
          @dy = -@dy
    else
      if @x + @dx + @WIDTH / 2 >= @line.getX1() or
      @x + @dx + @WIDTH / 2 <= @line.getX0()
        anotherLine = @getAnotherLine(@line)
        if anotherLine
          @setUpNewLine(anotherLine)
        else
          @dx = -@dx

    @x += @dx
    @y += @dy

  getAnotherLine: (currentline) ->
    point =
      x: @x + @WIDTH / 2 + @dx
      y: @y + @HEIGHT / 2 + @dy
    for line in @lines
      if line.isPointOnLine(point, @STEP / 2) && currentline != line
        return line
    return null
