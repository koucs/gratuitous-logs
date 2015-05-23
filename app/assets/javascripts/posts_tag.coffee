$(document).on 'ready page:load', ->
  $('#article-tags').tagit
    fieldName: 'post[tag_list]'
    singleField: true
    availableTags: available_tag_list

  if tag_list?
    for tag in tag_list
      $('#article-tags').tagit 'createTag', tag

$ ->
  $('#input-contents').on('keyup',->
    unless window.isChange?
      window.isChange = false
    unless window.isWait?
      window.isWait = false

    if window.isChange == false
      window.isChange = true
      window.timeStart = new Date().getTime()
      console.log("to TRUE")

    else if window.isChange == true && window.isWait == false

      window.isWait = true
      waitTimer = 0

      waitTimer = setInterval ->
        $.ajax
          async:     true
          type:      "POST"
          url:       "/posts/convert_mark2html"
          dataType:  "text"
          cache: false
          data: {
            contents: $('#input-contents').val(),
            user_id: "test-user",
            user_pass: "test-pass"
          },
          context: this
          success:   (data, status, xhr)   ->
            $("td#posts-preview").html(data)
            window.isChange = false
            window.isWait = false

            clearInterval(waitTimer)
      , 3000

  ).keyup()
