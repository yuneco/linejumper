<footer-content>
  <div class="copyright">Copyright © 2018 LineJumper</div>
  <button class="logout-btn" onclick={logout} ><i class="fa fa-times" aria-hidden="true"></i>Logout</button>

  <style scoped>
    .copyright {
      text-align: center;
      line-height: 50px;
    }
    .logout-btn{
      position: absolute;
      line-height: 50px;
      right : 10px;
      bottom: 0;
      text-decoration: underline;
      background : transparent;
      border: none;
    }
  </style>

  <script>
    this.logout = ()=>{
      App.apis.LoginApi.logout().then(()=>{
        window.document.location = '/#/login';
      });
    };

  </script>

</footer-content>
