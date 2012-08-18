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
                else if res.status == 'forbidden'
                    $('#modal-forbidden').modal('toggle')
                else
                    $('#modal-fatal').modal('toggle')
            error: (res) ->
                $('#modal-transmission-error').modal('toggle')

    $(".reject_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-reject').bind 'show', (e) ->
            $('#rejection_target_user_name').html(user_name)
            $('#rejection_target_user_id').html(user_id)
        .modal('toggle')

    $("#confirm_user_rejection").click (event) ->
        user_id = $('#rejection_target_user_id').text()
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/reject/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $('button[data-user-id="' + user_id + '"]:first').closest('tr').remove()
                    $('#modal-reject').modal('toggle')
                else if res.status == 'forbidden'
                    $('#modal-forbidden').modal('toggle')
                else
                    $('#modal-fatal').modal('toggle')
            error: (res) ->
                $('#modal-transmission-error').modal('toggle')
