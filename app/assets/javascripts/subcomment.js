$(document).ready(function() {

	$('.subcomment').bind('click', function(e){
		$(this).children(":first").attr('rows', 3);
	});

});

