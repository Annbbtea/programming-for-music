fun void ending5_congrats() //【選擇K：結局5．新王之誕】
{
    // 擁護上位(恭喜恭賀聲)
    // max gain 40%
    // 10 second
    me.dir() + "fest.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    for (0 => int i; i <15; i++)
    {
        0 + i*100000 => myplayer.pos;
        Math.random2f(0.2,0.4) => myplayer.gain;
        Math.random2f(1.5,2.5) => myplayer.rate;
        1::second => now;
    }
}
fun void ending5_talk() 
{
    //又驚又喜(議論紛紛)
    //15 second
    //max gain 40%
    me.dir() + "talk.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    0 => myplayer.pos; //Math.random2(0,169848576/2)
    for (0 => int i; i <150; i++)
    {
        Math.random2f(0.2,0.4) => myplayer.gain;
        Math.random2f(0.5,2) => myplayer.rate;
        0.1::second => now;
    }
}
fun void ending5_knife() 
{
    //盔甲武士們舉起鋒利武器吆喝(金屬撞擊+吆喝)
    //max 15 second
    //gain 20%
    me.dir() + "knife_slides.wav" => string music1;
    me.dir() + "knife_hit.wav" => string music2;
    me.dir() + "knife_slash.wav" => string music3;

    SndBuf myplayer1 => dac;
    SndBuf myplayer2 => dac;
    SndBuf myplayer3;

    music1 => myplayer1.read;
    music2 => myplayer2.read;
    music3 => myplayer3.read;

    0.3*0.2 => myplayer1.gain;
    0.3*0.2 => myplayer2.gain;
    0.3*0.2 => myplayer3.gain;

    for ( 0 => int i; i<15; i++)
    {
        if (i%5 != 0)
        {
            myplayer3 => dac;
            0 => myplayer3.pos;
            1 => myplayer3.rate;
        }
        else
        {
            myplayer3 =< dac;
        }
        Math.random2(0,24640) => myplayer1.pos;
        Math.random2f(0,2) => myplayer1.rate;
        myplayer2 =< dac;
        Math.random2f(0,1)::second => now;
        myplayer2 => dac;

        0=> myplayer2.pos;
        1 => myplayer2.rate;
        myplayer1 =< dac;
        Math.random2f(0,1) ::second => now;
        myplayer1 => dac;
    }
}

spork ~ending5_knife();
spork ~ending5_talk();
spork ~ending5_congrats();//TBD
10 :: minute => now;