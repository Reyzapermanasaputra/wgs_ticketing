$(function(){

	// Show the first tab and hide the rest
	$('#tabs-nav li:first-child').addClass('active');
	$('.tab-content').hide();
	$('.tab-content:first').show();

	$('.label.ui.dropdown')
	  .dropdown();

	$('.no.label.ui.dropdown')
	  .dropdown({
	  useLabels: false
	});

	$('.ui.button').on('click', function () {
	  $('.ui.dropdown')
	    .dropdown('restore defaults')
	});

	$('form').on('click', '.remove_project', function(event){
		$(this).prev('input[type=hidden]').val('1');
		$(this).closest('fieldset').slideUp("slow");
    event.preventDefault();
	});

	$('form').on('click', '.add_fields', function(event) {
	  var regexp, time;
	  time = new Date().getTime();
	  regexp = new RegExp($(this).data('id'), 'g');
	  $(this).before($(this).data('fields').replace(regexp, time));
	  return event.preventDefault();
	});

	// Click function
	$('#tabs-nav li').click(function(){
	  $('#tabs-nav li').removeClass('active');
	  $(this).addClass('active');
	  $('.tab-content').hide();
	  
	  var activeTab = $(this).find('a').attr('href');
	  $(activeTab).fadeIn();
	  return false;
	});

	$('.message .close')
	  .on('click', function() {
	    $(this)
	      .closest('.message')
	      .transition('fade')
	    ;
	  })
	;

});