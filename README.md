# Muse

> Disclaimer: All coding in this project was done without the use of LLM's and dates back to my summer break 2024. In order to make this project more presentable, I decided to write a proper readme. As I didn't have the time to familiarise myself with the details of the codebase again, I let an LLM take a look at the code and generate the 'What to build next' section of this readme for when I want to get back to this project.

Muse is a Flutter app for music practice. It aims to bring together a collection of tools which help you practice: a metronome, a tuner, and a transcription tool.

This is a work in progress and would need a considerable amount of work to be a polished product and publisheabll, but I consider it presentable nontheless. :)

## Motivation

Learning an instrument benefits from regular, deliberate practice. Muse is being built as a focused collection of tools that removes friction from that process—whether that means keeping time, checking intonation, or working through a recorded track. It was inspired by learning the saxophone, but is intended to be useful for musicians more broadly.

## Current features

### Metronome

- Adjustable tempo
- Play/pause control
- A four-beat visual counter

### Tuner

- Starts a microphone recording stream on demand
- Detects pitch from PCM audio samples
- Displays the detected note and its difference from the target pitch in cents

### Track workspace

- Import a single local audio file with the system file picker
- Copy imported audio to app-local storage
- Persist track names and IDs in a local SQLite database
- Rename and delete imported tracks
- Play, pause, and resume an imported track

## Architecture

Muse uses Flutter with the BLoC pattern for feature state and user interactions.

- `lib/home` owns the three-tab shell: Metronome, Tuner, and Transcriber
- `lib/metronome`, `lib/tuner`, and `lib/transcriber` contain the feature-specific pages, views, and BLoCs
- `packages/tracks_api` defines the track persistence interface and model
- `packages/local_storage_tracks_api` implements that interface with SQLite and a stream of saved tracks
- `packages/tracks_repository` exposes persistence to the application layer
- `packages/utils` contains shared app-storage and file-extension helpers

Audio files are stored in the app's database/application directory under their track ID. SQLite stores the corresponding metadata (currently the ID and display name).

## Try it yourself

### Prerequisites

- Flutter SDK compatible with Dart `3.4.3` or later.
- A physical device or emulator configured for the target platform.
- Microphone permission for the tuner.

### Run locally

```sh
flutter pub get
flutter run
```

The app includes local path packages, so clone the complete repository rather than copying only the root Flutter project.

## What to build next

The following roadmap focuses on turning the existing flows into dependable practice tools.

### Foundation and reliability

- Add automated unit, BLoC, repository, and widget tests for the existing behavior
- Pin direct dependency versions and add a supported Flutter/Dart version policy
- Add error states and user-facing feedback for database, file-picker, storage, audio-player, and microphone failures
- Ensure resources are cleaned up consistently when a page is dismissed, the app is backgrounded, or a feature is interrupted
- Add app lifecycle handling so active playback, recording, and metronome timing behave predictably
- Improve accessibility: semantic labels, sufficient color contrast, scalable layouts, keyboard navigation where relevant, and screen-reader-friendly controls

### Metronome

- Play a clear audio click on every beat using the included accent and regular metronome assets
- Add a configurable time signature, with an accent on the first beat and support for common signatures such as 3/4, 6/8, and 12/8
- Replace the random beat color with an intentional, accessible visual pulse
- Set practical tempo bounds and disable decrement/increment controls at those limits
- Add tap tempo, direct BPM input, preset tempos, and remembered last-used settings
- Improve timing accuracy and resilience while the device is under load or the screen is locked
- Add subdivisions, count-in bars, practice timers, and gradual tempo increase for structured exercises

### Tuner

- Request and clearly explain microphone permission before recording; show a useful recovery path when it is denied
- Let the musician choose an instrument or a chromatic mode instead of using the current guitar pitch handler unconditionally
- Show an intuitive tuning meter with flat/in-tune/sharp zones, a stable in-tune indication, and the detected frequency
- Smooth noisy readings and define a confidence threshold so weak or ambiguous input does not make the display jump
- Support configurable concert pitch (for example, A4 = 440 Hz) and transposing instruments such as alto and tenor saxophone
- Present idle, listening, unsupported-device, and error states distinctly
- Test recording lifecycle handling to prevent duplicate streams or events after stopping and restarting the tuner

### Track workspace and transcribing

- Implement the playback progress bar and seeking flow already identified in the codebase
- Subscribe to player duration and position, display elapsed/remaining time, and persist the last playback position when useful
- Add playback-speed controls, A/B loop points, and loop repetition—core features for learning a difficult passage by ear
- Support a broader, validated set of imported audio formats and show clear messages for invalid or unreadable files
- Store the original file extension and other useful metadata with each track rather than discovering it by scanning a fixed extension list
- Delete the associated local audio file when a track is deleted, with a confirmation/undo affordance to avoid accidental data loss
- Add track search, sorting, folders or practice sets, and duplicate-name handling
- Show import and copy progress for large files, and guard against insufficient storage
- Add waveform or timeline visualization, markers, notes, and timestamps to support transcription work
- Add recording and export/sharing flows if the workspace expands beyond imported tracks

### Product polish

- Give each feature a finished visual identity consistent with the app theme.
- Add onboarding that introduces microphone permission, track importing, and the three tools
- Persist user preferences such as theme, tempo, time signature, tuner calibration, and playback speed
- Add an in-app privacy note describing what stays on device and how microphone access is used
- Validate behavior on Android and iOS devices, particularly storage locations, audio sessions, permissions, and background behavior