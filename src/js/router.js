import riot from 'riot';
import route from 'riot-route';

route('/test', () => {
  riot.mount('stage', 'test');
});

route('/home', () => {
  riot.mount('stage', 'home');
});

export default route;
