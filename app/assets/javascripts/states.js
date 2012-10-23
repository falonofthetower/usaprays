	<!--Below is the class function for the image map 'class=map'-->
	$(function() {
		$('.map').maphilight({fade: false}); /*set true for fading hover effect*/
		$('map > area').easyTooltip();  /*Tooltip function with area tag*/
	});
