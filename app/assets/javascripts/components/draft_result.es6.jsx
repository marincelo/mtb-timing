class DraftResult extends React.Component {
  constructor() {
    super();

    this.uploadResult = this.uploadResult.bind(this);
    this.deleteResult = this.deleteResult.bind(this);

    this.state = {
      status: 'uploading',
      failed: false
    }
  }

  uploadResult() {
    let data = {
      start_number: this.props.result.racerNumber,
      race_id: DraftResultStore.getRaceId(),
      time: this.props.result.time,
      status: 3
    };

    let ajax = new Ajax(
      '/race_results/from_timing',
      (data) => {
        this.setState({status: 'spremljeno', failed: false})
        // setTimeout(() => { RaceResultActions.removeRaceResult(this.props.result.racerNumber) }, 5*60*1000); // remove after 5 mins
      },
      (error, status) => {
        console.log(error, status);
        this.setState({status: 'nije uspjelo', failed: true})
      }
    );

    this.setState({status: 'uploading', failed: false})

    ajax.post(data);
  }

  deleteResult() {
    let data = {
      start_number: this.props.result.racerNumber,
      race_id: DraftResultStore.getRaceId(),
      time: this.props.result.time
    };

    let ajax = new Ajax(
      '/race_results/destroy_from_timing',
      (data) => {
        this.setState({status: 'izbrisano'})
        // setTimeout(() => { RaceResultActions.removeRaceResult(this.props.result.racerNumber) }, 5*60*1000); // remove after 5 mins
      },
      (error, status) => {
        console.log(error, status);
        this.setState({status: 'nije uspjelo brisanje'})
      }
    );

    this.setState({status: 'brisanje'})

    ajax.delete(data);
  }

  componentDidMount() {
    this.uploadResult();
  }

  render() {
    const {result} = this.props;
    const raceStartTime = DraftResultStore.getRaceStartDate();
    const timeDiff = result.time - raceStartTime;
    return (
      <tr>
        <td>{result.racerNumber}</td>
        <td>
          {timeSync.humanTime(timeDiff)}
        </td>
        <td>
          {this.state.status}
        </td>
        <td>
          <button
            className={`${this.state.failed ? '' : 'hidden'} mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect`}
            onClick={this.uploadResult}
          >
            Upload
          </button>
          <button
            className="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect"
            onClick={this.deleteResult}
          >
            Izbrisi
          </button>
          {
           !this.state.failed ?
           null
           :
            <button
              className="mdl-button mdl-js-button mdl-button--raised mdl-js-ripple-effect"
              onClick={() => {RaceResultActions.removeRaceResult(this.props.result.racerNumber)}}
            >
              Makni s liste
            </button>
          }
        </td>
      </tr>
    );
  }
}
