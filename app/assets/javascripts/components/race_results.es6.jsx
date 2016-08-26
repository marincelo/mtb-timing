class RaceResults extends React.Component {

  constructor() {
    super();

    this.onChange = this.onChange.bind(this);
    this.state = {
      items: DefaultStore.getItems()
    }
  }

  onChange() {
    this.setState({items: DefaultStore.getItems()});
  }

  componentDidMount() {
    DefaultStore.on('defaultStore.change', this.onChange);
  }

  componentWillUnmount() {
    DefaultStore.off('defaultStore.change', this.onChange);
  }

  render () {
    console.log('act', DefaultStoreActions);
    return (
      <div>
        {
          this.state.items.map((item)=>{
            console.log(item);
            return <RaceResult key={(new Date()).getTime()} racer={item.name} laptimes={item.lapTime} />
          })
        }

        <button onClick={()=>{DefaultStoreActions.addItem({name: 'Ivan'})}}>Add Ivan</button>
      </div>
    );
  }
}
