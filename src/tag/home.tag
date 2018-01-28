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
                <img class="btn" id="btn" src="img/search.png"/>
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

    	<div id="right-panel">
      		<h2>Results</h2>
      		<ul id="places"></ul>
      		<button id="more">More results</button>
    	</div>

      <table>
        <thead>
          <tr>
            <th>USER</th>
            <th>DISTANCE</th>
            <th>PRICE</th>
          </tr>
        </thead>
        <tbody>
          <tr each={activeQueuers}>
            <td><img class="user-photo-small" src={ uphoto }>{ uname }</td>
            <td> not yet </td>
            <td>{ price }</td>
          </tr>
        </tbody>
      </table>
      <button hide={ !activeDestid || isQueuer } onclick={ beQueuer }>I'm in this line! Sell my place!</buttom>
      <button show={  activeDestid && isQueuer } onclick={ finQueuer }>Cancel to sell :(</buttom>

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

<style scoped>
  #infowindow-content {
    display: none;
  }
  #map #infowindow-content {
    display: inline;
  }
  .user-photo-small {
    width : 32px;
    height : 32px;
    border-radius: 10px;
  }
</style>

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

    this.dests = [];
    this.map = null;
    this.activeDestid = null;
    this.activeQueuers = [];
    this.isQueuer = false;

    this.on('mount', ()=>{
      this.map = new App.apis.LJMapApiClass();
      this.map.createMap('map',{lat:45,lng:139},()=>{
        this.map.moveCurrentLocation(()=>{
          //this.map.addMarker('test');
        });
        this.map.map.addListener('click',(ev)=>{
          console.log(ev);
          this.map.getPlaceInformation(ev.placeId,(place)=>{
            const location = place.geometry.location;
            App.apis.DbApi.createDestination(place.name,place.place_id,{lat:location.lat(),lng:location.lng()}).then(()=>{
              this.activeDestid = ev.placeId;
              this.setMapToDests();
            });
          });
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
      const destid = this.activeDestid;
      this.map.getPos((location)=>{
        const dist = Math.round(this.map.getDist(location),3);
        const price = prompt(`You are ${dist} m distant from destination. Input selling price($)`,'10.00')
        api.createQueuer(destid,uid,price,location)
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
      const uid = App.apis.LoginApi.user.uid;
      const destid = this.activeDestid;
      let isInited = false;
      // start to watch
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


        </script>

</home>
