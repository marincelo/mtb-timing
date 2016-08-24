class RaceResults extends React.Component {
  render () {
    console.log(DefaultStore.getItems());
    return (
      <div>
        <RaceResult racer={DefaultStore.getItems()[0].name} laptimes={['1:10:23.100']} />
      </div>
    );
  }
}
