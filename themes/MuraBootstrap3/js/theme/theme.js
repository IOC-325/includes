// Placeholder Toggle jQuery Extension
$.fn.togglePlaceholder = function() {
    return this.each(function() {
        $(this)
        .data("holder", $(this).attr("placeholder"))
        .focusin(function(){
            $(this).attr('placeholder','');
        })
        .focusout(function(){
            $(this).attr('placeholder',$(this).data('holder'));
        });
    });
};

jQuery(document).ready(function($) {

	// Toggle All Elements with Placeholder Attributes
	$("[placeholder]").togglePlaceholder();	
	
	//	Append a caret to any submenu in the navigation with children
	$('#navPrimary:first-child > li.dropdown > a.dropdown-toggle').each(function(index, element) {
		$(this).append('<b class="caret"></b>');
	});
	
	//Add BS columns to home blog
	$( ".blog-feed .mura-index dl" ).addClass( "col-lg-4 col-md-4 col-sm-4 col-xs-12" );
	
	//add .btn class to Read More link
	$( ".readMore a" ).addClass( "btn pull-left" );
	
	//add clearfix to form
	$( ".sidebar form" ).addClass( "clearfix" );
	//$('#myTooltip').tooltip();
	
	//Twitter overrides
	setInterval(function() {
	var timeline = $('#twitter-widget-0').contents().find('body').find('.timeline');
	timeline.find('.u-photo.avatar').remove();
	timeline.find('.u-url.permalink.customisable-highlight').remove();
	timeline.find('.header.h-card.p-author').remove();
	timeline.find('.footer.customisable-border').remove();
	}, 500);
	
	// START: Contact Page form
	
	// Message
	$('#contact .sidebar form textarea[name=message]').attr('placeholder','Message*');
	$('#contact .sidebar form textarea[name=message]').focus(function() {
	  	$(this).attr("placeholder","");
	}).blur(function() {
	  	if($(this).val() > 0) {
		  	// do nothing
	  	} else {
		  	$(this).attr("placeholder","Message*");
	  	}
  	});

  	// END: Contact Page form
  	
  	$('.sidebar .nav-list li a').each(function() {
	  	$(this).prepend('<i class="fa fa-angle-right"></i>&nbsp;&nbsp;')
  	});
  	
  	$('#news .content .mura-index dl dd.readMore a').each(function() {
	  	$(this).prepend('<i class="fa fa-long-arrow-right"></i>&nbsp;&nbsp;')
  	});

  	
  	$('.sysServices .content .mura-index dl dd.readMore a').each(function() {
	  	$(this).prepend('<i class="fa fa-long-arrow-right"></i>&nbsp;&nbsp;')
  	});

    $(function () {
        // $('.place-icons a img').on('mouseover', function(){
        //   src = $(this).attr('src').replace('blue', 'red');
        //   $(this).attr('src', src);
        // });

        // $('.place-icons a img').on('mouseout', function(){
        //   src = $(this).attr('src').replace('red', 'blue');
        //   $(this).attr('src', src);
        // }); 

        $('.place-icons a').on('mouseover', function(){
          var src = $(this).closest('div').find('img').attr('src').replace('blue', 'red');
          $(this).closest('div').find('img').attr('src', src);
        });

        $('.place-icons a').on('mouseout', function(){
          var src = $(this).closest('div').find('img').attr('src').replace('red', 'blue');
          $(this).closest('div').find('img').attr('src', src);
        }); 

        $('.agencies-icons a').on('mouseover', function(){
          var src = $(this).closest('div').find('img').attr('src').replace('blue', 'red');
          $(this).closest('div').find('img').attr('src', src);
        });

        $('.agencies-icons a').on('mouseout', function(){
          var src = $(this).closest('div').find('img').attr('src').replace('red', 'blue');
          $(this).closest('div').find('img').attr('src', src);
        }); 
    });

});