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
      <div id="infowindow-content">
        <img id="place-icon" src="" height="16" width="16">
        <span id="place-name"  class="title"></span><br>
        Place ID <span id="place-id"></span><br>
        <span id="place-address"></span>
      </div>

    	<div hide={ activeQueuers && activeQueuers.length } id="right-panel">
      		<h2>Results</h2>
      		<ul id="places"></ul>
      		<button id="more">More results</button>
    	</div>

      <table class="table">
        <thead>
          <tr>
            <th>USER</th>
            <th>DISTANCE</th>
            <th>PRICE</th>
            <th>BUY</th>
          </tr>
        </thead>
        <tbody>
          <tr each={activeQueuers}>
            <td class="text-left"><img class="user-photo-small" src={ uphoto }>{ uname }</td>
            <td>{ distance } m</td>
            <td>{ price }</td>
            <td><button class="buy-here-btn btn-no-border" hide={ parent.myuid===uid } onclick={ buyHere } ><i class="fa fa-shopping-cart" aria-hidden="true"></i> BUY</button>
            </td>
          </tr>
        </tbody>
      </table>
      <button class="btn-no-border" hide={ !activeDestid || isQueuer } onclick={ beQueuer } ><i class="fa fa-tags" aria-hidden="true"></i> I'm in this line! Sell my place!</buttom>
      <button class="btn-no-border" show={  activeDestid && isQueuer } onclick={ finQueuer }><i class="fa fa-times-circle-o" aria-hidden="true"></i> Cancel to sell</buttom>

        </div>
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
    <div class="processing-overlay" show={ processing }></div>

<style scoped>
  #infowindow-content {
    display: none;
  }
  #map #infowindow-content {
    display: inline;
  }
  .user-photo-small {
    width : 24px;
    height : 24px;
    margin-right: 5px;
    border-radius: 12px;
  }
  .btn-no-border {
    background : none;
    border : none;
    text-decoration: underline;
  }
  .text-left {
    text-align : left;
  }
  .processing-overlay {
    position: absolute;
    z-index : 10000;
    background : #000;
    opacity : 0.6;
    width : 100%;
    height : 100%;
    top: 0;
    left: 0;
  }

</style>

      <script>

        this.on('mount',()=>{
          document.getElementById('btn').addEventListener("click", function() {
            document.getElementById('map').src = "https://www.google.com/maps/embed/v1/place?key=AIzaSyBu2giCz9pbupJCZfr_GKXN4ipjsbyFqSQ&q=" + document.getElementById('search').value;
          });

          this.myuid = App.apis.LoginApi.user ? App.apis.LoginApi.user.uid : null;
          if(!this.myuid){
            document.location.hash = 'login';
          }

          this.map = new App.apis.LJMapApiClass();
          this.map.createMap('map',{lat:45,lng:139},()=>{
            this.map.moveCurrentLocation(()=>{
              //this.map.addMarker('test');
            });
          });

          this.map.map.addListener('click',(ev)=>{
            if(!ev.placeId){return}
            this.map.getPlaceInformation(ev.placeId,(place)=>{
              const location = place.geometry.location;
              App.apis.DbApi.createDestination(place.name,place.place_id,{lat:location.lat(),lng:location.lng()}).then(()=>{
                this.activeDestid = ev.placeId;
                this.setMapToDests();
              });
            });
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


    this.dests = [];
    this.map = null;
    this.activeDestid = null;
    this.activeQueuers = [];
    this.isQueuer = false;
    this.myuid = null;
    this.processing = false;

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
      const destid = this.activeDestid;
      const MAX_DIST = 3000;

      this.processing = true;
      this.update();
      const endProcessing = ()=>{
        this.processing = false;
        this.update();
      };

      this.map.getPos((location)=>{
        const dist = Math.round(this.map.getDist(location),3);
        if(!dist){
          alert('Can not detect your location. Turn on location service and try again.');
          endProcessing();
          return;
        }
        if(dist > MAX_DIST){
          alert('You are too far from destination. Select right destination, then try again.');
          endProcessing();
          return;
        }
        const price = prompt(`You are ${dist} m distant from destination. Input selling price($)`,'10.00')
        if(!(price*1)){
          endProcessing();
          return;
        }
        api.createQueuer(destid,uid,price,location)
        .then((queuerid)=>{
          endProcessing();
        });
      });
    }

    this.finQueuer = () => {
      const api = App.apis.DbApi;
      const uid = App.apis.LoginApi.user.uid;
      api.finishQueuer(uid);
    }


    this.setMapToDests = () => {
      const api = App.apis.DbApi;
      const uid = App.apis.LoginApi.user.uid;
      const destid = this.activeDestid;
      let isInited = false;
      // start to watch
      this.map.clearMarkers();
      api.watchQueuers(destid,(dest,queuers)=>{
        this.map.clearMarkers();
        if(!isInited){
          console.log('dest',dest,dest.location);
          this.map.moveLocation(dest.location);
          this.map.addMarker('dest',dest.location);
          isInited = true;
        }
        // add queuer marker
        this.isQueuer = false;
        queuers.forEach(q=>{
          console.log('queuer',q.location);
          const qm = this.map.addMarker('queuer',q.location,q);
          if(q.uid === uid){this.isQueuer = true}
        });
        this.activeQueuers = queuers;
        this.update();
      });
    };

    this.buyHere = (ev)=>{
      const queuer = ev.item;
      const isBuy = confirm(`Are you shure you want to buy this location from ${queuer.uname} at a charge of $${queuer.price}`);
      if(isBuy){

      }
    }

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
