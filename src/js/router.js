import riot from 'riot';
import route from 'riot-route';

route('/test', () => {
  riot.mount('stage', 'test');
});

route('/home', () => {
  riot.mount('stage', 'home');
});

route('/open', () => {
  riot.mount('stage', 'open');
});

route('/recept', () => {
  riot.mount('stage', 'recept');
});

route('/login', () => {
  riot.mount('stage', 'login');
});

export default route;
