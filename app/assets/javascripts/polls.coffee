window.Polls =
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

  initEditor: (editor_el)->
    new Simditor
      textarea: editor_el
      placeholder: '请输入描述'
      toolbar: [
        'title','bold','italic','underline','strikethrough','color','|'
          'ol','ul','blockquote','code','table','link','image','hr','|'
          'indent','outdent'
      ]

  initiCheck: (input_els)->
    $(input_els).iCheck
      checkboxClass: 'icheckbox_flat',
      radioClass: 'iradio_flat'
      increaseArea: '20%'
      cursor: true
      labelHover: true

$ () ->
  Polls.initHeadroom()
