/*
  CustomMarkerを生成、アニメーション、削除するクラス
*/

export default class CustomMarker extends google.maps.OverlayView {

  constructor(opts,className) {
    super();
    // color, authoravatar, mufoid, location, size, areascale
    this.setValues(opts);
    this.className = className;
  }

  draw () {
    let div = this.div;
    if (!div) {
      div = this.div = $(`<div class="${this.className}">${this.className}</div>`)[0];
      div.style.position = 'absolute';
      div.style.width = '24px';
      div.style.height = '24px';
      const panes = this.getPanes();
      panes.overlayImage.appendChild(div);
    }
    const point = this.getProjection().fromLatLngToDivPixel(this.location);
    if (point) {
      div.style.left = (point.x - 12) + 'px';
      div.style.top = (point.y - 12) + 'px';
    }
  }

  remove () {
    if (this.div) {
      $(this.div).fadeOut('1000', () => {
        this.div.parentNode.removeChild(this.div);
        this.div = null;
      });
    }
  }

}
