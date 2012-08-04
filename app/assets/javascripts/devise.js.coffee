# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

word_score = (word) ->
    count = 0
    rand_set = $.data['random_set']
    for l in word
        for set in rand_set
            if set[0].toLowerCase() == l
                count += set[1]
    return count

random_str = () ->
    $.get '/ajax/random', (data) ->
        rand_set = data['random_set']
        rand_str = ""
        for item in rand_set
            rand_str += item[0]

        $(".question").html(rand_str)
        $.data['random_set'] = rand_set

$.game_over = () ->
    $('.question').hide()
    $('.game-form').hide()
    $('.game-over').show()
    $('.try-again').show().click ->
        $(this).hide()
        $('.game-over').hide()
        $('.question').show()
        $('.game-form').show()
        $(".game-timer").countdown({
            seconds: 120,
            callback: "$.game_over()"
        });
        $(".game-score").html("0")
        random_str()

$ ->
    $('.submit-form').click ->
        $('.form-horizontal').submit()

    $(".game-launch").click ->
        $(".game-timer").countdown({
            seconds: 120,
            callback: "$.game_over()"
        });

    if $('.alert span').html() == ""
        $('.alert').hide()
    else
        $('.alert').show()

    $.data['random_set'] = []

    random_str()

    $(".submit-answer").click ->
        $(".answer-feedback").hide().removeClass("alert-error").removeClass("alert-success")
        answer = $(".answer").val().toLowerCase()
        rand_set = $.data['random_set']
        rand_str = ""

        for item in rand_set
            rand_str += item[0].toLowerCase()

        cheater = false
        for i in answer
            if i[0] not in rand_str
                cheater = true
        if not cheater
            $.get '/ajax/answer/' + answer, (data) ->
                rand_set = $.data['random_set']
                is_valid = data['is_valid']
                if is_valid
                    $(".answer-feedback").show().delay(3000).hide('slow').addClass("alert-success")
                    $(".answer-feedback span").html("Nice :)")
                    score = parseInt($(".game-score").text())
                    console.log $(".game-score")
                    score += word_score(answer)
                    console.log score
                    $(".game-score").html(score)
                    random_str()
                else
                    $(".answer-feedback").show().delay(3000).hide('slow').addClass("alert-error")
                    $(".answer-feedback span").html("Thats not a real word :(")
                    random_str()
        else
            $(".answer-feedback").show().delay(3000).hide('slow').addClass("alert-error")
            $(".answer-feedback span").html("Are you trying to cheat :(")
            random_str()

