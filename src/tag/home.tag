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


        </script>

</home>
