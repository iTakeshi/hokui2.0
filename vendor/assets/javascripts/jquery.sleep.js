/*
	Sleep by Mark Hughes (AKA huzi8t9)
	http://www.360Gamer.net/

	Usage:
		$.sleep ( 3, function()
		{
			alert ( "I slept for 3 seconds!" );
		});
	Use at free will, distribute free of charge
*/
/* 2012-10-11
 * iTakeshi modified
 * $.sleep ( 30, function() ...
 * this code sleeps 3 seconds.
 */
;(function($)
{
	var _sleeptimer;
	$.sleep = function( time2sleep, callback )
	{
		$.sleep._sleeptimer = time2sleep;
		$.sleep._cback = callback;
		$.sleep.timer = setInterval('$.sleep.count()', 100);
	}
	$.extend ($.sleep, {
		current_i : 1,
		_sleeptimer : 0,
		_cback : null,
		timer : null,
		count : function()
		{
			if ( $.sleep.current_i === $.sleep._sleeptimer )
			{
				clearInterval($.sleep.timer);
				$.sleep._cback.call(this);
			}
			$.sleep.current_i++;
		}
	});
})(jQuery);
