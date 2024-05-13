fun void ending7_noise() //【選擇M：結局7．失敗者們】
{
    //粗啞的嘲哳
    //max 10 second
    //gain 20%
    SinOsc w => dac;
    0  => int test;
    1.0 => float vol;
    0 => float tempi;
    
    for (0 => int i; i<10000; i++)
    {       
        Math.random2f(0.05, 0.25)*vol => float G;
        G*0.2 => w.gain;
        if (test == 1)
        {
            Math.random2f(20,4500)=> w.freq;
            1::ms => now;
        }
        else
        {
            Math.random2f(5000,7000)=> w.freq;
            0.1::ms => now;
        }

        if (i%1000 == 999)
        {
            w =< dac;
            (Math.random2f(1,7)/10) ::second => now;
            w => dac;
            Math.random2(1,3) => test;
          
            if (i>4000)
            {
                i => tempi;
                (1 - (tempi/10000)) => vol;
            }
        }
    }
}
fun void ending7_crow()
{
    //盤旋的鴉群、撲騰翅膀
    //15 second
    //gain 30%
    7::second => now;
    me.dir() + "crow.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    250000 => myplayer.pos;

    for (0 => int i; i<10; i++) 
    {
        1-(i/10) => myplayer.rate;
        i => float tempi;
        (0.05 + (tempi/10))*0.3 => myplayer.gain;
        0.8::second => now;
    }
}
fun void ending7_wave()
{
    //嘩啦嘩啦、潮水遠去
    //15 second
    //gain 40%
    1::second => now;
    me.dir() + "wave.wav" => string music;
    SndBuf myplayer => dac;
    music => myplayer.read;
    150000 => myplayer.pos;
    for (0 => int i; i<20; i++) 
    {
        i => float tempi;
        (0.05 + (tempi/20))*0.5 => myplayer.gain;
        0.7::second => now;
    }
    for (0 => int i; i<5; i++) 
    {
        i => float tempi;
        (0.95 - (tempi/5))*0.4 => myplayer.gain;
        0.3::second => now;
    }
}

spork ~ending7_noise();
spork ~ending7_crow();
spork ~ending7_wave();

10 :: minute => now;