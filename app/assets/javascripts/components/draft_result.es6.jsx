class DraftResult extends React.Component {

  componentDidMount() {
    let data = {
      start_number: this.props.result.racerNumber,
      race_id: DraftResultStore.getRaceId(),
      time: this.props.result.time,
      status: 3
    };

    let ajax = new Ajax(
      '/race_results/from_timing',
      (data) => {
        console.log(data);
      },
      (error, status) => {
        console.log(error, status);
      }
    );

    ajax.post(data);
  }

  render() {
    const {result} = this.props;
    const raceStartTime = DraftResultStore.getRaceStartDate();
    const timeDiff = result.time - raceStartTime;
    const duration = moment.duration(timeDiff, 'milliseconds');
    return (
      <tr>
        <td>{result.racerNumber}</td>
        <td>
          {duration.humanize()}
        </td>
        <td>
          {result.status}
        </td>
      </tr>
    );
  }
}
