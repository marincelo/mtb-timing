class RaceResult extends React.Component {
  render () {
    return (
      <div>
        <div>Racer: {this.props.racer}</div>
        <span>Race: {this.props.race}</span>
        <span>Status: {this.props.status}</span>
        <span>Laptimes: {this.props.laptimes}</span>
        <hr />
      </div>
    );
  }
}

RaceResult.propTypes = {
  racer: React.PropTypes.node,
  race: React.PropTypes.node,
  status: React.PropTypes.node,
  laptimes: React.PropTypes.array
};
