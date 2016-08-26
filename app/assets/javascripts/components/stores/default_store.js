var DefaultStore = flux.createStore({
    items: [{
        name: 'Marin store test'
    }],
    createdAt: (new Date()).getTime(),
    actions: [
      DefaultStoreActions.addItem
    ],
    addItem: function(item) {
        let timeDiff = (new Date()).getTime() - this.createdAt;
        item.lapTime = moment.duration(timeDiff, 'milliseconds').humanize();
        this.items.push(item);
        this.emit('defaultStore.change');
    },
    exports: {
        getItems: function () {
            return this.items;
        }
    }
});
