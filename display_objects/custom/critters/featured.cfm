
<cfset critters = $.getBean('feed').loadBy( feedId = 'EB101F8E-5056-93B5-5EE268FDA3BC2C68' ) />
<cfset crittersIt = critters.getIterator() />

<cfoutput>
  <h2 class="featured-critters">FEATURED CRITTERS</h2>
  <div class="col-xs-12 col-sm-10 col-sm-offset-1">
    <cfloop condition="#crittersIt.hasNext()#">
      <cfset critter = crittersIt.next() />

      <div class="col-xs-12 col-sm-4 text-center featured-critter">

          <a href="#critter.getLinkTo()#" target="_blank">
            <img src="#critter.getImageURL('medium')#" class="img-circle" />
          </a>
          <br />
          <span class="animal-name">
            <a href="#critter.getLinkTo()#" target="_blank">
              #critter.getTitle()#
            </a>
          </span> <br />
          <span class="animal-shelter">#critter.getShelter()#</span>
          <span class="animal-desc">#critter.getBody()#</span>
      </div>
    </cfloop>
  </div>
</cfoutput>

<style>
  h2.featured-critters {
    margin-bottom: 30px;
  }

  .animal-name {
    text-transform: uppercase;
    font-weight: bold;
    font-size:16px;
  }

  .animal-demographic {
    text-transform: uppercase;
    font-weight: bold;
    font-size: 14px;
  }

  .animal-shelter {
    text-transform: uppercase;
    font-weight: bold;
    font-size: 14px;
  }
  
  .featured-critter{
    margin-bottom: 30px;
  }

  .featured-critter img {
    margin-bottom: 15px;
  }
</style>