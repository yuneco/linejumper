<about>
<div id="about-page">
<div class="home" onclick={home}></div>
<div class="title" onclick={home}></div>
<h3 class="tagline">Save your time.</h3>

<About-Us>
		<div id="section">
			<h3>What is Line Jumper?</h3>
			We are a platform that allows you to buy, sell, or auction your spot in line.
		</div>

		<div id="section">
			<h3>How Can It Benefit Me?</h3>
			Saving your time by not waiting in line. Connect with others that are waiting to give up their spot for a price set by them.
		</div>

</About-Us>

</div>
<style scoped>

	About-Us {
		margin:auto;
		background-color:#fff !important;
		position:relative;
	}

	.home {
    height: 100px;
    width: 100px;
    left:20px;
    margin:10px;
    z-index:600;
    position:fixed;
    background-image: url('img/home.png');
    background-repeat: no-repeat;
    background-size: 60%;
    background-position: center center;
    cursor: pointer;
    background-color:#ef7778;
    border-radius:50px;
  }

	.title {
    height: 40%;
    background-image: url('img/logo.png');
    background-repeat: no-repeat;
    background-size: 60%;
    background-position: center center;
    position:relative;

  }

  #about-page {
  	width:100%;
  	height:100%;
    background-color:#fff !important;
    text-align:center;
    overflow:scroll;
    position:fixed;
    padding-bottom:50px;
  }

  #section {
  		margin:auto;
  		margin-bottom:20px;
  		width:80%;
  		border-radius:50px;
  		padding:50px;
  		text-align:left;
  		font-size:20px;
  		background-color:#A0D96E;
  }

  .tagline {
  		margin-top:80px;
  		margin-bottom:30px;
  		font-size:20px;
  		color:#EF7778;
  	}

  @media screen and (max-device-width: 480px) {
  	.title {
  			height:30%;
  	}

  	.tagline {
  		margin-top:-50px;
  		margin-bottom:30px;
  		font-size:12px;
  		color:#EF7778;
  	}

  	h3 {
  			font-size:20px;
  	}

  	#section {
  			font-size:10px;
  	}

  	.home {
    height: 50px;
    width: 50px;
    left:10px;
    position:fixed;
    background-image: url('img/home.png');
    background-repeat: no-repeat;
    background-size: 60%;
    background-position: center center;

  }

  }

  @media screen and (min-device-width: 480px) {
   	.tagline {
  		margin-top:-70px;
  		margin-bottom:30px;
  		font-size:20px;
  		color:#EF7778;
  	}

   }


</style>

<script>
		this.home = ()=>{
        window.clearInterval(this.timerid);
        // move to home
        window.document.location.hash = 'home';
    };

</script>

</about>
