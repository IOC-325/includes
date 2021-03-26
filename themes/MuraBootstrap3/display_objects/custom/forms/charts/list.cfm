<style>
.item img {width: 100%; height: auto}
</style>
<div class="container">

<!--- News Only Tempate --->
<!---             <cfset variables.itItems = $.content().getKidsIterator() />
            <cfset variables.itItems.setNextN( 0 ) />


                  <cfloop condition="#variables.itItems.hasNext()#">
                   <cfoutput> 
                    <cfset variables.item = variables.itItems.next() />
                      
                    <p>
                      <a href="#variables.item.getURL()#">#variables.item.getTitle()#</a>
                    </p>        
                  </cfoutput>
                  </cfloop> --->




 <div id="carousel-example-generic" class="carousel slide" data-ride="carousel">
  <!-- Indicators -->
  <ol class="carousel-indicators">
    <li data-target="#carousel-example-generic" data-slide-to="0" class="active"></li>
    <li data-target="#carousel-example-generic" data-slide-to="1"></li>
    <li data-target="#carousel-example-generic" data-slide-to="2"></li>
  </ol>

  <!-- Wrapper for slides -->
  <div class="carousel-inner" role="listbox">
    <div class="item active">
      <img alt="$15.234 Billion Bill Backlog" class="img-responsive" height="464" src="/comptroller/assets/Image/Charts_CR2_X_backlog_digital.jpg" style="margin: 0 auto;" width="600" />
      <div class="carousel-caption">
        Caption Slide 1
      </div>
    </div>
    <div class="item">
      <img src="http://placehold.it/450x350" alt="Slide 2">
      <div class="carousel-caption">
        Caption Slide 2
      </div>
    </div>
    <div class="item">
      <img src="http://placehold.it/450x350" alt="Slide 3">
      <div class="carousel-caption">
        Caption Slide 3
      </div>
    </div>        
  </div>

  <!-- Controls -->
  <a class="left carousel-control" href="#carousel-example-generic" role="button" data-slide="prev">
    <span class="glyphicon glyphicon-chevron-left" aria-hidden="true"></span>
    <span class="sr-only">Previous</span>
  </a>
  <a class="right carousel-control" href="#carousel-example-generic" role="button" data-slide="next">
    <span class="glyphicon glyphicon-chevron-right" aria-hidden="true"></span>
    <span class="sr-only">Next</span>
  </a>
</div>

 
</div>



<script>
$(document).ready(function() {

  $('.carousel').carousel({
      pause: true,
      interval: false
  })
   
});

</script>  