<login>

  <div class="title">

  </div>

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
    font-size: 14px;
    color: #050505;
    padding: 10px 20px;
    background: -moz-linear-gradient(
      top,
      #ffffff 0%,
      #ebebeb 50%,
      #dbdbdb 50%,
      #b5b5b5);
    background: -webkit-gradient(
      linear, left top, left bottom,
      from(#ffffff),
      color-stop(0.50, #ebebeb),
      color-stop(0.50, #dbdbdb),
      to(#b5b5b5));
    -moz-border-radius: 4px;
    -webkit-border-radius: 4px;
    border-radius: 4px;
    border: 1px solid #949494;
    -moz-box-shadow:
      0px 1px 3px rgba(000,000,000,0.5),
      inset 0px 0px 2px rgba(255,255,255,1);
    -webkit-box-shadow:
      0px 1px 3px rgba(000,000,000,0.5),
      inset 0px 0px 2px rgba(255,255,255,1);
    box-shadow:
      0px 1px 3px rgba(000,000,000,0.5),
      inset 0px 0px 2px rgba(255,255,255,1);
    text-shadow:
      0px -1px 0px rgba(000,000,000,0.2),
      0px 1px 0px rgba(255,255,255,1);
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
