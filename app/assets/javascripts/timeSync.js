class TimeSync {
  constructor() {
    this.ts = timesync.create({
      server: '/timesync'
    });
  }

  now() {
    return this.ts.now().toFixed();
  }
}

timeSync = new TimeSync();
