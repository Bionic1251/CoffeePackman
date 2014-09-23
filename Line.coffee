class window.Line
  constructor: (@startPoint, @endPoint) ->

  getX0: () ->
    @startPoint.x

  getX1: () ->
    @endPoint.x

  getY0: () ->
    @startPoint.y

  getY1: () ->
    @endPoint.y

  isVertical: () ->
    @getX0() == @getX1()

  isPointOnLine: (point, step) ->
    point.x <= @getX1() + step and point.x >= @getX0() - step and point.y <= @getY1() + step and
    point.y >= @getY0() - step