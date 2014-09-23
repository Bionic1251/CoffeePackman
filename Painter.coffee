class window.Painter
  constructor: (@context, @canvasWidth, @canvasHeight, @person, @ghosts,
  @blocks, @bullets, @lines, @ammunitions, @picsLoader, @paddingTop)->

  repaint: (frameNumber, gameState) ->
    if gameState == "intro"
      pic = @picsLoader.picsSet.intro
      @context.drawImage(pic, 0, 0)
      return

    pattern = @context.createPattern(@picsLoader.picsSet.gameBackground,
      "repeat")
    @context.fillStyle = pattern
    @context.fillRect(0, 0, @canvasWidth, @canvasHeight)

    pic = @picsLoader.picsSet.person
    @context.drawImage(pic, 0, 0, @person.width, @person.height, @person.x,
      @person.y, @person.width, @person.height)

    for ghost in @ghosts
      pic = @picsLoader.picsSet["ghost" + ghost.picNumber]
      @context.drawImage(pic, 0, 0, ghost.width, ghost.height, ghost.x,
        ghost.y, ghost.width, ghost.height)

    pattern = @context.createPattern(@picsLoader.picsSet.blockBackground,
      "repeat")
    @context.fillStyle = pattern
    for block in @blocks
      @context.fillRect(block.x, block.y, block.width, block.height)

    pic = @picsLoader.picsSet.bullet
    for bullet in @bullets
      @context.drawImage(pic, 0, 0, 20, 20, bullet.x, bullet.y, 20, 20)

    pic = @picsLoader.picsSet.ammunition
    for ammunition in @ammunitions
      @context.drawImage(pic, 0, 0, 40, 40, ammunition.x, ammunition.y, 40, 40)

    pattern = @context.createPattern(@picsLoader.picsSet.blockBackground,
      "repeat")
    @context.fillStyle = pattern
    @context.fillRect(0, @canvasHeight, @canvasWidth, @paddingTop)

    @context.fillStyle = "rgba(0, 0, 0, 0.5)"
    @context.fillRect(@canvasWidth / 2 - 12,
      @canvasHeight + @paddingTop / 3 - 8, 40, 40)
    @context.fillRect(225, @canvasHeight + @paddingTop / 4, 40, 40)


    text = Math.floor(frameNumber / 25)
    @context.fillStyle = "#FFFFFF"
    @context.font = "normal 28px sans-serif"
    @context.textBaseline = 'top'
    @context.fillText(text, @canvasWidth / 2,
      @canvasHeight + @paddingTop / 3)

    @context.fillText(@person.bulletCount, @canvasWidth / 3,
      @canvasHeight + @paddingTop / 3)
    pic = @picsLoader.picsSet.ammunition
    @context.drawImage(pic, 0, 0, 40, 40, 185, @canvasHeight + @paddingTop / 4,
      40, 40)

    if gameState == "gameNotStarted"
      @context.fillStyle = "rgba(0, 0, 0, 0.5)"
      @context.fillRect(25, 75, 660, 500)
      @context.fillStyle = "#FFFFFF"
      @context.font = "normal 50px sans-serif"
      @context.textBaseline = 'top'
      @context.fillText("Твоя цель - продержаться", 50, 100)
      @context.fillText("как можно дольше.", 180, 200)
      @context.fillText("Чтобы начать,", 180, 300)
      @context.fillText("жми пробел.", 200, 400)
      @context.font = "normal 20px sans-serif"
      @context.fillText("Менять направление - стрелки.", 25, 500)
      @context.fillText("Стрелять - пробел.", 25, 525)

    if gameState == "gameFinished"
      @context.fillStyle = "rgba(0, 0, 0, 0.5)"
      @context.fillRect(25, 75, 660, 450)
      @context.fillStyle = "#FFFFFF"
      @context.font = "normal 50px sans-serif"
      @context.textBaseline = 'top'
      @context.fillText("Ты продержался " + text + " с.", 100, 100)
      @context.fillText("Заново?", 200, 200)
      @context.fillText("Жми пробел.", 180, 300)
      @context.font = "normal 20px sans-serif"
      @context.fillText("Не забудь запостить результат на joyreactor :)",
        100, 400)
###@context.fillStyle = "#000000"
for line in @lines
@context.beginPath()
@context.moveTo(line.startPoint.x, line.startPoint.y)
@context.lineTo(line.endPoint.x, line.endPoint.y)
@context.stroke()###