$(document).ready(function(){
	//for stiky navigation
	$('.js--main-navigation').waypoint(function(direction){
		if(direction == "down"){
			$('nav').addClass('sticky');
		}
		else {
			$('nav').removeClass('sticky');
		}
	});

	$(window).on('resize, load', function mobileNavMenu() {
		var viewportWidth = $(window).width();
		if (  viewportWidth < 767 ) {
			$(".main-nav").removeClass("span-1-of-2").addClass("span-2-of-2");
		}
		if (  viewportWidth > 767 ){
			$(".main-nav").removeClass("span-2-of-2").addClass("span-1-of-2");
		}
	});
});
