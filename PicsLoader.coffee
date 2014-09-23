class window.PicsLoader

  constructor: () ->
    @picsSet =
      gameBackground: @loadPic("gameBackground", "graphics/gameBackground.jpg")
      blockBackground: @loadPic("blockBackground",
        "graphics/blockBackground.jpg")
      ammunition: @loadPic("ammunition", "graphics/ammunition.jpg")
      ghost1: @loadPic("ghost1", "graphics/ghost1.png")
      ghost2: @loadPic("ghost2", "graphics/ghost2.png")
      ghost3: @loadPic("ghost3", "graphics/ghost3.png")
      ghost4: @loadPic("ghost4", "graphics/ghost4.png")
      person: @loadPic("person", "graphics/person.png")
      bullet: @loadPic("bullet", "graphics/bullet.jpeg")
      intro: @loadPic("intro", "graphics/intro.png")

  loadPic: (name, path) ->
    pic = new Image()
    pic.isReady = false
    pic.onload = () ->
      @isReady = true
    pic.src = path
    return pic

  isReady: () ->
    for key, value in @picsSet
      if !@picsSet[key].pic.isReady
        return false
    return true
