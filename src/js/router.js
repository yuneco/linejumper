import riot from 'riot';
import route from 'riot-route';

route('/test', () => {
  riot.mount('stage', 'test');
});

route('/home', () => {
  riot.mount('stage', 'home');
});

route('/about', () => {
  riot.mount('stage', 'about');
});

route('/recept', () => {
  riot.mount('stage', 'recept');
});

route('/login', () => {
  riot.mount('stage', 'login');
});

route('/', () => {
  riot.mount('stage', 'login');
});

export default route;
