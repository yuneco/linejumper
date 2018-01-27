<test>

  <div id="test">

      <h1 class="title">Line Jumper Login</h1>
      <button onclick={loginWithGoogle}>Login with Google</button>
      <p>After login complete, you can get user info with next code:</p>
      <pre>App.apis.LoginApi.user</pre>

      <h1 class="title">Line Jumper DB API Test</h1>
      <p>Try on dev console!</p>

      <h2>createUser</h2>
      <p>Create user entity in DB. uid (1st param) must be current user's id. Other uid will be rejected.
      You can get id using App.apis.LoginApi.user.uid after logged in.

      </p>
      <pre>{codeCreateUser}
      </pre>

      <h2>getUserInfo</h2>
      <p>Get user profile.</p>
      <pre>{codeGetUserInfo}
      </pre>


      <h2>createDestination</h2>
      <p>Regist location to make a line (e.g. "Apple Store NY)" </p>
      <pre>{codeCreateDestination}
      </pre>

      <h2>createQueuer</h2>
      <p>Regist queuer for specified destination.</p>
      <pre>{codeCreateQueuer}
      </pre>

      <h2>updateQueuerLocation</h2>
      <p>Update queuers location. Call this api when GPS detects location change. </p>
      <pre>{codeUpdateQueuerLocation}
      </pre>


      <h2>getDestinations</h2>
      <p>List up all destinations.</p>
      <pre>{codeGetDestinations}
      </pre>

      <h2>watchQueuers</h2>
      <p>Start to watch queuers of specified destination. Every time queuer update its location, the callback will be called promptly. To stop watching, call this api again with no (=null) callback.</p>
      <pre>{codeWatchQueuers}
      </pre>


    <h1>Line Jumper Map</h1>
    <select id="dest-select" onchange={ setMapToDests }>
      <option each={ dests } value={ destid }>{ name }</option>
    </select>
    <button onclick={getDests}>get dest list</button>
    <div id="map"></map>

  </div>

  <style>
    #map {
      width : 400px;
      height : 400px;
      border : 1px solid gray;
    }
  </style>

  <script>
    // login
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
          this.map.addMarker('test');
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
          this.map.addMarker('queuer',q.location);
        })
      });

    };


    // -------- sample code -----------
    this.codeCreateUser = `var api = App.apis.DbApi;
if(App.apis.LoginApi.user){ // Login After Only
  api.createUser(App.apis.LoginApi.user.uid,App.apis.LoginApi.user.displayName);
}`;

    this.codeCreateDestination = `var api = App.apis.DbApi;
    // place name, dest id (use place-id provided by result of google api), location
    // if same dest id exists, just over written by new value.
api.createDestination('Apple Store GINZA','google-place-id-12345',{lat:35.672256, lng:139.765812})
  .then(()=>{console.log('added!')});`;

    this.codeCreateQueuer = `var api = App.apis.DbApi;
// destid , queuer's uid , price , location(lat,lng)
api.createQueuer('-L3qo1xvBcYmOLKmuiOA','uid0001',20,{lat:20,lng:30})
  .then((queuerid)=>{console.log('create queuer. id = ' + queuerid)});`;

    this.codeUpdateQueuerLocation = `var api = App.apis.DbApi;
api.updateQueuerLocation('-L3qqhYnX15fXYHjQs5s',{lat:50,lng:60});`;

    this.codeGetDestinations = `var api = App.apis.DbApi;
api.getDestinations().then(dests=>{console.log(dests)})`;

    this.codeWatchQueuers = `var api = App.apis.DbApi;
const callback = (dest,queuers)=>{console.log(dest,queuers)};
// start to watch
api.watchQueuers('-L3qo1xvBcYmOLKmuiOA',callback);
// stop to watch
api.watchQueuers('-L3qo1xvBcYmOLKmuiOA',null);`;

    this.codeGetUserInfo = `var api = App.apis.DbApi;
api.getUserInfo('iuGUa6TFU4PYiNnGL1BeaJmaouP2').then(user=>{console.log(user)})`;

  </script>

</test>
