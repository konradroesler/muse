# Muse

Mobile application to learn and practice music.

## TODO

- track db name
- metronome ui + features
- tuner ui + features
- transcriber audio player 

### TODO now

- remove file column from db
- remove file field from track model
- instead of giving picked file as argument for the Track constructor, copy file directrly to '$dbPath/${track.id}.${fileExtension}'

#### as a result
- reintroduce Track into PlayTrackState
- change LocalStorageTrackApi accordingly
