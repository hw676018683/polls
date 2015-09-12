#= require backbone/polls

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

  new Simditor
    textarea: $('.simditor-editor')
    toolbar: [
      'title','bold','italic','underline','strikethrough','color','|'
        'ol','ul','blockquote','code','table','link','image','hr','|'
        'indent','outdent'
    ]

