<home>
        <div class="container">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg navbar-default bg-light">
            <div class="container-fluid">
                <div class="navbar-header">
                    <a class="navbar-brand"><img title="" src="#" class="logo"/></a>
                    <a class="navbar-brand">Line Jumper</a>
                </div>
                <input type="text" class="searchBar" name="search" id="search" placeholder="Search">
                <img class="btn" id="btn" onclick={getResults} src="img/search.png"/>
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

		  <div id="map"></div>
      </div>
      <div class="container-fluid" id="result-info">
           <div class="row-fluid">
           <div class="column col-xs-8 col-sm-8 col-md-4 col-lg-8">
              <div id="left-panel">
                  <h2>Queuers</h2>
                  <hr/>
              </div>
           </div>
           <div class="column col-xs-4 col-sm-4 col-md-4 col-lg-4">
               <div id="right-panel">
      		        <h2>Results</h2>
      		        <hr/>
      		        <table id="results">
      		          <tbody></tbody>
      		        </table>
    	          </div>
    	      </div>
    	    </div>
    	</div>
    </div>

    <div class="" style="z-index:300; margin-top:100px;">
    <select id="dest-select" onchange={ setMapToDests }>
      <option each={ dests } value={ destid }>{ name }</option>
    </select>
    <button onclick={getDests}>get dest list</button>
    <button onclick={beQueuer}>Be Queuer Here</button>
    <button onclick={finQueuer}>Finish Queuer</button>

    </div>

        <script>

        this.on('mount',()=>{
          document.getElementById('btn').addEventListener("click", function() {
            document.getElementById('map').src = "https://www.google.com/maps/embed/v1/place?key=AIzaSyBu2giCz9pbupJCZfr_GKXN4ipjsbyFqSQ&q=" + document.getElementById('search').value;
          });
        });

        function init() {
            var options = {
                types: ["geocode"]
            }
            var input = document.getElementById('search');
	          var autocomplete = new google.maps.places.Autocomplete(input,options);

            document.getElementById('btn').addEventListener("click", function() {
                var place = this.autocomplete.getPlace();
                var latitude = results[0].geometry.location.lat();
                var longitude = results[0].geometry.location.lng();
                this.map = new App.apis.LJMapApiClass();
                this.map.createMap('map',{lat:latitude,lng:longitude},()=>{
                this.map.moveCurrentLocation(()=>{

                console.log(latitude);
                console.log(longitude);
              });
            });
          });
        }

        google.maps.event.addDomListener(window, 'load', init);

    this.loginWithGoogle = ()=>{
      App.apis.LoginApi.loginWithGoogle();
    }

    this.dests = [];
    this.map = null;
    this.mapDestid = null;

    this.on('mount', ()=>{
      this.map = new App.apis.LJMapApiClass();
      this.map.createMap('map',{lat:45,lng:139},()=>{
        this.map.moveCurrentLocation(()=>{
          //this.map.addMarker('test');
        });
      });

    });

    this.getDests = () => {
      const api = App.apis.DbApi;
      api.getDestinations().then(dests=>{
        this.dests = dests;
        this.update();
      })
    };

    this.beQueuer = () => {
      const api = App.apis.DbApi;
      const uid = App.apis.LoginApi.user.uid;
      const destid = $('#dest-select').val();
      this.map.getPos((location)=>{
        const dist = Math.round(this.map.getDist(location),3);
        const price = prompt(`You are ${dist} m distant from destination. Input selling price($)`,'10.00')
        api.createQueuer(destid,uid,20,location)
        .then((queuerid)=>{console.log('create queuer. id = ' + queuerid)});
      });
    }

    this.finQueuer = () => {
      const api = App.apis.DbApi;
      const uid = App.apis.LoginApi.user.uid;
      api.finishQueuer(uid);
    }


    this.setMapToDests = () => {
      const api = App.apis.DbApi;
      const destid = $('#dest-select').val();
      let isInited = false;
      // start to watch
      api.watchQueuers(destid,(dest,queuers)=>{
        if(!isInited){
          console.log('dest',dest,dest.location);
          this.map.moveLocation(dest.location);
          this.map.addMarker('dest',dest.location);
          isInited = true;
        }
        this.map.clearMarkers();
        // add queuer marker
        queuers.forEach(q=>{
          console.log('queuer',q.location);
          const qm = this.map.addMarker('queuer',q.location,q);
          qm.addListener(()=>{
            const uid = q.uid;
            const price = q.price;
            comfirm(`Do you want to buy this position from ${uid}? Price : $${price}`);
          });
        })
      });

    };

    // this.updateMap = () => {
//           this.map = new App.apis.LJMapApiClass();
//           this.map.createMap('map',{lat:this.lat,lng:this.lng},()=>{
//           this.map.moveCurrentLocation(()=>{
//
//           console.log(lat);
//           console.log(lng);
//         });
//       });
//     };

    this.getResults = () => {

        if(results==null) {
                results = "";
                $("#results > tbody").empty();
            }
        var city = $('#search').val()
            // if(results) {
//                 results = "";
//                 $("#results > tbody").empty();
//             }

            var url = "https://maps.googleapis.com/maps/api/geocode/json?address="+encodeURIComponent(city)+"&key=AIzaSyAMf1KTIzyqQqLf1QmNic4xcq7hGp_wE7s";
            $.getJSON(url, function(val) {
                if(val.results.length) {
                  var location = val.results[0].geometry.location
                  var lat = location.lat;
                  var lon = location.lng;
                  if($('#types').val() == "all")
                    var type = "'amusement_park','movie_theater', 'restaurant', 'supermarket'"
                  else
                    var type = $('#types').val();

                  var request = {
                        location: new google.maps.LatLng(lat, lon),
                        radius: '100',
                        types: ['amusement park','movie theater', 'restaurant', 'supermarket']
                    };

                    var container = document.getElementById('search');

                    var service = new google.maps.places.PlacesService(container);
                    service.nearbySearch(request, callback);

                    function callback(results, status) {

                        if (status == google.maps.places.PlacesServiceStatus.OK) {
//                             results = quickSort(results,0,results.length - 1)
//                             console.log("Sorted?",results.length-1)
                            console.log(results)

                            for (var i = results.length-1; i >= 0; i--) {
                                console.log(results[i])

                                $('#results > tbody')
                                    .append($('<tr id="thisRow">')
                                    .html(results[i].name.toUpperCase())
                                    .append($('<hr/>'))
                                  )
                                }}}}});
    }




        </script>

</home>
