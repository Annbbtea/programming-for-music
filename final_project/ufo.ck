0 => int C;
2 => int D;
4 => int E;
5 => int F;
7 => int G;
9 => int A;
11 => int B;
0 => int position;

fun void ufo_1( dur beat ) // 隨機和弦 0.375
{
    SinOsc s => ADSR env1 => dac;
    SinOsc s2 => env1;
    SinOsc s3 => env1;
    ( beat , beat * 5 , 0 , 1::ms ) => env1.set;
    while(1)
    {
        0.125 + position / 100 => s.gain;
        0.125 + position / 100 => s2.gain;
        0.125 + position / 100 => s3.gain;
        Std.mtof( position + Math.random2( 48 , 60 ) ) => s.freq;
        Std.mtof( position + Math.random2( 48 , 60 ) ) => s2.freq;
        Std.mtof( position + Math.random2( 48 , 60 ) ) => s3.freq;
        env1.keyOn();
        beat * Math.random2f( 3 , 6 ) => now;
        env1.keyOff();
        Math.random2f( 0 , 6 ) * beat => now;
    }
}

fun void ufo_2( dur beat ) // 隨機兩音 0.025
{
    SinOsc s => ADSR env1 => dac;
    ( 1::ms , beat * 3 , .1 , 1::ms ) => env1.set;
    0.025 => s.gain;
    while(1)
    {
        Std.mtof( position + Math.random2( 65 , 83 ) ) => s.freq;
        env1.keyOn();
        beat * Math.random2f( 1 , 3 ) => now;
        env1.keyOff();
        Std.mtof( position + Math.random2( 65 , 83 ) ) => s.freq;
        env1.keyOn();
        beat * Math.random2f( 1 , 3 ) => now;
        env1.keyOff();
        Math.random2f( 0 , 7 ) * beat => now;
    }
}

fun void ufo_3( dur beat ) // 滴滴聲 0.04
{
    TriOsc s => ADSR env1 => dac;
    TriOsc c => env1;
    ( 1::ms , beat / 8 , .2 , 1::ms ) => env1.set;
    0.03 => s.gain;
    0.015 => c.gain;
    Std.mtof( 84 + B ) => s.freq;
    Std.mtof( 96 + F ) => c.freq;
    while(1)
    {
        for( 0 => int i ; i < 2 ; i++ )
        {
            env1.keyOn();
            beat / 8 => now;
            env1.keyOff();
        }
        beat * 4 => now;
    }
}

fun void ufo_4( dur beat ) //長低音 0.4
{
    TriOsc s => ADSR env1 => dac;
    ( beat * 3 , beat * 6 , .3 , 1::ms ) => env1.set;
    while(1)
    {
        0.3 + position / 100 => s.gain;
        Std.mtof( Math.random2( 36 , 48 ) ) => s.freq;
        env1.keyOn();
        beat * Math.random2f( 7 , 9 ) => now;
        env1.keyOff();
    }

}

fun void ufo_5( dur beat ) // 短7音和弦 0.015 ~ 0.035 * 7 ~= 0.2
{
    SinOsc s[7];
    ADSR env1 => dac;
    
    for( 0 => int i ; i < 7 ; i++ )
    {
        s[i] => env1;
    }
    while(1)
    {
        ( 1::ms , beat / ( 4 + position / 3 ) , 0 , 1::ms ) => env1.set;
        for( 0 => int i ; i < 7 ; i++ )
        {
            for( 0 => int i ; i < 7 ; i++ )
            {
                Math.random2f( 0.02 , 0.035 ) + ( position / 30 ) => s[i].gain;
            }
            Std.mtof( position + Math.random2( 60 , 72 ) ) => s[i].freq;
            env1.keyOn();
            beat / Math.random2f( 4 + position / 3 , 7 + position / 3 ) => now;
            env1.keyOff();
        }
    }
}

fun void p( dur beat )
{
    while( 1 )
    {
        beat * 5 => now;
        position ++;
        //<<< position >>>;
        if( position == 20 ) 0 => position;  
    }
}

1 :: second => dur beat;
spork ~ ufo_1( beat );
spork ~ ufo_2( beat );
spork ~ ufo_3( beat );
spork ~ ufo_4( beat );
spork ~ ufo_5( beat );
spork ~ p( beat );
10 :: minute => now;