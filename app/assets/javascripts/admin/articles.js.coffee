# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/
jQuery ($) ->
  #  Editor
#  $("#article_language_content").kendoEditor()
  $('.category_select').live('change',->
    if $(this).val() != "0"
      window.location.href = "articles?id_cate=" + $(this).val()
    else
      window.location.href = "articles"
  )

  $("#article_priority").kendoNumericTextBox(->
    value: 1
  )


  $('#article_name').keyup( ->
    article_name this.value.length
  )
  article_name = (name) ->
    remaining = $('#remaining')
    chars = name
    remaining.text(100 - chars)

  $('#article_language_title').keyup( ->
    article_language_title this.value.length
  )
  article_language_title = (name) ->
    remaining = $('#remaining_title')
    chars = name
    remaining.text(100 - chars)

  $('#article_language_short_description').keyup( ->
    article_language_short_description this.value.length
  )
  article_language_short_description = (name) ->
    remaining = $('#remaining_short')
    chars = name
    remaining.text(255 - chars)




