# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $(".approve_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        $tr = $(@).closest('tr')
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/approve/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $tr.children('td').last().remove()
                    $tr.appendTo('#status0')
                else
                    jAlert('予期しないエラーが発生しました。')
            error: (res) ->
                jAlert('通信に失敗しました。')

    $(".reject_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $tr = $(@).closest('tr')
        jConfirm user_name + ' さんの登録申請を拒否し、登録情報を抹消します。よろしいですか？', '確認してください', (r) ->
            if(r)
                $.ajax
                    type: 'GET'
                    scriptCharset: 'utf-8'
                    dataType: 'json'
                    url: '/users/reject/' + user_id
                    success: (res) ->
                        if res.status == 'success'
                            $tr.remove()
                        else
                            jAlert('予期しないエラーが発生しました。')
                    error: (res) ->
                        jAlert('通信に失敗しました。')
