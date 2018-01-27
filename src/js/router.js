import riot from 'riot';
import route from 'riot-route';

route('/test', () => {
  riot.mount('stage', 'test');
});


export default route;
