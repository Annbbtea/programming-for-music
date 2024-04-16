SinOsc s[6];
[0.3 , 0.2 , 0.1 , 0.1 , 0.1 , 0.1] @=> float gainArray[];
[72 , 74 , 76 , 77 , 79 , 81 , 83 , 84] @=> int notelist[];
for(0 => int i ; i < s.cap() ; i++)
{
    gainArray[i] => s[i].gain;
    s[i] => dac;
}

2 => int idx;

while(1)
{
    Std.mtof( notelist[idx] ) => float _base;
    _base * 2 => float _first;
    _base * 3 => float _second;
    _base * 4 => float _third;
    _base * 5 => float _fourth;
    _base * 6 => float _fifth;
    [_base, _first, _second, _third, _fourth, _fifth] @=> float freqArray[];
    
    for(0 => int i ; i < s.cap() ; i++)
    {
        freqArray[i] => s[i].freq;
    }

    Math.random2(1,10) => int dice;
    if(dice < 3)
    {
        0.5 :: second => now;
    }
    else if(dice < 5)
    {
        0.25 :: second => now;       
    }
    else if(dice < 9)
    {
        0.75 :: second => now;       
    }
    else
    {
        1 :: second => now;
    }
    Math.random2( -1 , 1 ) +=> idx;
    if(idx == -1 || idx == notelist.cap()) 4 => idx;
}