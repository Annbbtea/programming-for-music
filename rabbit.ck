0 => int C;
2 => int D;
4 => int E;
5 => int F;
7 => int G;
9 => int A;
11 => int B;

fun void melody( dur beat )
{
    SinOsc s => ADSR env1 => Delay delay1 => NRev rev1 => dac;
    delay1 => delay1;
    beat * 2 => delay1.max;
    beat / 4 => delay1.delay;
    0.4 => delay1.gain;
    0.2 => rev1.mix;
    ( 1::ms , beat/4 , 0, 1::ms ) => env1.set;
    60 => int offset;
    0.3 => s.gain;

    [ [ G , B , C + 12 , F + 12 ] , 
      [ F , B , C + 12 , E + 12 ] , 
      [ E , B , C + 12 , E + 12 ] , 
      [ D , B , C + 12 , D + 12 ] ] @=> int rabbit_a[][];

    [ [ A , B , C + 12 , G + 12 ] , 
      [ G , A , C + 12 , F + 12 ] , 
      [ A , B , C + 12 , E + 12 ] , 
      [ G , C + 12 , D + 12 , G + 12 ] ] @=> int rabbit_b[][];
    
    while( true )
    {
        for( 0 => int k ; k < 2 ; k++ )
        {
            for( 0 => int i; i < 4; i++ )
            {
                for( 0 => int j; j < 4; j++ )
                {
                    Std.mtof( offset + rabbit_a[i][j] ) => s.freq;
                    env1.keyOn();
                    beat / 4 => now;
                    env1.keyOff();
                }
                beat * 5 => now;
            }
        }
        for( 0 => int k ; k < 2 ; k++ )
        {
            for( 0 => int i; i < 4; i++ )
            {
                for( 0 => int j; j < 4; j++ )
                {
                    Std.mtof( offset + rabbit_b[i][j] ) => s.freq;
                    env1.keyOn();
                    beat / 4 => now;
                    env1.keyOff();
                }
                beat * 5 => now;
            }
        }
    }
}

fun void chord( dur beat )
{
    SinOsc s1[3];
    SinOsc s2[4];
    ADSR env1 => dac;//NRev rev1 => dac;
    //1 => rev1.mix;
    for( 0 => int i ; i < 3 ; i++ )
    {
        s1[i] => env1;
    }

    for( 0 => int i ; i < 4 ; i++ )
    {
        s2[i] => env1;
    }
    ( 1 :: ms , beat * 6 , 0 , 1::ms ) => env1.set;
    48 => int offset;

    [ [ F , B , C + 12 ] , 
      [ F , A , D + 12 ] , 
      [ F , A , C + 12 ] , 
      [ E , A , B ] ] @=> int chord_a[][];

    [ [ E , G , A , C + 12 ] , 
      [ G , A , C + 12 , F + 12 ] , 
      [ A , B , C + 12 , E + 12 ] , 
      [ G , C + 12 , D + 12 , G + 12 ] ] @=> int chord_b[][];
    
    while( true )
    {
        for( 0 => int i ; i < 3 ; i++ )
        {
            0.2 => s1[i].gain;
        }

        for( 0 => int i ; i < 4 ; i++ )
        {
            0 => s2[i].gain;
        }
        for( 0 => int k ; k < 2 ; k++ )
        {
            for( 0 => int i ; i < 4 ; i++ )
            {
                for( 0 => int j ; j < 3 ; j++ )
                {
                    Std.mtof( offset + chord_a[i][j] ) => s1[j].freq;
                }
                env1.keyOn(); 
                beat * 6 => now;
                env1.keyOff();
            }
        }
        for( 0 => int i ; i < 3 ; i++ )
        {
            0 => s1[i].gain;
        }

        for( 0 => int i ; i < 4 ; i++ )
        {
            0.15 => s2[i].gain;
        }
        for( 0 => int k ; k < 2 ; k++ )
        {
            for( 0 => int i ; i < 4; i++ )
            {
                for( 0 => int j ; j < 4; j++ )
                {
                    Std.mtof( offset + chord_b[i][j] ) => s2[j].freq;
                }
                env1.keyOn();
                beat * 6 => now;
                env1.keyOff();
            }
        }
    }

}

fun void shine( dur beat )
{
    SinOsc s => ADSR env1 => NRev rev1 => dac;
    .1 => rev1.mix;
    SinOsc c => env1;
    ( beat * 4 , beat * 6 , 0, 1 :: ms ) => env1.set;
    72 => int offset;
    Std.mtof( offset + E ) => s.freq;
    Std.mtof( offset + C ) => c.freq;
    int dice;
    while( true )
    {
        0 => s.gain;
        0 => c.gain;
        Math.random2f( 6 , 9 ) :: second => now;
        Math.random2( 0 , 2 ) => dice;
        if( dice == 0 ) 
        {
            Std.mtof( offset + E ) => s.freq;
            Std.mtof( offset + C ) => c.freq;
        }
        else if( dice == 1 )
        {
            Std.mtof( offset + B ) => s.freq;
            Std.mtof( offset + G ) => c.freq;
        }
        else if( dice == 2 )
        {
            Std.mtof( offset + G ) => s.freq;
            Std.mtof( offset + E ) => c.freq;
        }
        env1.keyOn();
        0.15 => s.gain;
        0.1 => c.gain;
        beat * 10 => now;
        env1.keyOff();
    }
}

0.5 ::second => dur beat;
spork ~ melody( beat );
spork ~ chord( beat );
spork ~ shine( beat );

10 :: minute => now;