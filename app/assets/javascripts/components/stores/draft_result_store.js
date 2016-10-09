var DraftResultStore = flux.createStore({
    raceResults: [],
    uploadedResults: [],
    tempResults: [],
    raceStartDate: undefined,
    raceId: undefined,
    actions: [
      RaceResultActions.newRaceResult,
      RaceResultActions.newTempResult,
      RaceResultActions.removeRaceResult,
      RaceResultActions.removeTempResult,
      RaceResultActions.startRace,
      RaceResultActions.setRace
    ],
    newRaceResult: function(racerNumber, time, status) {
        this.raceResults.push({ racerNumber, time, status });
        this.emit('draftResultStore.change');
    },
    newTempResult: function(time) {
        this.tempResults.push({time});
        this.emit('draftResultStore.newTempResult');
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
    removeTempResult: function(time) {
        console.log(time, this.tempResults);
        this.tempResults.forEach((tempResult, index)=>{
            if(tempResult.time === time) {
                this.tempResults.splice(index, 1);
                return;
            }
        });
        this.emit('draftResultStore.newTempResult');
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
        getTempResults: function () {
            return this.tempResults;
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
