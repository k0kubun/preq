jQuery(($) ->
	$('.tab_change').click((event) ->
		event.preventDefault()

		# initialize tabs and contents
		$('.tab_content').removeClass('active')
		$('.nav-tabs li').removeClass('active')

		# get target element
		tabLink = $(event.target).closest('a')
		tab = tabLink.closest('li')
		content = $(tabLink.attr('href'))

		# activate a clicked tab and its content
		tab.addClass('active')
		content.addClass('active')
	)
)
