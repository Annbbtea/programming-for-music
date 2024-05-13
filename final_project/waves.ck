0 => int C;
2 => int D;
4 => int E;
5 => int F;
7 => int G;
9 => int A;
11 => int B;
fun void w1( dur beat )
{
    SinOsc s => ADSR env1 => NRev rev1 => dac;
    ( beat / 16 , beat / 16 , .3 , 50::ms ) => env1.set;
    .1 => rev1.mix;
    //48 => int offset;
    0 => int dice;
    [B -12 , C , D , E - 1 , F , G , A - 1 , B - 1 , C + 12] @=> int scale[];
    while(1)
    {
        60 => int offset;
        0 => s.gain;
        beat * Math.random2f(0 , 3) => now;
        0.1 => s.gain;
        Math.random2( 1 , 7 ) => dice;
        for( 0 => int i ; i < 10 ; 2 +=> i)
        {
            if( i + dice >= scale.cap() - 2 )
            {
                7 -=> dice;
                12 +=> offset;
            }
            env1.keyOn();
            Std.mtof( scale[i + dice]  + offset )=> s.freq;
            beat / 4 => now;
            env1.keyOff();
            env1.keyOn();
            Std.mtof( scale[i + dice + 1]  + offset )=> s.freq;
            beat / 4 => now;
            env1.keyOff();
            env1.keyOn();
            Std.mtof( scale[i + dice]  + offset )=> s.freq;
            beat / 4 => now;
            env1.keyOff();
        }
    }
}

fun void w2( dur beat )
{
    SinOsc s => ADSR env1 => NRev rev1 => dac;
    ( beat / 8 , beat / 8 , 0 , 1::ms ) => env1.set;
    .1 => rev1.mix;
    60 => int offset;
    [14 , 12 , 7 , 5 , 3 , 7 , 14 , 12 , 7 , 3 , 0 , -1] @=> int scale[];
    while(1)
    {
        0 => s.gain;
        beat * Math.random2f(0 , 2) => now;
        0.05 => s.gain;
        ( beat / 8 , beat / 8 , .5 , 1::ms ) => env1.set;
        for( 0 => int i ; i < scale.cap() - 1 ; i++ )
        {
            env1.keyOn();
            Std.mtof( scale[i]  + offset )=> s.freq;
            beat / 1.3 => now;
            env1.keyOff();
        }
        ( beat / 8 , beat / 8 , .5 , 1::ms ) => env1.set;
        env1.keyOn();
        Std.mtof( scale[scale.cap() - 1]  + offset )=> s.freq;
        beat * 3 => now;
        env1.keyOff();
    }
}

fun void w3( dur beat )
{
    SinOsc s => ADSR env1 => NRev rev1 => dac;//NRev rev1 => dac;
    .1 => rev1.mix;
    SinOsc c => env1;
    60 => int offset;
    beat * 1.1 => beat;
    while(1)
    {
        for( 0 => int i ; i < 6 ; i++ )
        {
            0.15 => s.gain;
            0.15 => c.gain;
            env1.keyOn();
            ( beat / 8 , beat / 8 , 0 , 1::ms ) => env1.set;
            Std.mtof( offset + E - 1 )=> s.freq;
            Std.mtof( offset + E - 1 - 12 )=> c.freq;
            beat / 1.5 => now;
            env1.keyOff();
            env1.keyOn();
            ( beat / 8 , beat / 8 , .5 , 1::ms ) => env1.set;
            Std.mtof( offset + E - 1 )=> s.freq;
            Std.mtof( offset + E - 1 - 12 )=> c.freq;
            beat / 1.5 => now;
            env1.keyOff();
        }
    }
}

fun void w4( dur beat )
{
    SinOsc s[2];
    s[0] => ADSR env1 => NRev rev1 => dac;
    s[1] => env1;
    ( beat * 4 , beat * 6 , .5 , 1::ms ) => env1.set;
    .1 => rev1.mix;
    36 => int offset;
    0 => int dise;
    0.2 => s[0].gain;
    0.25 => s[1].gain;
    [C , D , E - 1 , F , G , A , B , C] @=> int scale[];
    while ( 1 )
    {
        Math.random2(0 , 7) => dise;
        Std.mtof( scale[dise]  + offset )=> s[0].freq;
        if( dise < 2 ) Std.mtof( scale[dise + 2]  + offset )=> s[1].freq;
        else Std.mtof( scale[dise - 2]  + offset )=> s[1].freq;
        env1.keyOn();
        beat * 10 => now;
        env1.keyOff();
    }   
}

fun void w5( dur beat )
{
    SinOsc s => ADSR env1 => NRev rev1 => dac;//NRev rev1 => dac;
    .3 => rev1.mix;
    48 => int offset;
    beat * 1.1 => beat;
    while(1)
    {
        for( 0 => int i ; i < 6 ; i++ )
        {
            0.25 => s.gain;
            env1.keyOn();
            ( 1::ms , beat / 3 , 0 , 1::ms ) => env1.set;
            Std.mtof( offset + 12 )=> s.freq;
            beat / 2.5 => now;
            env1.keyOff();
            env1.keyOn();
            ( 1::ms , beat / 3 , 0 , 1::ms ) => env1.set;
            Std.mtof( offset + G )=> s.freq;
            beat / 2.5 => now;
            env1.keyOff();
        }
    }
}

spork ~ w1( 0.6::second );
//spork ~ w2( 0.6::second );
spork ~ w3( 0.6::second );
spork ~ w4( 0.6::second );
spork ~ w5( 0.6::second );
1 :: minute => now;
