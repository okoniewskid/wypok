/* global $ */
$(() => 
{
	if ($('#infinite-scrolling').size() > 0)
	{
		$(window).on('scroll', () =>
		{
            var more = $('.pagination .next a').attr('href');
            console.log(more);
    		if (more && $(window).scrollTop() > $(document).height() - $(window).height() - 60)
    		{
      			$('.pagination').html('<img src="/assets/ajax-loader.gif" alt="Wczytywanie" title="Wczytywanie" />');
      			$('#infinite-scrolling').css('display', 'block');
    			$.getScript(more);
    		}
      		return;
	    });
		return;
    }
});
