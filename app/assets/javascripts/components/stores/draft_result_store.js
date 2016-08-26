var DraftResultStore = flux.createStore({
    raceResults: [],
    actions: [
      RaceResultActions.newRaceResult
    ],
    newRaceResult: function(racerNumber, time) {
        this.raceResults.push({ racerNumber, time });
        this.emit('draftResultStore.change');
    },
    exports: {
        getRaceResults: function () {
            return this.raceResults;
        }
    }
});
