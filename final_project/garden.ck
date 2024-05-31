fun void garden_backsound()
{
    //gain 70%
    //明媚的花園、噴泉、小鳥
    me.dir() + "gardenandbirds.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    for (0 => int i; i <15; i++)
    {
        Math.random2(0,2360845/2)=> myplayer.pos;
        0.7 => myplayer.gain;
        2 => myplayer.rate;
        Math.random2f(0.1,1) => myplayer.freq;
        1::second => now;
        if (i == 14){
            0 => i;
        }
    }     
}
fun void garden_talk()
{
    //兩方鬧哄哄  
    me.dir() + "talk.wav" => string music2;
    SndBuf myplayer2 => dac;
    music2 => myplayer2.read;
    myplayer2 =< dac;
    5::second => now;
    myplayer2 => dac;
    for (0 => int i; i <5; i++)
    {
        Math.random2(0,169800000)=> myplayer2.pos;
        Math.random2f(0.2,0.3)=> myplayer2.gain;
        1 => myplayer2.rate;
        0.3::second => now;
        if (i == 4){
            0 => i;
        }
    }   
}
spork ~garden_backsound();
spork ~garden_talk();
10 :: minute => now;