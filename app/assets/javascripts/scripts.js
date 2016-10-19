$(document).ready(function(){
	//for stiky navigation
	$('.js--main-navigation').waypoint(function(direction){
		if(direction == "down"){
			$('header').addClass('white-space');
			$('nav').addClass('sticky');
			$('.js--main-navigation').addClass('animated fadeIn');
			$('.js--main-nav').removeClass('animated fadeIn');
		} else {
			$('header').removeClass('white-space');
			$('nav').removeClass('sticky');
			$('.js--main-navigation').removeClass('animated fadeIn');
			$('.js--main-nav').addClass('animated fadeIn');
		}
	});


	$(window).on('resize, load', function mobileNavMenu() {
		var viewportWidth = $(window).width();
		if (  viewportWidth < 767 ) {
			$(".main-nav").removeClass("span-1-of-2").addClass("span-2-of-2");
		} else if (  viewportWidth > 767 ){
			$(".main-nav").removeClass("span-2-of-2").addClass("span-1-of-2");
		}
	});

	$(window).ready(function mobileNavMenu() {
		var viewportWidth = $(window).width();
		if (  viewportWidth < 480 ) {
			$("div.company-name").remove();
			$(".logo-title").removeClass("span-1-of-3").addClass("span-1-of-2");
			$(".log-section").removeClass("span-1-of-3").addClass("span-1-of-2");
		}
	});

	$('.js--dropdown').hover(function(){
		$('.js--dropdown-content').addClass('animated rollIn');
	})
});
