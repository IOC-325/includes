

<cfinvoke component="Queries.revenues" 
	method="PopularRevenuesQuery" 
	returnvariable="results">
</cfinvoke>

<cfinvoke component="Queries.revenues"
	method="getRevType"
	returnvariable="RevTypeSelected"
	type="02">
</cfinvoke>
<cfoutput>
<div id="expense" class="revenue">
	<div class="container">

  <cfform method="post" action="">

     <div class="row">
      <div class="col-md-10 col-md-offset-1">
       <h1>#$.getTitle()#</h1>
        <p>Description goes here.</p>
        <div class="row">
          
          
          
      
           
           
           
        
        </div>
      </div>
     </div>
   
  </cfform>
	</div>
</div>


</cfoutput>