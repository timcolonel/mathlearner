# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://coffeescript.org/

$(document).ready () ->
  editor = ace.edit("editor")
  editor.commands.removeCommand('replace')

  textarea = $('textarea.ace_content').hide()
  editor.getSession().setValue(textarea.val())
  textarea.closest('form').on('submit', () ->
    textarea.val(editor.getSession().getValue())
  )