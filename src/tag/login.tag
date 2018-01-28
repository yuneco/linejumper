<login>

  <div class="title">
  </div><br/>
  <h3 style="margin-top:-150px;margin-bottom:100px;">Save your time.</h3>

<button class="login-google-btn" onclick={loginWithGoogle} ><i class="fa fa-google" aria-hidden="true"></i> Login with Google</button>

<style scoped>
  .title {
    height: 50%;
    background-image: url('img/logo.png');
    background-repeat: no-repeat;
    background-size: 60%;
    background-position: center center;

  }

  .login-google-btn {
    font-family: Arial, Helvetica, sans-serif;
    font-size: 25px;
    color: #ffffff;
    padding: 10px 20px;
    background-color:#ef7778;
    border-radius:25px;
  }
</style>

<script>
  this.timerid = null;
  this.on('mount',()=>{
    this.timerid = window.setInterval(()=>{
      if(App.apis.LoginApi.user){
        window.clearInterval(this.timerid);
        // move to home
        window.document.location.hash = 'home';
      }
    },100);
  });

  this.on('unmount',()=>{
    window.clearInterval(this.timerid);
  });


  this.loginWithGoogle = ()=>{
    App.apis.LoginApi.loginWithGoogle();
  };
</script>

</login>
