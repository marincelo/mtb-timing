class TempResult extends React.Component {
    constructor() {
        super();

        this.saveResult = this.saveResult.bind(this);
        this.removeTempResult = this.removeTempResult.bind(this);
        this.updateStartNumber = this.updateStartNumber.bind(this);

        this.state = {
          racerNumber: undefined
        }
    }

    saveResult() {
      const {racerNumber} = this.state;
      const {result} = this.props;

      if(racerNumber) {
        RaceResultActions.newRaceResult(racerNumber, result.time, 0);
        this.removeTempResult();
      }
      else {
        alert('Ispuni broj!');
      }
    }

    updateStartNumber(event) {
      this.setState({racerNumber: event.target.value});
      if(event.keyCode == 13) {
        this.saveResult();
      }
    }

    removeTempResult() {
      console.log('removeTempResult');
      RaceResultActions.removeTempResult(this.props.result.time);
    }

    render() {
        const {result} = this.props;
        const time = timeSync.humanTime(result.time - DraftResultStore.getRaceStartDate());
        return (
            <tr>
              <td>
                <input
                  type="text"
                  placeholder="Startni broj"
                  onKeyUp={this.updateStartNumber}
                  style={{width: '100px'}}
                />
              </td>
              <td>
                { time }
              </td>
              <td>
                <button
                  className={`mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect`}
                  onClick={this.saveResult}
                >
                  Spremi
                </button>
              </td>
              <td>
                <button
                  className={`mdl-button mdl-js-button mdl-button--raised mdl-button--accent mdl-js-ripple-effect`}
                  onClick={this.removeTempResult}
                >
                  Ponisti
                </button>
              </td>
            </tr>
        );
    }
}
