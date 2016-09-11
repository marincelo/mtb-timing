class Result extends React.Component {
  render() {
    const {result} = this.props;

    return (
      <li className="mdl-list__item mdl-list__item--two-line">
        <span className="mdl-list__item-primary-content">
          <i className="material-icons mdl-list__item-avatar">person</i>
          <span>{result.racer.first_name}</span>
          <span className="mdl-list__item-sub-title">
            1:11
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
