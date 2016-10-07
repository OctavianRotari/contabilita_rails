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
});
