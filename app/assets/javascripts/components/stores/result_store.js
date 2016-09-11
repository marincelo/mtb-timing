var ResultStore = flux.createStore({
    raceResults: xhrResults,
    exports: {
        getRaceResults: function () {
            return this.raceResults;
        }
    }
});
