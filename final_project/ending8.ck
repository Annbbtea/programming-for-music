fun void ending8_echo() //【選擇N：結局8．真實身分】
{
    //回音、深淵、安眠(回歸安詳、聲音趨於平靜)
    [50,52,53,55,57,58,60]@=> int lowerd[];
    TriOsc s => ADSR e => JCRev rev => dac;
    e.set(100::ms, 400::ms, 0.0, 10::ms);
    0.8 => rev.mix; 
    0.2 => rev.gain;
    for (0=>int i; i<3; i++) 
    {
        Math.random2(0, (lowerd.size()-1)) => int Noteindex;
        Std.mtof(lowerd[Noteindex]) => s.freq;
        1 => e.keyOn;
        Math.random2f(1,3)::second => now;
        1 => e.keyOff;
        e.releaseTime; 
        0.2-(i*0.05) => rev.gain;
        if (i == 2){
            0 => i;
        }
    }
}
fun void ending8_repeat() 
{
    //無窮無盡的循環
    [62,64,65,67,69,70,72,74,76,77,79,81,82,84] @=> int d[];
    SinOsc s => ADSR env => Delay delay => dac;
    delay => delay; 
    env.set(10::ms, 140::ms, 0.7, 50::ms);
    450::ms => delay.max => delay.delay;
    0.36 => delay.gain; 
    for (0=>int i; i<30; i++) 
    {
        Math.random2(0, (d.size()-1)) => int Noteindex;
        Std.mtof(d[Noteindex]) => s.freq;
        env.keyOn();
        170::ms => now;
        env.keyOff();
        0.15 => s.gain;
        env.releaseTime() => now;
        Math.random2f(0.1,0.5)::second => now; 
        if (i == 29){
            0 => i;
        }
    }
}

spork ~ending8_echo();
spork ~ending8_repeat();
10 :: minute => now;