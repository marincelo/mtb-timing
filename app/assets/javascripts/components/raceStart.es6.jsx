class RaceStart extends React.Component {
  constructor() {
    super();

    this.state = {
      selectedRaceId: 0,
      raceStarted: false
    }
  }

  selectRace(event) {
    let raceId = event.target.value;
    // GET race tp check if it has been started
    let ajax = new Ajax(
      `/races/${raceId}.json`,
      (data) => {
        if(data.started_at) {
          RaceResultActions.startRace(new Date(data.started_at));
          this.setState({ raceStarted: true });
        }
        RaceResultActions.setRace(raceId);
        this.setState({ selectedRaceId: raceId });
      },
      (error, status) => {
        console.log(error, status);
      }
    );

    ajax.get();
  }

  startRace() {
    // PUT started_at to selected race
    let data = {
      started_at: timeSync.now()
    }
    // show end race button
    let ajax = new Ajax(
      `/races/${this.state.selectedRaceId}`,
      (data) => {
        this.setState({raceStarted: true});
        RaceResultActions.startRace(new Date(data.started_at));
        RaceResultActions.setRace(this.state.selectedRaceId);
      },
      (error, status) => {
        console.log(error, status);
      }
    );

    ajax.put(data);
  }

  endRace() {
    let data = {
      ended_at: timeSync.now()
    }
    // show end race button
    let ajax = new Ajax(
      `/races/${this.state.selectedRaceId}`,
      (data) => {
        console.log(data);
      },
      (error, status) => {
        console.log(error, status);
      }
    );

    ajax.put(data);
  }

  render () {
    const {races} = this.props;
    return (
      <div>
        <select
          name=""
          id=""
          style={{ width: '180px', marginRight: '2em' }}
          onChange={ this.selectRace.bind(this) }
        >
          <option value="0">Odaberi utrku</option>
          {
            races.map((race)=>{
              return <option key={`race-select-${race.id}`} value={race.id}>{race.name}</option>;
            })
          }
        </select>
        {
          this.state.raceStarted ?
          (
           <button
              className="mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect"
              onClick={ this.endRace.bind(this) }
            >
              Finish
            </button>
          )
          :
          null
        }
        {
          !this.state.raceStarted && this.state.selectedRaceId ?
          (
            <button
              className="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect"
              onClick={ this.startRace.bind(this) }
            >
              Start
            </button>
          )
          :
          null
        }
        {
          this.state.raceStarted ?
          <p> Utrka startala: <b>{(new Date(DraftResultStore.getRaceStartDate())).toLocaleString()}</b></p>
          :
          null
        }
      </div>
    );
  }
}
