$ () ->
  headroom = new Headroom($('#header')[0], {
    offset: 500,
    tolerance: 5,
    classes:
      initial: "animated"
      pinned: "slideDown"
      unpinned: "slideUp"
  })
  headroom.init()
