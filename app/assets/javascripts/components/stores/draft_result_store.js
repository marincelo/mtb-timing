var DraftResultStore = flux.createStore({
    raceResults: [],
    uploadedResults: [],
    raceStartDate: undefined,
    raceId: undefined,
    actions: [
      RaceResultActions.newRaceResult,
      RaceResultActions.removeRaceResult,
      RaceResultActions.startRace,
      RaceResultActions.setRace
    ],
    newRaceResult: function(racerNumber, time, status) {
        this.raceResults.push({ racerNumber, time, status });
        this.emit('draftResultStore.change');
    },
    removeRaceResult: function(racerNumber) {
        this.raceResults.forEach((raceResult, index)=>{
            if(raceResult.racerNumber === racerNumber) {
                this.raceResults.splice(index, 1);
                return;
            }
        });
        this.emit('draftResultStore.change');
    },
    startRace: function(raceStartDate) {
        this.raceStartDate = raceStartDate;
        this.emit('draftResultStore.startRace');
    },
    setRace: function(raceId) {
        this.raceId = raceId;
        this.emit('draftResultStore.setRace');
    },
    exports: {
        getRaceResults: function () {
            return this.raceResults;
        },
        getUploadedResults: function () {
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
