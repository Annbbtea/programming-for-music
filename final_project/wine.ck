0 => int C;
2 => int D;
4 => int E;
5 => int F;
7 => int G;
9 => int A;
11 => int B;

fun void chord( dur beat )
{
    TriOsc s1[4];
    ADSR env1 => NRev rev1 => dac;//NRev rev1 => dac;
    .3 => rev1.mix;
    for( 0 => int i ; i < 4 ; i++ )
    {
        s1[i] => env1;
        0.24 - i * 0.1 => s1[i].gain;
    }

    ( beat , beat * 4 , 0.1 , 1::ms ) => env1.set;
    48 => int offset;

    [ [ E , G , B , C + 12 ] , 
      [ D , G , A , B ] , 
      [ F + 1 , G , B , D + 12 ] , 
      [ E , G , A , C + 12 ] , 
      [ C , E , B , C + 12 ] , 
      [ B - 12 , D , E , A ] , 
      [ C , D , G , A ] , 
      [ B - 12 , C , E , D + 12 ] ] @=> int chord_a[][];
    
    while( true )
    {
        for( 0 => int k ; k < 8 ; k++ )
        {
            for( 0 => int i ; i < 4 ; i++ )
            {
                Std.mtof( offset + chord_a[k][i] ) => s1[i].freq;
            }
            env1.keyOn(); 
            beat * 5 => now;
            env1.keyOff();
        }   
    }
}

fun void roomNoise()
{
    me.dir() + "bar_noise.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    1000000 => myplayer.pos;
    for( 0.3 => float i ; i > 0 ; 0.03 -=> i )
    {
        i => myplayer.gain;
        1 => myplayer.rate;
        1::second => now;
    }
}

1 :: second => dur beat;
spork ~ chord( beat );
spork ~ roomNoise();
10 :: minute => now;