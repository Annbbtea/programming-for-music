fun void ending6_bgm() //【選擇L：結局6．為義犧牲】
{
    //逃跑(緊張感)、白花染紅
    me.dir() + "mystery.wav" => string music2;
    SndBuf my_player2 => dac;
    music2 => my_player2.read;
    0 => my_player2.pos;
    1=> my_player2.rate;
    for (0 => int i; i <24; i++)
    {
        (i*0.03+0.1) =>my_player2.gain;
        1::second => now;
        if (i == 19){
            0 => i;
            0 => my_player2.pos;
        }
    }
}

fun void ending6_knife() 
{
    //處刑
    me.dir() + "knife_slash.wav" => string music;
    SndBuf myplayer =>dac;
    music => myplayer.read;
    0.7 => myplayer.gain;
    6445 => myplayer.pos;
    0.645549 => myplayer.rate;
    2 ::second => now;
}
spork ~ending6_bgm(); 

Hid kb; 
HidMsg msg;
0 => int device;
if (kb.openKeyboard(device) == false)  me.exit();
1 => int end;
while(end){
   kb => now;  
    while(kb.recv(msg)){
        if (msg.isButtonDown()){             
            if (msg.key == 8){ //按下E就會發出揮刀聲，並結束所有程式
                spork ~ending6_knife();
                0.2::second=>now;
                0 => end;
            }
        }
    }
}