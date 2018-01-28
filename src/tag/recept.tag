<recept>
<div class="recept">
  <div id="map"></div>
  <img class="queuerPhoto" src={ queuerPhoto } >
  <h1>{ queuerName }</h1>
  <div>Go to 🚩 and show this screen to { queuerName }</div>
  <button class="done-btn" onclick={clearBought}>DONE</button>
</div>

<style scoped>
  .bought-queuer {
    font-size : 0;
  }
  .bought-queuer:after {
    font-size : 24pt;
    content : '🚩';
  }
  .mylocation {
    font-size : 0;
  }
  .mylocation:after {
    font-size : 24pt;
    content : '●';
    color : #3366dd;
  }
  .queuerPhoto{
    width : 54px;
    height : 64px;
    border-radius : 32px;
    margin : 10px;
  }
  .done-btn {
    margin-top: 20px;
    font-family: Arial, Helvetica, sans-serif;
    font-size: 25px;
    color: #ffffff;
    padding: 10px 20px;
    background-color:#ef7778;
    border-radius:25px;
  }
</style>

<script>


  this.on('mount',()=>{
    if(!App.apis.LoginApi.user){
      document.location.hash = 'login';
      return;
    }
    this.myuid = App.apis.LoginApi.user.uid;
    App.apis.DbApi.getBoughtPosition(this.myuid).then((queuer)=>{
      console.log(queuer);
      this.boughtQueuer = queuer;
      this.queuerPhoto = queuer.uphoto;
      this.queuerName = queuer.uname;
      this.queuerLocation = queuer.location;
      this.initMap();
      this.update();
    });
  });

  this.initMap = ()=>{
    this.map = new App.apis.LJMapApiClass();
    this.map.createMap('map',this.queuerLocation,()=>{
      this.map.addMarker('bought-queuer',this.queuerLocation);
    });

  }

  this.clearBought = ()=>{
    App.apis.DbApi.clearBoughtPosition(this.myuid);
    document.location.href = '/#/login';
  };
</script>

</recept>
