# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $question = $('#vocabulary-quiz-question span')
    $answer = $('#vocabulary-quiz-answer input[type="text"]')
    $judge = $('#vocabulary-quiz-judge')
    $result = $('#vocabulary-result')
    quizzes = 0
    i = 0
    i_max = 0
    right_answer = ''
    ok_count = 0

    $('#vocabulary-start').on 'ajax:complete', (response, ajax, status) ->
        $('#vocabulary-quiz').show()
        $result.hide()
        res = $.parseJSON(ajax.responseText)
        quizzes = res.quizzes
        i_max = res.count
        i = 0
        ok_count = 0
        setQuestion()

    setQuestion = ->
        $judge.empty()
        $answer.val('')
        right_answer = quizzes[i].answer
        $question.text(quizzes[i].question)
        $answer.focus()
        i++

    $('#vocabulary-quiz-submit').click (e) ->
        if $answer.val() == right_answer
            $judge.text('OK!')
            ok_count++
        else
            $judge.text(right_answer)
        if i == i_max
            $result.show()
            if i_max == ok_count
                $result.children('span').html(ok_count + ' / ' + i_max + '<br>Congratulations!')
            else
                $result.children('span').text(ok_count + ' / ' + i_max)

    $('#vocabulary-quiz-next').click (e) ->
        setQuestion()
