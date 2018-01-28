<home>
        <div class="container">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-default bg-light">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand"><img title="" src="#" class="logo"/></a>
                    <a class="navbar-brand">Line Jumper</a>
                </div>
                <li><input type="text" class="searchBar" name="search" id="search" placeholder="Search">
                <img class="btn" id="btn" src="img/search.png"/></li>
                <div class="navbar-collapse collapse">
                    <ul class="nav navbar-nav">
                    </ul>
                    <ul class="nav navbar-nav navbar-right">
<!--                         <li><a href="#"><button onclick={loginWithGoogle}>Login with Google</button></a></li> -->
                    </ul>
                </div>
            </div>
        </nav>
        <!-- Header -->
        <div class="jumbotron">
<!--                 <input type="text" class="searchBar" name="search" id="search" placeholder="Search"> -->

<!-- 		  <div id="map"></div> -->
		  <iframe id="map"
  frameborder="0" style="border:0"
  src="https://www.google.com/maps/embed/v1/place?key=AIzaSyBu2giCz9pbupJCZfr_GKXN4ipjsbyFqSQ
    &q=CSUMB+Monterey+CA" allowfullscreen>
</iframe>

    	<div id="right-panel">
      		<h2>Results</h2>
      		<ul id="places"></ul>
      		<button id="more">More results</button>
    	</div>
        </div>

        <!-- Content -->
        <!--
<div class="container-fluid" id="content">
           <div class="row-fluid">
               FILTERS
               <!~~<div class="column col-xs-4 col-sm-4 col-md-4 col-lg-4">~~>
               <!~~    Column 1~~>
               <!~~</div>~~>
               <!~~<div class="column col-xs-4 col-sm-4 col-md-4 col-lg-4">~~>
               <!~~    Column 2~~>
               <!~~</div>~~>
               <!~~<div class="column col-xs-4 col-sm-4 col-md-4 col-lg-4">~~>
               <!~~    Column 3~~>
               <!~~</div>~~>

           </div>
           <hr>
           STUFF
			   <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
               <br/>
        </div>
 -->

        <script>
        this.on('mount',()=>{
          document.getElementById('btn').addEventListener("click", function() {
            document.getElementById('map').src = "https://www.google.com/maps/embed/v1/place?key=AIzaSyBu2giCz9pbupJCZfr_GKXN4ipjsbyFqSQ&q=" + document.getElementById('search').value;
          });
        });

        function init() {
            var options = {
                types: ["(cities)"]
            }
            var input = document.getElementById('search');
	        var autocomplete = new google.maps.places.Autocomplete(input,options);

        }

        google.maps.event.addDomListener(window, 'load', init);

        // function initMap() {
//           map = new google.maps.Map(document.getElementById('map'), {
//           zoom: countries['us'].zoom,
//           center: countries['us'].center,
//           mapTypeControl: false,
//           panControl: false,
//           zoomControl: false,
//           streetViewControl: false
//         });
//
//         infoWindow = new google.maps.InfoWindow({
//           content: document.getElementById('info-content')
//         });
//
//         // Create the autocomplete object and associate it with the UI input control.
//         // Restrict the search to the default country, and to place type "cities".
//         autocomplete = new google.maps.places.Autocomplete(
//             /** @type {!HTMLInputElement} */ (
//                 document.getElementById('autocomplete')), {
//               types: ['(cities)'],
//               componentRestrictions: countryRestrict
//             });
//         places = new google.maps.places.PlacesService(map);
//
//         autocomplete.addListener('place_changed', onPlaceChanged);
//
//         // Add a DOM event listener to react when the user selects a country.
//         document.getElementById('country').addEventListener(
//             'change', setAutocompleteCountry);
//         }

        </script>

</home>
