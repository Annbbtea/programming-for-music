fun void ending6() //【選擇L：結局6．為義犧牲】
{
    //逃跑(緊張感)、白花染紅
    me.dir() + "mystery.wav" => string music2;
    SndBuf my_player2 => dac;
    music2 => my_player2.read;
    0 => my_player2.pos;
    1=> my_player2.rate;
    for (0 => int i; i <20; i++)
    {
        1-(1-(i*0.03)) =>my_player2.gain;
        1::second => now;
    }
    my_player2 =< dac;
    //處刑
    me.dir() + "knife_slash.wav" => string music;
    SndBuf myplayer =>dac;
    music => myplayer.read;
    0.7 => myplayer.gain;
    //Math.random2(5000,20000)
    6445 => myplayer.pos;
    //Math.random2f(0.5,1) 
    0.645549 => myplayer.rate;
    2 ::second => now;
}

spork ~ending6();
10 :: minute => now;