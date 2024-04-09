//p1
220 => int _base;
440 => int _first;
660 => int _second;
880 => int _third;
1100 => int _fourth;
1320 => int _fifth;

[_base, _first, _second, _third, _fourth, _fifth] @=> int freqArray[];
[0.3, 0.2, 0.1, 0.1, 0.1, 0.1] @=> float gainArray[];

SinOsc a[6];
for(0 => int i ; i < a.cap() ; i++)
{
    freqArray[i] => a[i].freq;
    gainArray[i] => a[i].gain;
    a[i] => dac;
}
Math.random2(1,10) => int dice;
if(dice < 3)
{
    1 :: second => now;
}
else if(dice < 5)
{
    2 :: second => now;       
}
else if(dice < 9)
{
    3 :: second => now;       
}
else
{
    4 :: second => now;
}