# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $(".approve_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $tr = $(@).closest('tr')
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/approve/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $tr.children('td').last().html('<button class="promote btn btn-mini btn-info" data-user-id="' + user_id + '"
                                                    data-user-name="' + user_name + '">昇格</button>')
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

    $(".demote_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-demote').bind 'show', (e) ->
            $('#demotion_target_user_name').html(user_name)
            $('#demotion_target_user_id').html(user_id)
        .modal('toggle')

    $("#confirm_user_demotion").click (event) ->
        user_id = $('#demotion_target_user_id').text()
        user_name = $('#demotion_target_user_name').text()
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/demote/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $tr = $('button[data-user-id="' + user_id + '"]:first').closest('tr')
                    $tr.children('td').last().html('<button class="promote btn btn-mini btn-info" data-user-id="' + user_id + '"
                                                    data-user-name="' + user_name + '">昇格</button>')
                    $tr.appendTo('#status0')
                    $('#modal-demote').modal('toggle')
                else if res.status == 'forbidden'
                    $('#modal-forbidden').modal('toggle')
                else
                    $('#modal-fatal').modal('toggle')
            error: (res) ->
                $('#modal-transmission-error').modal('toggle')

    $(".promote_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-promote').bind 'show', (e) ->
            $('#promotion_target_user_name').html(user_name)
            $('#promotion_target_user_id').html(user_id)
        .modal('toggle')

    $("#confirm_user_promotion").click (event) ->
        user_id = $('#promotion_target_user_id').text()
        user_name = $('#promotion_target_user_name').text()
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/promote/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $tr = $('button[data-user-id="' + user_id + '"]:first').closest('tr')
                    $tr.children('td').last().html('<button class="demote_user btn btn-mini btn-warning" data-user-id="' + user_id + '"
                                                    data-user-name="' + user_name + '">降格</button>')
                    $tr.appendTo('#admins')
                    $('#modal-promote').modal('toggle')
                else if res.status == 'forbidden'
                    $('#modal-forbidden').modal('toggle')
                else
                    $('#modal-fatal').modal('toggle')
            error: (res) ->
                $('#modal-transmission-error').modal('toggle')



