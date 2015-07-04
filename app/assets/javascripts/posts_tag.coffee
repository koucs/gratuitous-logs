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

# textarea のカーソル位置にテキストを挿入する
# http://d.hatena.ne.jp/spitfire_tree/20131209/1386575758
insertAtCaret = (target, str) ->
  obj = $(target)
  obj.focus()
  if(navigator.userAgent.match(/MSIE/))
    r = document.selection.createRange()
    r.text = str
    r.select()
  else
    s = obj.val()
    p = obj.get(0).selectionStart
    np = p + str.length
    obj.val(s.substr(0, p) + str + s.substr(p))
    obj.get(0).setSelectionRange(np, np)



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
    # ドラッグ要素がドロップ要素と重なっている時
    .on 'dragover', dnd ->
      $('#input-contents').css('border', '4px green dotted')

    # ドラッグ要素がドロップ要素から出た時
    .on 'dragleave', dnd ->
      $('#input-contents').css('border', '4px gray solid')

    # ドロップされた時
    .on 'drop', dnd (event) ->
      file = event.originalEvent.dataTransfer.files[0]
      formData = new FormData()
      formData.append('file', file)

      $.ajax
        method: 'POST'
        url: "/posts/upload_image"
        dataType:  "text"
        contentType: false
        processData: false
        data: formData
        error: (xhr, error) ->
          console.log('アップデートに失敗しました')
          console.log(error)
        success: (response) ->
          console.log('アップロードに成功しました')
          objData = $.parseJSON(response)
          imageMarkdown = '!['+ objData.original_filename + '.' + objData.format +'](' + objData.url + ')'
          # ブログコンテンツのtextareaのキャラット位置にimgタグ追加
          insertAtCaret('#input-contents', imageMarkdown)
          # プレビュー更新
          convertMarkdownToHtml "/posts/convert_mark2html", 0
        complete:  (xhr, status)  ->
          $('#input-contents').css('border', '4px gray solid')
