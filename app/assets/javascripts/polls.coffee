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
          $('#report').append """
            <div class="well well-sm">#{question.title}</div>
            <canvas class="chart-view-container" id="question_#{question.id}" height="400" width="400" >
          """
          ctx = $("#question_#{question.id}").get(0).getContext("2d")

          slice_str = (str)->
            slice_line = 5
            if str.length > slice_line then (str.slice(0, slice_line) + '...') else str

          labels = question.choices.map (choice) ->
            slice_str(choice.title)
          select_counts = question.choices.map (choice) ->
            choice.select_count
          choice_ids = question.choices.map (choice) ->
            choice.id
          limits = question.choices.map (choice) ->
            choice.limit

          drawBar = (ctx, labels, select_counts, choice_ids, limits)->
              dataset =
                fillColor: "rgba(220,220,220,0.5)"
                strokeColor: "rgba(220,220,220,0.8)"
                highlightFill: "rgba(220,220,220,0.75)"
                highlightStroke: "rgba(220,220,220,1)"
                data: select_counts

              bar_data =
                labels: labels
                datasets: [dataset]

              # max_select_count = Math.max.apply(Math, select_counts)
              # min_select_count = Math.min.apply(Math, select_counts)

              # if max_select_count < 200
              #   end_value = 200
              # else
              #   end_value = parseInt(max_select_count * 1.5)

              # if min_select_count > end_value * 0.5
              #   start_value = parseInt(min_select_count / 2)
              # else
              #   start_value = 0

              # step_width = parseInt (end_value - start_value) / 10


              options =
                animation: false
                scaleOverride: false
                # scaleSteps: 10
                # scaleStepWidth: step_width
                # scaleStartValue: start_value
                barValueSpacing: 15
                barDatasetSpacing: 15

              new Chart(ctx).Bar(bar_data, options)

          bar_chart = drawBar(ctx, labels, select_counts, choice_ids, limits)

          App.cable.subscriptions.create { channel: "PollsChannel", poll_id: poll_id },
            received: (data) ->
              if (index = choice_ids.indexOf(data['id'])) >= 0
                bar_chart.destroy()
                select_counts[index] = data['select_count']
                bar_chart = drawBar(ctx, labels, select_counts, choice_ids, limits)

$ () ->
  Polls.initHeadroom()
  Polls.initReport() if $("#report").length
