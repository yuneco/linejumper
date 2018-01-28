import firebase from '../firebase/firebase';
const root = firebase.database().ref();

export default {

  /**
   * create new user.
   * @param {string} uid this id should be provided FirebaseAuth
   * @param {string} name any name to display
   * @return {Promise}
   */
  createUser (uid, name, photo) {
    const ref = root.child(`users/${uid}`);
    return ref.update({
      uid, name, photo
    });
  },

  createDestination (name,destid,{lat, lng}) {
    const ref = root.child('dests');
    return ref.child(destid).update({
      destid, name, location: {lat, lng}
    }).then(()=>{return destid});
  },


  finishQueuer (uid) {
    const uref = root.child(`users/${uid}`);
    return uref.once('value').then(snap=>{
      const val = snap.val();
      const queuerid = val.queuerid;
      if(queuerid){
        const updates = {
          [`queuers/${queuerid}`]: null,
          [`users/${uid}/queuerid`]: null
        };
        return root.update(updates);
      }
    });

  },

  createQueuer (destid, uid, price, {lat, lng}) {
    const ref = root.child('queuers');
    const queuerid = ref.push().key;

    const uref = root.child(`users/${uid}`);
    return uref.once('value').then(snap=>{
      const val = snap.val();
      const uname = val.name;
      const uphoto = val.photo;
      return ref.child(queuerid).update({
        queuerid, uid, uname, uphoto, destid, price, location: {lat, lng}
      })
      .then(()=>{
          return uref.update({
            queuerid
          });
        })
      .then(()=>{return queuerid});

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

    const destRef = root.child(`dests/${destid}`);
    return destRef.once('value').then(snap=>{
      const dest = snap.val();
      const ref = root.child('queuers').orderByChild('destid').equalTo(destid);
      ref.on('value',snap=>{
        const vals = snap.val();
        const queuers = [];
        if(vals){
          Object.keys(vals).forEach(k=>{
            queuers.push(vals[k]);
          });
        }
        onchange(dest,queuers);
      });
    });
  },

  /**
   *
   * @param {string} uid
   * @return {Promise}
   */
  getUserInfo (uid) {
    const ref = root.child(`users/${uid}`);
    return ref.once('value').then(snap=>{return snap.val()});
  }



};
