class TimingDashboard extends React.Component {

  createRaceResult(event) {
    if(event.keyCode == 13 && event.target.value.length) {
      let startNumber = parseInt(event.target.value);
      if(startNumber) {
        RaceResultActions.newRaceResult(event.target.value, new Date());
        event.target.value = '';
      }
      else {
        alert('Pogresan broj. Pokusaj ponovno.');
      }
    }
  }

  render () {
    return (
      <div>
        <label htmlFor="raceResultInput">Unesi startni broj</label>
        <input type="text" id="raceResultInput" onKeyUp={ this.createRaceResult } />
        <DraftResults />
      </div>
    );
  }
}
