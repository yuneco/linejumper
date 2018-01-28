<home>
        <div class="container">
        <!-- Navigation -->
        <nav class="navbar navbar-expand-lg">
            <div class="container-fluid">
            <img title="" src="img/logo.png" class="logo"/>
                <div class="navbar-header">
                    <a class="navbar-brand green" onclick={about}>About Us</a>
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

    	<div hide={ activeQueuers && activeQueuers.length } id="right-panel">
      		<h2>Results</h2>
      		<ul id="places"></ul>
      		<button id="more">More results</button>
    	</div>


      <ul class="queuer-list no-photo">
        <li class="queuer-list-item" each={activeQueuers} onclick={buyHere}>
          <div class="bg"></div>
          <div class="price" >${ price }</div>
          <div class="dist" >{ distance } m</div>
          <div class="name">{ uname }</div>
        </li>
      </ul>


      <button class="btn-no-border" hide={ !activeDestid || isQueuer } onclick={ beQueuer } ><i class="fa fa-tags" aria-hidden="true"></i> I'm in this line! Sell my place!</button>
      <button class="btn-no-border" show={  activeDestid && isQueuer } onclick={ finQueuer }><i class="fa fa-times-circle-o" aria-hidden="true"></i> Cancel Your Sale</button>

        </div>
      </div>

    	</div>
    </div>
    <div class="processing-overlay" show={ processing }></div>
    <div class="buy-confirm" show={ isSelected } >
      <div class="photo"></div>
      <div class="message">
        Are you sure you want to buy this location from {selectedQueuer.uname} for a charge of ${selectedQueuer.price}?
      </div>
      <div class="buttons">
        <button class="cancel-btn" onclick={buyHereCanceled}>CANCEL</button>
        <button onclick={buyHereConfirmed}>BUY HERE</button>
      </div>
    </div>


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

  .container {
   background-color:#fff;
   color:#668C47;
   overlay:scroll;
   z-index:600;
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

  .queuer-list {
    white-space : nowrap;
    overflow-x : scroll;
    padding : 0;
  }

  .queuer-list-item {
    display : inline-block;
    width : 130px;
    height : 130px;
    border : red;
    position: relative;
    padding-top : 40px;
  }

  .queuer-list-item .photo {
    width : 110px;
    height : 110px;
    left: 10px;
    top : 10px;
    border-radius: 55px;
    border: 1px solid #888;
    position: absolute;
    z-index : -1;
  }

  .queuer-list-item .bg {
    width : 110px;
    height : 110px;
    left: 10px;
    top : 10px;
    background: #ef7778;
    border-radius: 55px;
    position: absolute;
    z-index : -1;
  }


  .queuer-list-item .price {
    font-size : 20pt;
    width : 100%;
    text-align : center;
    color : white;
    text-shadow: 1px 1px 0px #333a,
    -1px 1px 0px #333a,
    1px -1px 0px #333a,
    -1px -1px 0px #333a;
  }

  .queuer-list-item .dist {
    font-size : 14pt;
    width : 100%;
    text-align : center;
    color : white;
    text-shadow: 1px 1px 0px #333a,
    -1px 1px 0px #333a,
    1px -1px 0px #333a,
    -1px -1px 0px #333a;
  }

  .queuer-list-item .name {
    font-size : 12pt;
    width : 100%;
    text-align : center;
    color : #000;
    padding-top : 16px;
    white-space: nowrap;
    text-overflow: ellipsis;
  }

  .no-photo .queuer-list-item .price {
    font-size : 20pt;
    width : 100%;
    text-align : center;
    color : white;
    text-shadow: none;
  }

  .no-photo .queuer-list-item .dist {
    font-size : 14pt;
    width : 100%;
    text-align : center;
    color : white;
    text-shadow: none;
  }

  .buy-confirm {
    position : absolute;
    z-index : 10000;
    width : 90%;
    height : 90%;
    left : 5%;
    top : 5%;
    border : 1px solid #888;
    background-color: white;
    box-shadow:0px 0px 26px 3px rgba(61,61,61,0.75);
  }

  .buy-confirm .photo{
    width : 100%;
    height : 50%;
    background-size : cover;
  }

  .buy-confirm .message{
    width : 90%;
    margin-left : 5%;
    margin-top : 40px;
    text-align : center;
    font-size : 14pt;
    color : #000;
  }

  .buy-confirm .buttons{
    width : 90%;
    margin-left : 5%;
    position : absolute;
    bottom : 30px;
  }
  .buy-confirm .buttons button{
    color : white;
    background: #ef7778;
    border-radius: 20px;
    border : none;
    padding : 4px 20px;
    display : inline-block;
    height : 40px;
    font-size : 13pt;
    margin : 0 10px;
  }

  .buy-confirm .buttons .cancel-btn {
    color : #ef7778;
    background: white;
    border : 1px solid #ef7778

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
            return;
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
    this.isSelected = false;
    this.selectedQueuer = false;

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
          alert('Sorry, we cannot detect your location. Turn on location service and try again.');
          endProcessing();
          return;
        }
        if(dist > MAX_DIST){
          alert('You are too far from destination. Select the right destination, and try again.');
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
      this.isSelected = true;
      this.selectedQueuer = queuer;
      $('.buy-confirm .photo').css({backgroundImage: `url('${queuer.uphoto}')`});
      this.update();
    }

    this.buyHereConfirmed = (ev)=>{
      const queuer = this.selectedQueuer;
      this.isSelected = false;
      this.selectedQueuer = null;
      this.update();
      App.apis.DbApi.buyPosition(this.myuid, queuer.queuerid).then(()=>{
        document.location.hash = 'recept';
      });
    }

    this.buyHereCanceled = (ev)=>{
      this.isSelected = false;
      this.selectedQueuer = null;
      this.update();
    }


    this.about = ()=>{
        window.clearInterval(this.timerid);
        // move to about
        window.document.location.hash = 'about';
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
