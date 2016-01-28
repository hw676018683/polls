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

  initReport: ->
    poll_id = location.pathname.match(///\/polls\/(\d+)\/report///)[1]

    $.ajax
      url: "/polls/#{poll_id}/report.json"
      success: (data, status, jqxhr)->
        for question in data.questions
          labels = question.choices.map (choice) ->
            choice.title
          select_counts = question.choices.map (choice) ->
            choice.select_count
          dataset =
            fillColor: "rgba(220,220,220,0.5)"
            strokeColor: "rgba(220,220,220,0.8)"
            highlightFill: "rgba(220,220,220,0.75)"
            highlightStroke: "rgba(220,220,220,1)"
            data: select_counts

          bar_data =
            labels: labels
            datasets: [dataset]

          ctx = $("#report").get(0).getContext("2d")

          options =
            barShowStroke : true

          bar_chart = new Chart(ctx).Bar(bar_data, options)

$ () ->
  Polls.initHeadroom()
  Polls.initReport() if $("#report").length
