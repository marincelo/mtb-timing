class DraftResults extends React.Component {
  constructor() {
    super();

    this.onChange = this.onChange.bind(this);

    this.state = {
      draftResults: DraftResultStore.getRaceResults()
    };
  }

  onChange() {
    this.setState({draftResults: DraftResultStore.getRaceResults()});
  }

  componentDidMount() {
    DraftResultStore.on('draftResultStore.change', this.onChange);
  }

  componentWillUnmount() {
    DraftResultStore.off('draftResultStore.change', this.onChange);
  }


  render() {
    return (
      <div>
        <h4>Stanje sinkronizacije</h4>
        <table
          className="mdl-data-table mdl-js-data-table mdl-shadow--2dp"
        >
          <thead>
            <tr>
              <td>Startni broj</td>
              <td>Vrijeme</td>
              <td>Status</td>
              <td></td>
            </tr>
          </thead>
          <tbody>
            {
              this.state.draftResults.map((result)=>{
                return <DraftResult key={`draft-result-${result.racerNumber}-${result.time}`} result={result} />;
              })
            }
          </tbody>
        </table>
      </div>
    );
  }
}
