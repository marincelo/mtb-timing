class RaceTime extends React.Component {
  constructor() {
    super();

    this.onChange = this.onChange.bind(this);
    this.state = {
      raceTime: 0
    }
  }

  onChange() {
    const startDate = DraftResultStore.getRaceStartDate();
    if(startDate) {
      setInterval(()=>{
        let time = timeSync.now() - startDate;
        this.setState({raceTime: timeSync.humanTime(time)});
      }, 1000)
    }
  }

  componentWillMount() {
    DraftResultStore.on('draftResultStore.startRace', this.onChange);
  }

  componentWillUnmount() {
    DraftResultStore.off('draftResultStore.startRace', this.onChange);
  }

  render() {
    return(
      <span id="raceTime">
        <h1>
          {this.state.raceTime}
        </h1>
      </span>
    )
  }
}
