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
                    $tr.children('td').last().html('<button class="promote_user btn btn-mini btn-info" data-user-id="' + user_id + '"
                                                    data-user-name="' + user_name + '">昇格</button>')
                    $tr.append('<td><button class="delete_user btn btn-mini btn-danger" data-user-id="' + user_id + '"
                                data-user-name="' + user_name + '">退会</button></td>')
                    $tr.appendTo('#status0')
                else if res.status == 'forbidden'
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-transmission-error').modal('show')

    $(".reject_user").click (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-reject').bind 'show', (e) ->
            $('#rejection_target_user_name').html(user_name)
            $('#rejection_target_user_id').html(user_id)
        .modal('show')

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
                    $('#modal-reject').modal('hide')
                else if res.status == 'forbidden'
                    $('#modal-reject').modal('hide')
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-reject').modal('hide')
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-reject').modal('hide')
                $('#modal-transmission-error').modal('show')

    $(".demote_user").live 'click', (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-demote').bind 'show', (e) ->
            $('#demotion_target_user_name').html(user_name)
            $('#demotion_target_user_id').html(user_id)
        .modal('show')

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
                    $tr.children('td').last().html('<button class="promote_user btn btn-mini btn-info" data-user-id="' + user_id + '"
                                                    data-user-name="' + user_name + '">昇格</button>')
                    $tr.append('<td><button class="delete_user btn btn-mini btn-danger" data-user-id="' + user_id + '"
                                data-user-name="' + user_name + '">退会</button></td>')
                    $tr.appendTo('#status0')
                    $('#modal-demote').modal('hide')
                else if res.status == 'forbidden'
                    $('#modal-demote').modal('hide')
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-demote').modal('hide')
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-demote').modal('hide')
                $('#modal-transmission-error').modal('show')

    $(".promote_user").live 'click', (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-promote').bind 'show', (e) ->
            $('#promotion_target_user_name').html(user_name)
            $('#promotion_target_user_id').html(user_id)
        .modal('show')

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
                    $tr.children('td').last().remove()
                    $tr.children('td').last().html('<button class="demote_user btn btn-mini btn-warning" data-user-id="' + user_id + '"
                                                             data-user-name="' + user_name + '">降格</button>')
                    $tr.appendTo('#admins')
                    $('#modal-promote').modal('hide')
                else if res.status == 'forbidden'
                    $('#modal-promote').modal('hide')
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-promote').modal('hide')
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-promote').modal('hide')
                $('#modal-transmission-error').modal('show')

    $(".delete_user").live 'click', (event) ->
        user_id = $(@).attr('data-user-id')
        user_name = $(@).attr('data-user-name')
        $('#modal-delete-user').bind 'show', (e) ->
            $('#deletion_target_user_name').html(user_name)
            $('#deletion_target_user_id').html(user_id)
        .modal('show')

    $("#confirm_user_deletion").click (event) ->
        user_id = $('#deletion_target_user_id').text()
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/users/delete/' + user_id
            success: (res) ->
                if res.status == 'success'
                    $('button[data-user-id="' + user_id + '"]:first').closest('tr').remove()
                    $('#modal-delete-user').modal('hide')
                else if res.status == 'forbidden'
                    $('#modal-delete-user').modal('hide')
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-delete-user').modal('hide')
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-delete-user').modal('hide')
                $('#modal-transmission-error').modal('show')


