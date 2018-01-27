import riot from 'riot';
import RiotControl from 'riotcontrol';
import router from './router.js';
import firebase from './firebase/firebase';
import DbApi from './db/LJDbApi';

class Application {
  constructor() {
    this.controller = RiotControl;
    this.router = router;
    this.DEBUG = true;
    this.apis = {
      DbApi
    }
  }

  init() {
    // Someting to init if need
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
