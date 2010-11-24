$(document).ready(function() {	

  $('#dialog').jqm();
  $('#watchers').jqm();

  $('.carousel').jCarouselLite({
     visible: 6,
     circular: false,
     btnNext: ".next",
     btnPrev: ".prev"
  });
  
  $(".about").click(function(){
    $("#about-text").slideToggle("slow");
    $(this).toggleClass("active"); return false;
  });

  if ( $("#redirect").length ) {
    $("#redirect .link").hide();
    window.location.href = '/processing';
  }
	
});


