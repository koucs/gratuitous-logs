dnd = (f = () ->) ->
  (e) ->
    e.stopPropagation()    # イベントの親要素への伝播を無効にする
    e.preventDefault()     # イベント発生時のデフォルト動作を無効にする
    f.apply $(this), [     # f はハンドラ本体
      e                    # 引数は扱いやすいように適当に並び替えました
      e.originalEvent.dataTransfer.files[0]
      e.originalEvent.dataTransfer.files
    ]

# ajaxを送信するメソッド
convertMarkdownToHtml = (url, waitTimer) ->
  $.ajax
    async: true
    type: "POST"
    url: url
    dataType:  "text"
    cache: false
    data: {
      contents: $('#input-contents').val(),
      user_id: "test-user",
      user_pass: "test-pass"
    }
    context: this
    success:   (data, status, xhr)   ->
      $("td#posts-preview").html(data)
      window.isChange = false
      window.isWait = false

    clearInterval(waitTimer)


$(document).on 'ready page:load', ->

  # Markdownの初回変換
  convertMarkdownToHtml "/posts/convert_mark2html", 0

  $('#article-tags').tagit
    fieldName: 'post[tag_list]'
    singleField: true
    availableTags: window.available_tag_list
    placeholderText: 'TAGS separated by commas'

  if tag_list?
    for tag in tag_list
      $('#article-tags').tagit 'createTag', tag

$ ->
  # テキストエリアの内容が変更されて、3秒後にMarkdownのPreviewへの反映
  $('#input-contents').on('keyup change',->
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
        convertMarkdownToHtml "/posts/convert_mark2html", waitTimer
      , 3000
  ).keyup()


  # 画像のDrag&Dropのイベント実装
  $('#input-contents')
    .on 'dragover', dnd()
    .on 'drop', dnd (event) ->
      console.log event
      file = event.originalEvent.dataTransfer.files[0]
      formData = new FormData()
      formData.append('file', file)

      $.ajax
        method: 'POST'
        url: "/posts/upload_image"
        dataType:  "text"
        contentType: false
        processData: false
        data:formData
        error: (xhr, error) ->
          console.log('アップデートに失敗しました')
          console.log(error)
        success: (response) ->
          console.log('アップロードに成功しました')
          console.log(response)
