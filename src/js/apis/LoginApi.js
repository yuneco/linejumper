import firebase from '../firebase/firebase.js';
import FbCustomeRefBase from './FbCustomeRefBase.js';

export default class FbLoginUserRef extends FbCustomeRefBase {

  constructor(rootRef) {
    super(rootRef);
    this._defineCallback('loggedin');//um
    this._defineCallback('loggedout');
    this._defineCallback('loginstarted');
    this._defineCallback('profilechanged');

  }

  // ログアウト
  logout() {
    clearInterval(this._activeUpdateTimer);
    firebase.auth().signOut().then(() => {
      this._trigger('loggedout');
      this._userRef.watchUser(null);
    }, (error) => {
      console.warn('Logout failed');
    });
  }

  // googleでログイン
  loginWithGoogle() {
    const provider = new firebase.auth.GoogleAuthProvider();
    firebase.auth().signInWithRedirect(provider);
  }

  // facebookでログイン
  loginWithFacebook() {
    const provider = new firebase.auth.FacebookAuthProvider();
    firebase.auth().signInWithRedirect(provider);
  }

  // Twitter
  loginWithTwitter() {
    const provider = new firebase.auth.TwitterAuthProvider();
    firebase.auth().signInWithRedirect(provider);
  }


  /**
   * ログイン状況の初期化
   * @param {boolean} autoLogin セッションが無い場合にログインを試行するか
   * @param {string} provider ログインを試行する場合に利用するSNS名
   */
  initLoginState(autoLogin, provider) {

    // 初期化中の可能性があるので、変更監視
    firebase.auth().onAuthStateChanged((user) => {
      if (user) {
        // セッションを確立できたら、そのまま利用
        console.log('onAuthStateChanged: logged in', user);
        this.user = user;
      } else {
        // セッションを確立できなければ、ログイン要求
        if (!autoLogin) {
          console.log('not logged in');
          return;
        }
        switch (provider) {
          case 'google':
            console.log('try to login : google');
            this.loginWithGoogle();
            this._trigger('loginstarted', 'google');
            break;

          case 'facebook':
            console.log('try to login : facebook');
            this.loginWithFacebook();
            this._trigger('loginstarted', 'facebook');
            break;

          case 'twitter':
            console.log('try to login : twitter');
            this.loginWithTwitter();
            this._trigger('loginstarted', 'twitter');
            break;

          default:
            console.error('unknown auth provider', provider);
            break;
        }
      }
    })
  }


}
