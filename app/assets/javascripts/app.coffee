window.App =
  initHeadroom: ->
    if $('#headroom').length
      headroom = new Headroom($('#header')[0], {
        offset: 500,
        tolerance: 5,
        classes:
          initial: "animated"
          pinned: "slideDown"
          unpinned: "slideUp"
      })
      headroom.init()

  initEditor: ->
    if $('.simditor-editor').length
      new Simditor
        textarea: $('.simditor-editor')
        placeholder: '请输入描述'
        toolbar: [
          'title','bold','italic','underline','strikethrough','color','|'
            'ol','ul','blockquote','code','table','link','image','hr','|'
            'indent','outdent'
        ]

$ () ->
  App.initHeadroom()
  App.initEditor()
