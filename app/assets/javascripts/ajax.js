class Ajax {

  constructor(url, success, error) {
    this.url = url;
    this.error = error;

    this.xhr = new XMLHttpRequest();
    this.xhr.withCredentials = true;
    this.xhr.onreadystatechange = (() => {
      if (this.xhr.readyState === 4 && this.xhr.status >= 200 && this.xhr.status < 400) {
        success(this._getData());
      } else if (this.xhr.readyState === 4 && this.xhr.status > 399) {
        if(this.xhr.status === 401 || this.xhr.status === 403) {
          error(this.xhr.status, 'Unauthorized');
        } else if (this.xhr.status >= 500) {
          error(this.xhr.status, 'Internal Server Error');
        } else {
          error(this.xhr.status, this._getData());
        }
      }
    });
  }

  _getData() {
    try {
      return JSON.parse(this.xhr.responseText);
    }
    catch(err) {
      return this.xhr.responseText;
    }
  }

  get() {
    this.xhr.open('GET', this.url, true);
    this._setXhrTimeout();
    this.xhr.setRequestHeader('Accept', 'application/json');
    this.xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    this.xhr.send();
  }

  post(data) {
    this.xhr.open('POST', this.url, true);
    this._setXhrTimeout();
    this.xhr.setRequestHeader('Accept', 'application/json');
    this.xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    this.xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    this.xhr.send(JSON.stringify(data));
  }

  put(data) {
    this.xhr.open('PUT', this.url, true);
    this._setXhrTimeout();
    this.xhr.setRequestHeader('Accept', 'application/json');
    this.xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    this.xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    this.xhr.send(JSON.stringify(data));
  }

  delete(data) {
    this.xhr.open('DELETE', this.url, true);
    this._setXhrTimeout();
    this.xhr.setRequestHeader('Accept', 'application/json');
    this.xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    this.xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    this.xhr.send(JSON.stringify(data));
  }

  _setXhrTimeout() {
    // IE11 bug workaround
    this.xhr.timeout = 20000; // 20 sec
    this.xhr.ontimeout = (() => this.error(598, {message: "Server timed out"}));
  }
}
