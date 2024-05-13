// Define the tempo and time signature
tempo => float bpm;
4 => int beatsPerBar;

// Set the tempo and calculate the duration of a beat
120 => bpm;
60.0 / bpm => dur beat;

// Define the instruments
SndBuf barAmbience => dac;
SndBuf bassDrum => dac;
SndBuf snareDrum => dac;
SndBuf hiHat => dac;

// Load audio files
"bar_ambience.wav" => barAmbience.read;
"bass_drum.wav" => bassDrum.read;
"snare_drum.wav" => snareDrum.read;
"hi_hat.wav" => hiHat.read;

// Function to play a beat
fun void playBeat(int beatNum) {
    if (beatNum == 0) {
        bassDrum.play();
    } else if (beatNum % 2 == 0) {
        snareDrum.play();
    } else {
        hiHat.play();
    }
}

// Function to play the bar ambience
fun void playAmbience() {
    while (true) {
        barAmbience.play();
        4::second => now;
    }
}

// Start playing the bar ambience
spawn playAmbience();

// Loop to play the beats
while (true) {
    for (0 => int beatNum; beatNum < beatsPerBar; beatNum++) {
        playBeat(beatNum);
        beat => now;
    }
}