import firebase from '../firebase/firebase';
const root = firebase.database().ref();

export default {

  /**
   * create new user.
   * @param {string} uid this id should be provided FirebaseAuth
   * @param {string} name any name to display
   * @return {Promise}
   */
  createUser (uid, name) {
    const ref = root.child(`users/${uid}`);
    return ref.update({
      uid, name
    });
  },

  createDestination (name, {lat, lng}) {
    const ref = root.child('dests');
    const destid = ref.push().key;
    return ref.child(destid).update({
      destid, name, location: {lat, lng}
    });
  },

  createQueuer (destid, uid, price, {lat, lng}) {
    const ref = root.child('queuers');
    const queuerid = ref.push().key;

    const uref = root.child(`users/${uid}`);
    return uref.once('value').then(snap=>{
      const val = snap.val();
      const uname = val.name;
      return ref.child(queuerid).update({
        queuerid, uid, uname, destid, price, location: {lat, lng}
      });
    });

  },

  updateQueuerLocation (queuerid, {lat, lng}) {
    const ref = root.child(`queuers/${queuerid}`);
    return ref.update({
      location: {lat, lng}
    });
  },


  getDestinations () {
    const ref = root.child('dests');
    return ref.once('value').then(snap=>{
      const vals = snap.val();
      const dests = [];
      Object.keys(vals).forEach(k=>{
        dests.push(vals[k]);
      });
      return dests;
    });
  },

  watchQueuers (destid, onchange) {
    root.child('queuers').orderByChild('destid').off();
    if(!onchange){return}

    const ref = root.child('queuers').orderByChild('destid').equalTo(destid);
    ref.on('value',snap=>{
      const vals = snap.val();
      const queuers = [];
      Object.keys(vals).forEach(k=>{
        queuers.push(vals[k]);
      });
      onchange(destid,queuers);
    });
  }




};
