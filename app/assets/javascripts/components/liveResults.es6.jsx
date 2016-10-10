class LiveResults extends React.Component {
  constructor() {
    super();

    this.state = {
      race: undefined,
      message: undefined
    }
  }

  componentWillMount() {
    this.ajax = new Ajax(
      '/races/get_live',
      (data) => {
        console.log(data);
        if(data != null) {
          this.setState({race: data});
          RaceResultActions.setRace(data.id);
          RaceResultActions.startRace(new Date(data.started_at));
        }
        else {
          this.setState({message: 'Nema aktivne utrke.'});
        }
      },
      (error, status) => {
        this.setState({message: `${error} ${status}`});
      }
    );

    this.ajax.get();
  }

  render() {
    return(
      <span id="liveResults">
        {
          this.state.message ?
          <h1>{this.state.message}</h1>
          : null
        }
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
