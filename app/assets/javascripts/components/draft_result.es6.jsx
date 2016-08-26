class DraftResult extends React.Component {

  componentDidMount() {
    // alert('AJAXING to the backend!');
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
