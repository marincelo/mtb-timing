class RaceResults extends React.Component {
  constructor() {
    super();

    this._handleSwitchView = this._handleSwitchView.bind(this);
    this._handleSwitchSize = this._handleSwitchSize.bind(this);
    this._handleSwitchOrder = this._handleSwitchOrder.bind(this);
    this._raceResultView = this._raceResultView.bind(this);

    this.state = {
      race: { race_results: [] },
      categoryView: false,
      largeView: false,
      newestFirst: false
    }
  }

  _handleSwitchView(event) {
    this.setState({categoryView: event.target.checked})
  }

  _handleSwitchSize(event) {
    this.setState({largeView: event.target.checked})
  }

  _handleSwitchOrder(event) {
    this.setState({newestFirst: event.target.checked})
  }

  _renderSequential() {
    const newestFirst = this.state.newestFirst;
    const sortingFunction = this._getSortingFunction(newestFirst);

    return this.state.race.race_results
      .filter(this._filterFinished)
      .sort(sortingFunction)
      .map(this._raceResultView);
  }

  _renderByCategory() {
    const newestFirst = this.state.newestFirst;
    const sortingFunction = this._getSortingFunction(newestFirst);

    const categories = ['zene', 'u16', '16-20', '20-30', '30-40', '40-50', '50+'];
    let finishedTimes = this.state.race.race_results.filter(this._filterFinished);

    return categories.map(category => {
      return [<tr className={`cat-${category.replace('+', '')}`}><td colSpan="6"><b>{category.toUpperCase()}</b></td></tr>]
        .concat(finishedTimes.filter((a)=>{
          return a.racer.category === category;
        })
        .sort(sortingFunction)
        .map(this._raceResultView));
    });
  }

  _renderActive() {
    return this.state.race.race_results.filter(rr => {
        return rr.finish_time === '- -'
      }).map(this._raceResultView);
  }

  _filterFinished(result) {
    return result.finish_time !== '- -' && result.status === 3
  }

  _getSortingFunction(newestFirst) {
    return (a, b) => {
      if(a.finish_time < b.finish_time)
        return newestFirst ? 1 : -1;
      else if(a.finish_time === b.finish_time)
        return 0
      else
        return newestFirst ? -1 : 1;
    }
  }

  _raceResultView(raceResult) {
    return (<tr key={`race-result-${raceResult.id}`}>
      <td>{raceResult.racer.start_number && raceResult.racer.start_number.value}</td>
      <td>{raceResult.racer.category.toUpperCase()}</td>
      <td>{`${raceResult.racer.first_name} ${raceResult.racer.last_name}`}</td>
      <td>{raceResult.racer && raceResult.racer.club && raceResult.racer.club.name}</td>
      <td>{raceResult.finish_time === '- -' ? this._prettyStatus(raceResult.status) : raceResult.finish_time}</td>
      <td></td>
      </tr>)
  }

  _prettyStatus(status) {
    switch(status) {
      case 1:
        return 'Prijavljen';
      case 2:
        return 'Na stazi';
      case 3:
        return 'Zavrsio';
      case 4:
        return 'DNF';
      case 5:
        return 'DSQ';
      case 6:
        return 'DNS';
      default:
        return 'Prijavljen'
    }
  }

  componentWillMount() {
    this.ajax = new Ajax(
      `/races/${this.props.raceId}`,
      (data) => {
        this.setState({race: data})
      },
      (error, status) => {
        alert(error + status);
      }
    );

    this.ajax.get();

    setInterval(() => this.ajax.get(), 10000);
  }

  render () {
    return(
      <div>
        <h2>Trenutni rezultati</h2>

        <label htmlFor="switch1" className="mdl-cell mdl-cell--4-col mdl-cell--12-col-phone mdl-switch mdl-js-switch mdl-js-ripple-effect">
          <input type="checkbox" id="switch1" className="mdl-switch__input" onClick={this._handleSwitchView} />
          <span className="mdl-switch__label">Prikaz po kategorijama</span>
        </label>

        <label htmlFor="switch2" className="mdl-cell mdl-cell--4-col mdl-cell--12-col-phone mdl-switch mdl-js-switch mdl-js-ripple-effect">
          <input type="checkbox" id="switch2" className="mdl-switch__input" onClick={this._handleSwitchSize} />
          <span className="mdl-switch__label">Veliki prikaz</span>
        </label>

        <label htmlFor="switch3" className="mdl-cell mdl-cell--4-col mdl-cell--12-col-phone mdl-switch mdl-js-switch mdl-js-ripple-effect">
          <input type="checkbox" id="switch3" className="mdl-switch__input" onClick={this._handleSwitchOrder} />
          <span className="mdl-switch__label">Najnoviji prvi</span>
        </label>
        <br/>
        <br/>
        <table
          className={`${this.state.largeView ? 'large-view' : ''} mdl-data-table wide_table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp`}
        >
          <thead>
            <tr>
              <td>Broj</td>
              <td>Kategorija</td>
              <td>Ime</td>
              <td>Klub</td>
              <td>Vrijeme</td>
              <td></td>
            </tr>
          </thead>
          <tbody>
            {
              this.state.categoryView ?
              this._renderByCategory()
              :
              this._renderSequential()
            }
          </tbody>
        </table>

        <h2>Nisu zavrsili</h2>

        <table
          className={`${this.state.largeView ? 'large-view' : ''} mdl-data-table wide_table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp`}
        >
          <thead>
            <tr>
              <td>Broj</td>
              <td>Kategorija</td>
              <td>Ime</td>
              <td>Klub</td>
              <td>Status</td>
            </tr>
          </thead>
          <tbody>
            {
              this._renderActive()
            }
          </tbody>
        </table>
      </div>
    );
  }
}
