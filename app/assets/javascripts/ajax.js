class Ajax {

  constructor(url, success, error) {
    this.url = url;
    this.error = error;
    this.success = success;

    // bind instance methods
    this._handleXhrStateChange = this._handleXhrStateChange.bind(this);
    this._sendRequest = this._sendRequest.bind(this);

    this.xhr = new XMLHttpRequest();
    this.xhr.withCredentials = true;

    this.xhr.onreadystatechange = this._handleXhrStateChange;
  }

  _handleXhrStateChange() {
    if (this.xhr.readyState === 4 && this.xhr.status >= 200 && this.xhr.status < 400) {
      this.success(this._getData());
    }
    else if (this.xhr.readyState === 4 && this.xhr.status > 399) {
      if(this.xhr.status === 401 || this.xhr.status === 403) {
        this.error(this.xhr.status, 'Unauthorized');
      } else if (this.xhr.status >= 500) {
        this.error(this.xhr.status, 'Internal Server Error');
      } else {
        this.error(this.xhr.status, this._getData());
      }
    }
  };

  _getData() {
    try {
      return JSON.parse(this.xhr.responseText);
    }
    catch(err) {
      return this.xhr.responseText;
    }
  }

  _sendRequest(type = 'GET', data) {
    this.xhr.open(type, this.url, true);
    this._setXhrTimeout();
    this.xhr.setRequestHeader('Accept', 'application/json');
    this.xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    this.xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    if (data) {
      this.xhr.send(JSON.stringify(data));
    }
    else {
      this.xhr.send();
    }
  }

  get() {
    this._sendRequest()
  }

  post(data) {
    this._sendRequest('POST', data)
  }

  put(data) {
    this._sendRequest('PUT', data)
  }

  delete(data) {
    this._sendRequest('DELETE', data)
  }

  _setXhrTimeout() {
    // IE11 bug workaround
    this.xhr.timeout = 20000; // 20 sec
    this.xhr.ontimeout = (() => this.error(598, {message: "Server timed out"}));
  }
}
