class LiveResults extends React.Component {
  constructor() {
    super();

    this.state = {
      race: undefined
    }
  }

  componentWillMount() {
    this.ajax = new Ajax(
      '/races/get_live',
      (data) => {
        this.setState({race: data});
        RaceResultActions.setRace(data.id);
        RaceResultActions.startRace(new Date(data.started_at));
      },
      (error, status) => {
        alert(error, status);
      }
    );

    this.ajax.get();
  }

  render() {
    return(
      <span id="liveResults">
        <RaceTime />
        <hr/>
        {
          this.state.race ?
          <RaceResults raceId={this.state.race.id} />
          : null
        }
      </span>
    )
  }
}
