60 => int BPM; // Beats per minute
2 => int subDivision; //off: 0
//----------------------------------------------
ModalBar one => dac.left;
ModalBar two => dac.right;

3 => one.preset;
5 => two.preset;
0.9 => one.strikePosition;
0.4 => two.strikePosition;
Std.mtof(60) => one.freq;
Std.mtof(50) => two.freq;

( 1000 * 60 / BPM ) :: ms => dur beatDuration; 

fun void sub_beat( dur beatDuration ){
    while(true){
        1 => one.strike;
        beatDuration => now;
    }
}   

fun void beat( dur beatDuration ){
    while(true){
        1 => two.strike;
        beatDuration => now;
    }
}

if( subDivision != 0 ) spork ~ sub_beat( beatDuration / subDivision );
spork ~ beat( beatDuration );

while(true) 1::second => now;
