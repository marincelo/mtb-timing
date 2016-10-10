class RaceResults extends React.Component {
  constructor() {
    super();

    this.state = {
      race: { race_results: [] }
    }
  }

  componentWillMount() {
    this.ajax = new Ajax(
      `/races/${this.props.raceId}`,
      (data) => {
        this.setState({race: data})
      },
      (error, status) => {
        alert(error, status);
      }
    );

    this.ajax.get();

    setInterval(() => this.ajax.get(), 10000);
  }

  render () {
    return(
      <div>
        <h2>Trenutni rezultati</h2>
        <table className="mdl-data-table wide_table mdl-js-data-table mdl-data-table--selectable mdl-shadow--2dp">
          <thead>
            <tr>
              <td>Broj</td>
              <td>Kategorija</td>
              <td>Ime Prezime</td>
              <td>Vrijeme</td>
              <td></td>
            </tr>
          </thead>
          <tbody>
            {
              this.state.race.race_results.filter((a)=>{
                // return a.finish_time != '- -'
                return true
              }).sort((a, b)=>{
                return a.finish_time > b.finish_time
              }).map((raceResult)=>{
                return (<tr key={`race-result-${raceResult.id}`}>
                  <td>{raceResult.racer.start_number}</td>
                  <td>{raceResult.racer.category.toUpperCase()}</td>
                  <td>{`${raceResult.racer.first_name} ${raceResult.racer.first_name}`}</td>
                  <td>{raceResult.finish_time}</td>
                  <td></td>
                </tr>)
              })
            }
          </tbody>
        </table>
      </div>
    );
  }
}
