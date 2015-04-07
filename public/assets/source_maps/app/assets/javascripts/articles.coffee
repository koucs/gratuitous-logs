$(document).on 'ready page:load', ->
  $('#article-tags').tagit
    fieldName: 'post[tag_list]'
    singleField: true
    availableTags: available_tag_list

  if tag_list?
    for tag in tag_list
      $('#article-tags').tagit 'createTag', tag
