60 => int BPM; // Beats per minute
1 => int eigthNote; // 0 == off , 1 == on
0 => int sixteenthNote; // 0 == off , 1 == on
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
  
if( sixteenthNote == 1 ) spork ~ sub_beat( beatDuration / 4 );
else if( eigthNote == 1 ) spork ~ sub_beat( beatDuration / 2 );
spork ~ beat( beatDuration );

while(true) 1::second => now;