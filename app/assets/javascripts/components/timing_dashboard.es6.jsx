class TimingDashboard extends React.Component {
  constructor() {
    super();

    this.onChange = this.onChange.bind(this);

    this.state = {
      show: false
    }
  }

  onChange() {
    this.setState({show: DraftResultStore.getRaceId()})
  }

  componentDidMount() {
    DraftResultStore.on('draftResultStore.setRace', this.onChange);
  }

  componentWillUnmount() {
    DraftResultStore.off('draftResultStore.setRace', this.onChange);
  }

  createRaceResult(event) {
    if(event.keyCode == 13 && event.target.value.length) {
      let startNumber = parseInt(event.target.value);
      if(startNumber) {
        RaceResultActions.newRaceResult(event.target.value, timeSync.now());
        event.target.value = '';
      }
      else {
        alert('Pogresan broj. Pokusaj ponovno.');
      }
    }
  }

  render () {
    return (
      <div className={`${this.state.show ? '' : 'hidden'} mdl-grid`}>
        <div className="mdl-cell mdl-cell--6-col">
          <h4 style={{marginLeft: '20px'}}>Unesi startni broj</h4>
          <input type="text" id="raceResultInput" onKeyUp={ this.createRaceResult } />
          <RaceResultForm />
        </div>
        <div className="mdl-cell mdl-cell--6-col">
          <DraftResults />
        </div>
      </div>
    );
  }
}
