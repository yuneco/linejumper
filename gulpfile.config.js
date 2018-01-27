const config =  {
    data : {
        /* build path */
        'path' : {
            'dev' : {
                'dest' : 'dist'
            },
            'prd' : {
                'dest' : 'prod'
            }
        },
        /* replacement definition */
        /* in html and js, you can use these keys like : @@key */
        'replace' : {
            'dev' : {
              'firebase.apiKey': 'AIzaSyCApRVGwtJI-h4NTRaICy9E_LoxBGnHcnc',
              'firebase.authDomain': 'linejumper-a1b5e.firebaseapp.com',
              'firebase.databaseURL': 'https://linejumper-a1b5e.firebaseio.com',
              'firebase.projectId': 'linejumper-a1b5e',
              'firebase.storageBucket': 'linejumper-a1b5e.appspot.com',
              'firebase.messagingSenderId': '109299010957',
              'common.fqdn':'linejumper-a1b5e.firebaseapp.com'
            },
            'prd' : {
              'firebase.apiKey': 'AIzaSyCApRVGwtJI-h4NTRaICy9E_LoxBGnHcnc',
              'firebase.authDomain': 'linejumper-a1b5e.firebaseapp.com',
              'firebase.databaseURL': 'https://linejumper-a1b5e.firebaseio.com',
              'firebase.projectId': 'linejumper-a1b5e',
              'firebase.storageBucket': 'linejumper-a1b5e.appspot.com',
              'firebase.messagingSenderId': '109299010957',
              'common.fqdn':'linejumper-a1b5e.firebaseapp.com'
          }
        }
    },

    get replaceDev(){
        return replaceMap('dev');
    },

    get replacePrd(){
        return replaceMap('prd');
    }

};

const replaceMap = (type)=>{
    const def = config.data.replace[type];
    const maps = [];
    Object.keys(def).forEach((key)=>{
        maps.push({match : key , replacement : def[key]});
    });
    return maps;
}

export default config;


