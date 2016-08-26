class DraftResults extends React.Component {
  constructor() {
    super();

    this.onChange = this.onChange.bind(this);
    this.state = {
      draftResults: DraftResultStore.getRaceResults()
    }
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
      <ul
        className="mdl-list draft-result-list"
      >
        {
          this.state.draftResults.map((result)=>{
            return <DraftResult key={`draft-result-${result.time.getTime()}`} result={result} />;
          })
        }
      </ul>
    )
  }
}
