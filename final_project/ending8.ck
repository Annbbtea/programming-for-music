fun void ending8_echo() //【選擇N：結局8．真實身分】
{
    //max gain 20% 
    //15 second
    //回音、深淵、安眠(回歸安詳、聲音趨於平靜)
    SinOsc s => ADSR e => JCRev rev => dac;
    e.set(10::ms, 400::ms, 0.3, 10::ms);
    0.5 => rev.mix; 
    0.2 => rev.gain;
    [49,51,53,54,56,58,60,61] @=> int note[];
    4 => int pitchidx;
    for (0=>int i; i<8; i++) 
    {
        Std.mtof(note[pitchidx+Math.random2(-2,2)]) =>s.freq;
        //Math.random2(-2,2)

        1::second => now;
        1 => e.keyOn;
        2::second => now;
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
    SinOsc s => ADSR env => Delay delay =>  Pan2 p =>dac;
    delay => delay; 
    env.set(10::ms, 140::ms, 0.7, 50::ms);
    450::ms => delay.max => delay.delay;
    0.3 => delay.gain; 
    for (0=>int i; i<35; i++) 
    {
        Math.random2(48, 66) => int theNote;
        Std.mtof(theNote) => s.freq;
        Math.random2f(-1, 1) => p.pan; 

        env.keyOn();
        170::ms => now;
        env.keyOff();
        0.5 => s.gain;
        env.releaseTime() => now;
        0.2::second => now; 

    }
}

spork ~ending8_echo();
spork ~ending8_repeat();
10 :: minute => now;