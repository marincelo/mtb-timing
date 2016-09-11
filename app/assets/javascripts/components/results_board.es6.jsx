class ResultsBoard extends React.Component {
  constructor() {
    super();

    this.onChange = this.onChange.bind(this);
    this.state = {
      results: ResultStore.getRaceResults()
    };
  }

  onChange() {
    this.setState({Results: ResultStore.getRaceResults()});
  }

  componentDidMount() {
    ResultStore.on('resultStore.change', this.onChange);
  }

  componentWillUnmount() {
    ResultStore.off('resultStore.change', this.onChange);
  }


  render() {
    return (
      <div>
        <h2>Upisani rezultati</h2>
        <ul
          className="mdl-list draft-result-list"
        >
          {
            this.state.results.map((result)=>{
              return <Result key={`result-${result.time.getTime()}`} result={result} />;
            })
          }
        </ul>
      </div>
    );
  }
}
