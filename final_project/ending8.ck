fun void ending8_echo() //【選擇N：結局8．真實身分】
{
    //max gain 20% 
    //15 second
    //回音、深淵、安眠(回歸安詳、聲音趨於平靜)
    TriOsc s => ADSR e => JCRev rev => dac;
    e.set(100::ms, 400::ms, 0.0, 10::ms);
    0.5 => rev.mix; 
    0.2 => rev.gain;
    for (0=>int i; i<3; i++) 
    {
        1 => e.keyOn;
        5::second => now;
        1 => e.keyOff;
        e.releaseTime; 
        0.2-(i*0.05) => rev.gain;
    }
}
fun void ending8_repeat() 
{
    //about 15 second
    //gain ?
    //無窮無盡的循環
    SinOsc s => ADSR env => Delay delay => dac;
    delay => delay; 
    env.set(10::ms, 140::ms, 0.7, 50::ms);
    450::ms => delay.max => delay.delay;
    0.36 => delay.gain; 
    for (0=>int i; i<30; i++) 
    {
        Math.random2(48, 66) => int theNote;
        Std.mtof(theNote) => s.freq;
        env.keyOn();
        170::ms => now;
        env.keyOff();
        0.15 => s.gain;
        env.releaseTime() => now;
        0.2::second => now; 
    }
}

spork ~ending8_echo();
spork ~ending8_repeat();
10 :: minute => now;