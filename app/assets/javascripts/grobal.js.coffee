$ ->
    $('.dropdown-toggle').dropdown()
    $('.collapse').collapse()

    $('header button[data-target="#main-menu"]').click ->
        $('#user-menu-smartphone').collapse('hide')
    $('header button[data-target="#user-menu-smartphone"]').click ->
        $('#main-menu').collapse('hide')
