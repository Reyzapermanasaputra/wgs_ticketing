$(function(){
	
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
});