# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $(".approve_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/approve/' + user_id
            success: (res) ->
                jAlert('ok')
            error: (res) ->
                jAlert('bad')

    $(".reject_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        jConfirm user_name + ' さんの登録申請を拒否し、登録情報を抹消します。よろしいですか？', '確認してください', (r) ->
            if(r)
                $.ajax
                    type: 'GET'
                    scriptCharset: 'utf-8'
                    dataType: 'json'
                    url: '/users/reject/' + user_id
                    success: (res) ->
                        jAlert('ok')
                    error: (res) ->
                        jAlert('bad')
