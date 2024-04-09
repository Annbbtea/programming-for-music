//p1
[110 , 220 , 440 , 660 , 880] @=> int freqArray[];

//p2
[0.2 , 0.3 , 0.5 , 0.6 , 0.7] @=> float gainArray[];

//p3
SinOsc sin_a => dac;

//p4 ~ p10
for(0 => int i ; i < freqArray.size() ; i++)
{
    freqArray[i] => sin_a.freq;
    gainArray[i] => sin_a.gain;
    1 :: second => now;
}