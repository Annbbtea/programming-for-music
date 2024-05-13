fun void roomNoise()
{
    me.dir() + "bar_noise.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    while(true)
    {
        0 => myplayer.pos;
        0.4 => myplayer.gain;
        1 => myplayer.rate;
        5::minute => now;
    }
}
spork ~ roomNoise();
10 :: minute => now;