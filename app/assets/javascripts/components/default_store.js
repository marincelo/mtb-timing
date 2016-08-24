var DefaultStore = flux.createStore({
    items: [{
        name: 'Marin store test'
    }],
    exports: {
        getItems: function () {
            return this.items;
        }
    }
});
