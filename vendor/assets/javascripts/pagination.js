/* global $ */
$(() => 
{
	if ($('#infinite-scrolling').size() > 0)
	{
		$(window).on('scroll', () =>
		{
            var more = $('.pagination .next a').attr('href');
    		if (more && $(window).scrollTop() > $(document).height() - $(window).height() - 60)
    		{
      			$('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Wczytywanie" title="Wczytywanie" />');
    			$.getScript(more);
    		}
      		return;
	    });
		return;
    }
});