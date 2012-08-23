# Place all the behaviors and hooks related to the matching controller here.
# All this logic will automatically be available in application.js.
# You can use CoffeeScript in this file: http://jashkenas.github.com/coffee-script/

$ ->
    $(".delete_material").click (event) ->
        material_id = $(@).attr('data-material-id')
        material_name = $(@).attr('data-material-name')
        $("#modal-delete").bind 'show', (e) ->
            $('#deletion_target_material_name').html(material_name)
            $('#deletion_target_material_id').html(material_id)
        .modal('show')

    $("#confirm_material_deletion").click (event) ->
        material_id = $("#deletion_target_material_id").text()
        $.ajax
            type: 'GET'
            scriptCharset: 'utf-8'
            dataType: 'json'
            url: '/materials/delete/' + material_id
            success: (res) ->
                if res.status == 'success'
                    $td = $('button[data-material-id="' + material_id + '"]:first').closest('td')
                    $td.prev().prev().html('')
                    $td.prev().html('')
                    $td.html('')
                    $('#modal-delete').modal('hide')
                else if res.status == 'forbidden'
                    $('#modal-delete').modal('hide')
                    $('#modal-forbidden').modal('show')
                else
                    $('#modal-delete').modal('hide')
                    $('#modal-fatal').modal('show')
            error: (res) ->
                $('#modal-delete').modal('hide')
                $('#modal-transmission-error').modal('show')
