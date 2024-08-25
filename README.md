# Muse

Mobile application to learn and practice music.

## TODO

- track db name
- metronome ui + features
- tuner ui + features
- transcriber audio player 

### TODO now

- remove file column from db X
- remove file field from track model X
- instead of giving picked file as argument for the Track constructor, copy file directrly to '$dbPath/${track.id}.${fileExtension}' X

#### as a result
- reintroduce Track into PlayTrackState X
- change LocalStorageTrackApi accordingly X
