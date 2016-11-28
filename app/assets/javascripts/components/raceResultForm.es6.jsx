class RaceResultForm extends React.Component {
    constructor() {
        super();

        this.saveResult = this.saveResult.bind(this);
        this.updateStartNumber = this.updateStartNumber.bind(this);
        this.updateHours = this.updateHours.bind(this);
        this.updateMinutes = this.updateMinutes.bind(this);
        this.updateSeconds = this.updateSeconds.bind(this);

        this.state = {
          racerNumber: undefined,
          hours: 0,
          minutes: 0,
          seconds: 0
        }
    }

    getOptions(count, key) {
      let options = [];
      for (var i = 0; i < count; i++) {
        options.push(<option key={key + i} value={i}>{i}</option>);
      }
      return options;
    }

    saveResult() {
      const {racerNumber, hours, minutes, seconds} = this.state;
      let time = DraftResultStore.getRaceStartDate().getTime();
      time += hours*3600000;
      time += minutes*60000;
      time += seconds*1000;

      if(racerNumber && time) {
        RaceResultActions.newRaceResult(racerNumber, time);
      }
      else {
        alert('Ispuni sva polja!');
      }
    }

    updateStartNumber(event) {
      this.setState({racerNumber: event.target.value});
    }

    updateHours(event) {
      this.setState({hours: event.target.value});
    }

    updateMinutes(event) {
      this.setState({minutes: event.target.value});
    }

    updateSeconds(event) {
      this.setState({seconds: event.target.value});
    }

    render() {
        return (
          <div className="race-result-form">
              <h4>Dodaj rezultat</h4>
              <p><input type="number" min="1" placeholder="Startni broj" onKeyUp={this.updateStartNumber}/></p>
              <label htmlFor="">Vrijeme</label>
              <p>
                <select
                  name="raceResultHours"
                  id="raceResultHours"
                  className="tiny"
                  onChange={ this.updateHours }
                >
                  {this.getOptions(6, 'hours')}
                </select>
                <select
                  name="raceResultMinutes"
                  id="raceResultMinutes"
                  className="tiny"
                  onChange={ this.updateMinutes }
                >
                  {this.getOptions(60, 'minutes')}
                </select>
                <select
                  name="raceResultSeconds"
                  id="raceResultSeconds"
                  className="tiny"
                  onChange={ this.updateSeconds }
                >
                  {this.getOptions(60, 'seconds')}
                </select>
              </p>
              <div>
                <button
                  className={`mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect`}
                  onClick={this.saveResult}
                >
                  Spremi
                </button>
              </div>
          </div>
        );
    }
}
