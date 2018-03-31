// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, or any plugin's
// vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file. JavaScript code in this file should be added after the last require_* statement.
//
// Read Sprockets README (https://github.com/rails/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require rails-ujs
//= require semantic-ui
//= require jkanban
//= require calendar
//= require gmaps
//= require_tree .
$( document ).ready(function(){
	$('.ui.checkbox')
	  .checkbox()
	;

	$('select')
	  .dropdown({
	  	transition: 'top'
	  })
	;

	$('.ui.dropdown.item')
	  .dropdown()
	;
	$('.ui.dropdown')
	  .dropdown()
	;

	$('#rangestart').calendar({
	  type: 'date',
	  endCalendar: $('#rangeend')
	});
	$('#rangeend').calendar({
	  type: 'date',
	  startCalendar: $('#rangestart')
	});

	$(".openbtn").on("click", function() {
	  $(".ui.sidebar").toggleClass("very thin icon");
	  $(".asd").toggleClass("marginlefting");
	  $(".sidebar z").toggleClass("displaynone");
	  $(".ui.accordion").toggleClass("displaynone");
	  $(".ui.dropdown.item").toggleClass("displayblock");
	  $(".logo").find('img').toggle();
	});
		 
	$(".ui.dropdown").dropdown({
	 allowCategorySelection: true,
	 transition: "fade up",
	 context: 'sidebar',
	 on: "hover"
	});

	$('.ui.accordion').accordion({
	 selector: {
	 }
	});
});
// $(function(){
//  //  $('.ui.sidebar').sidebar({
//  //    context: $('.bottom.segment')
//  //  }).sidebar('attach events', 'menu');

//  //  $('.ui.accordion')
// 	//   .accordion()
// 	// ;
// });