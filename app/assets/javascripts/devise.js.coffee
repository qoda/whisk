# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/
$ ->
    $('.submit-form').click ->
        $('.form-horizontal').submit()

    $('#gameModal').modal('hide')

    if $('.alert span').html() == ""
        $('.alert').hide()
    else
        $('.alert').show()

    $.get '/', (data) ->
		$('body').append "Successfully got the page."
