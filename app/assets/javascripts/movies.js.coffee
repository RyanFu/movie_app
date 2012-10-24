# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
  $(".movie-block").hover(
    (e) -> $(this).append("<input id=\"comment_btn\" class=\"btn btn-success pop-comment\" type=\"submit\" value=\"評論\">")
    (e) -> $("#comment_btn").remove()
  )
$ ->
  $("#comment_btn").live 'click', (e) ->
    $('#myCommentModal').modal('show')