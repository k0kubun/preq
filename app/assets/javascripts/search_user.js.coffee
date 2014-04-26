jQuery(($) ->
	$('.navbar-search').submit((event) ->
		event.preventDefault()
		username = $('.search-query').val()
		location.href = "/users/#{username}"
	)
)
