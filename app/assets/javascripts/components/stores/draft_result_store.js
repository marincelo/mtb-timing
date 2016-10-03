var DraftResultStore = flux.createStore({
    raceResults: [],
    raceStartDate: undefined,
    raceId: undefined,
    actions: [
      RaceResultActions.newRaceResult,
      RaceResultActions.startRace,
      RaceResultActions.setRace
    ],
    newRaceResult: function(racerNumber, time) {
        this.raceResults.push({ racerNumber, time, status });
        this.emit('draftResultStore.change');
    },
    startRace: function(raceStartDate) {
        console.log(raceStartDate);
        this.raceStartDate = raceStartDate;
    },
    setRace: function(raceId) {
        this.raceId = raceId;
    },
    exports: {
        getRaceResults: function () {
            return this.raceResults;
        },
        getRaceStartDate: function() {
          return this.raceStartDate;
        },
        getRaceId: function() {
          return this.raceId;
        }
    }
});
