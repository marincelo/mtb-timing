class TimingDashboard extends React.Component {

  createRaceResult(event) {
    if(event.keyCode == 13 && event.target.value.length) {
      RaceResultActions.newRaceResult(event.target.value, new Date());
      event.target.value = '';
    }
  }

  render () {
    return (
      <div>
        {
          // big input
        }
        <input type="text" id="raceResultInput" onKeyUp={ this.createRaceResult } />

        {
          // list of results waiting to be persisted
        }
        <DraftResults />
        {
          // list of persisted results
        }

      </div>
    );
  }
}
