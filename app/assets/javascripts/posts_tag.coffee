$(document).on 'ready page:load', ->
  $('#article-tags').tagit
    fieldName: 'post[tag_list]'
    singleField: true
    availableTags: available_tag_list

  if tag_list?
    for tag in tag_list
      $('#article-tags').tagit 'createTag', tag


$ ->
  $('#input-contents').on('keyup keydown keypress change',->
    $.ajax
        async:     true
        type:      "GET"
        url:       "/posts/convert_mark2html"
        dataType:  "text"
        data: {
            contents: $('#input-contents').val(),
            user_id: "test-user",
            user_pass: "test-pass"
        },
        context: this
        success:   (data, status, xhr)   ->      $("td#posts-preview").html(data)
        error:     (xhr,  status, error) -> alert status

  ).keyup()
