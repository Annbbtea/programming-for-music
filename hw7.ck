SinOsc s[6];
TriOsc c[3];
[0.3 , 0.2 , 0.1 , 0.1 , 0.1 , 0.1] @=> float gainArray[];
[72 , 74 , 76 , 77 , 79 , 81 , 83 , 84] @=> int notelist[];
[48 , 52 , 55] @=> int CMaj[];
[53 , 57 , 60] @=> int FMaj[];
[55 , 59 , 62] @=> int GMaj[];
2 => int idx;
0.2 => float sGain;
0.8 => float cGain;

for( 0 => int i ; i < s.cap() ; i++ )
{
    gainArray[i] * sGain => s[i].gain;
    s[i] => dac;
}
for( 0 => int i ; i < c.cap() ; i++ )
{
    0.3 * cGain => c[i].gain;
    c[i] => dac;
}

while(1)
{
    Std.mtof( notelist[idx] ) => float _base;
    _base * 2 => float _first;
    _base * 3 => float _second;
    _base * 4 => float _third;
    _base * 5 => float _fourth;
    _base * 6 => float _fifth;
    [_base, _first, _second, _third, _fourth, _fifth] @=> float freqArray[];
    
    for( 0 => int i ; i < s.cap() ; i++ )
    {
        freqArray[i] => s[i].freq;
    }
    
    for( 0 => int i ; i < c.cap() ; i++ )
    {
        
        if( idx == 0 || idx == 2 )
        {
            Std.mtof( CMaj[i] ) => c[i].freq;
        }
        else if( idx == 3|| idx == 5 )
        {
            Std.mtof( FMaj[i] ) => c[i].freq;
        }
        else
        {
            Std.mtof( GMaj[i] ) => c[i].freq;
        }
        
    }

    Math.random2( 1 , 10 ) => int dice;
    if( dice < 3 )
    {
        0.5 :: second => now;
    }
    else if( dice < 5 )
    {
        0.25 :: second => now;       
    }
    else if( dice < 9 )
    {
        0.75 :: second => now;       
    }
    else
    {
        1 :: second => now;
    }
    
    Math.random2( -1 , 1 ) +=> idx;
    if( idx == -1 || idx == notelist.cap() ) 4 => idx;
}