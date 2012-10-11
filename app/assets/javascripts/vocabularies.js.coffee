# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $question = $('#vocabulary-quiz-question span')
    $answer = $('#vocabulary-quiz-answer input[type="text"]')
    $judge = $('#vocabulary-quiz-judge')
    quizzes = 0
    i = 0
    i_max = 0
    right_answer = ''

    $('#vocabulary-form form').on 'ajax:complete', (response, ajax, status) ->
        $('#vocabulary-quiz').show()
        res = $.parseJSON(ajax.responseText)
        quizzes = res.quizzes
        i = 0
        i_max = res.count
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
        else
            $judge.text(right_answer)

    $('#vocabulary-quiz-next').click (e) ->
        setQuestion()
