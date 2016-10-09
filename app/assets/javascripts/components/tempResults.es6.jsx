class TempResults extends React.Component {
    constructor() {
        super();

        this.createTempResult = this.createTempResult.bind(this);
        this.onChange = this.onChange.bind(this);

        this.state = {
          results: []
        }
    }

    createTempResult() {
      RaceResultActions.newTempResult(timeSync.now());
    }

    onChange() {
      this.setState({results: DraftResultStore.getTempResults()})
    }

    componentDidMount() {
      DraftResultStore.on('draftResultStore.newTempResult', this.onChange);
    }

    componentWillUnmount() {
      DraftResultStore.off('draftResultStore.newTempResult', this.onChange);
    }

    render() {
        return (
          <div>
            <h4>Spremi prolazno vrijeme</h4>
            <button
              onClick={ this.createTempResult }
              className="mdl-button mdl-js-button mdl-button--raised mdl-button--colored mdl-js-ripple-effect"
              style={{display: 'block'}}
            >
              Spremi
            </button>
            <table>
              <thead>
                <tr>
                  <th>Broj</th>
                  <th>Vrijeme</th>
                  <th></th>
                </tr>
              </thead>
              <tbody>
                {
                  this.state.results.map((result)=>{
                    return <TempResult key={`temp-result-${result.time}`} result={result} />
                  })
                }
              </tbody>
            </table>
          </div>
        );
    }
}
