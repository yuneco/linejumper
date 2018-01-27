import riot from 'riot';
import RiotControl from 'riotcontrol';
import router from './router.js';
import firebase from './firebase/firebase';
import DbApi from './apis/LJDbApi';
import LoginApi from './apis/LoginApi';
import LJMapApi from './apis/LJMapApi';

class Application {
  constructor() {
    this.controller = RiotControl;
    this.router = router;
    this.DEBUG = true;
    this.apis = {
      DbApi,
      LoginApi : new LoginApi(),
      LJMapApiClass : LJMapApi
    }
  }

  init() {
    // Someting to init if need
    this.apis.LoginApi.initLoginState(false);
    this.oninit();
  }

  oninit() {

    // mount app tag
    riot.mount('app');

    // start watch address bar url
    this.router.start(true);

  }
}

window.riot = riot;
window.firebase = firebase; //for test
window.App = new Application()
