$(document).ready(function() {	

  $('#dialog').jqm();
  $('#watchers').jqm();

  $('.carousel').jCarouselLite({
     visible: 6,
     circular: false,
     btnNext: ".next",
     btnPrev: ".prev"
  });
  
  	
	// switch show and hide
	$(".about").click(function(){
		$("#about-text").slideToggle("slow");
		$(this).toggleClass("active"); return false;
	});
	
});


