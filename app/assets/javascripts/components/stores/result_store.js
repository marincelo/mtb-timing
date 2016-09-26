var ResultStore = flux.createStore({
    raceResults: [],
    exports: {
        getRaceResults: function () {
            return this.raceResults;
        }
    }
});
