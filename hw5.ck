SinOsc s[6];
[0.3 , 0.2 , 0.1 , 0.1 , 0.1 , 0.1] @=> float gainArray[];
for(0 => int i ; i < s.cap() ; i++)
{
    gainArray[i] => s[i].gain;
    s[i] => dac;
}

while(1)
{
    Std.mtof( Math.random2( 0 , 127 ) ) => float _base;
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
        25 :: ms => now;
    }
    else if(dice < 5)
    {
        60 :: ms => now;       
    }
    else if(dice < 9)
    {
        80 :: ms => now;       
    }
    else
    {
        100 :: ms => now;
    }
}
