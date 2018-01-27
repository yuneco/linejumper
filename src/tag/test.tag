<test>

  <div id="test">

      <h1 class="title">Line Jumper DB API Test</h1>
      <p>Try on dev console!</p>

      <h2>createUser</h2>
      <p>Create user entity in DB. This is just a mock. Need to use FirebaseAuth.</p>
      <pre>{codeCreateUser}
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


  </div>

  <script>
    this.codeCreateUser = `var api = App.apis.DbApi;
api.createUser('uid0001','YUKI');`;

    this.codeCreateDestination = `var api = App.apis.DbApi;
api.createDestination('Apple Store GINZA',{lat:35.672256, lng:139.765812})
  .then((destid)=>{console.log('destination created: id = ' + destid)});`;

    this.codeCreateQueuer = `var api = App.apis.DbApi;
// destid , queuer's uid , price , location(lat,lng)
api.createQueuer('-L3qo1xvBcYmOLKmuiOA','uid0001',20,{lat:20,lng:30})
  .then((queuerid)=>{console.log('create queuer. id = ' + queuerid)});`;

    this.codeUpdateQueuerLocation = `var api = App.apis.DbApi;
api.updateQueuerLocation('-L3qqhYnX15fXYHjQs5s',{lat:50,lng:60});`;

    this.codeGetDestinations = `var api = App.apis.DbApi;
api.getDestinations().then(dests=>{console.log(dests)})`;

    this.codeWatchQueuers = `var api = App.apis.DbApi;
const callback = (destid,queuers)=>{console.log(destid,queuers)};
// start to watch
api.watchQueuers('-L3qo1xvBcYmOLKmuiOA',callback);
// stop to watch
api.watchQueuers('-L3qo1xvBcYmOLKmuiOA',null);`;

  </script>

</test>
