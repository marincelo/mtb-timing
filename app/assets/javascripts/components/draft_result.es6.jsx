class DraftResult extends React.Component {

  componentDidMount() {
    let data = {
      race_result: {
        racer_start_number: this.props.result.racerNumber,
        lap_times: [this.props.result.time]
      }
    };

    let xhr = new XMLHttpRequest();
    xhr.withCredentials = true;
    xhr.onreadystatechange = (() => {
      if (xhr.readyState === 4 && xhr.status >= 200 && xhr.status < 400) {
        console.log(xhr.responseText);
        alert('gud');
      }
      else if (xhr.readyState === 4 && xhr.status > 399) {
        alert('xhr error');
        if(xhr.status === 401 || xhr.status === 403) {
        }
        else if (xhr.status >= 500) {
        }
        else {
        }
      }
    });

    xhr.open('POST', 'race_results', true);
    xhr.setRequestHeader('X-CSRF-Token', document.querySelector('meta[name="csrf-token"]').content);
    xhr.setRequestHeader('Accept', 'application/json');
    xhr.setRequestHeader("Content-Type", "application/json;charset=UTF-8");
    xhr.send(JSON.stringify(data));
  }

  render() {
    const {result} = this.props;
    const raceStartTime = (new Date()).getTime() - 3700000; // mock time
    const timeDiff = result.time.getTime() - raceStartTime;
    const duration = moment.duration(timeDiff, 'milliseconds');

    return (
      <li className="mdl-list__item mdl-list__item--two-line">
        <span className="mdl-list__item-primary-content">
          <i className="material-icons mdl-list__item-avatar">person</i>
          <span>{result.racerNumber}</span>
          <span className="mdl-list__item-sub-title">
            {duration.hours()}:
            {duration.minutes()}:
            {duration.seconds()}.
            {duration.milliseconds()}
          </span>
        </span>
        <span className="mdl-list__item-secondary-content">
          <span className="mdl-list__item-secondary-info">Racer</span>
          <a className="mdl-list__item-secondary-action" href="#"><i className="material-icons">star</i></a>
        </span>
      </li>
    );
  }
}
