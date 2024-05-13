0 => int m;
0 => int position;
fun int mouse()
{
    // HID input and a HID message
    Hid hi;
    HidMsg msg;

    // which mouse
    0 => int device;
    0 => float x;
    0 => float y;
    float xx , yy;
    // get from command line
    if( me.args() ) me.arg(0) => Std.atoi => device;

    // open mouse 0, exit on fail
    if( !hi.openMouse( device ) ) return 0;
    <<< "mouse '" + hi.name() + "' ready", "" >>>;

    // infinite event loop
    while( true )
    {
        // wait on HidIn as event
        hi => now;

        // messages received
        while( hi.recv( msg ) )
        {
            // mouse motion
            if( msg.isMouseMotion() )
            {
                msg.scaledCursorX => x;
                msg.scaledCursorY => y;
                //msg.scaledCursorX => xx;
                //msg.scaledCursorY => yy;
                //if( xx > 0.1 ) xx => x;
                //if( yy > 0.1 ) yy => y;
                // get the normalized X-Y screen cursor pofaition
                //<<< "mouse normalized position --", "x:", msg.scaledCursorX, "y:", msg.scaledCursorY >>>;
            }
            // mouse button down
            else if( msg.isButtonDown() )
            {
                0 => m;
                <<< "mouse button", msg.which, "down", "x:", x, "y:", y >>>;
            }
            
            // mouse button up
            else if( msg.isButtonUp() )
            {
                <<< "mouse button", msg.which, "up", "x:", x, "y:", y >>>;
                if( y < 0.5 && position == 1 ) 
                {
                    1 => m;
                }
                if( y > 0.5 && position == 1 )
                {
                    2 => m;
                }
            }
        }
    }
    return 0;
}

fun int key()
{
    Hid hi;
    HidMsg msg;

    // which keyboard
    0 => int device;
    0 => int i;
    // get from command line
    if( me.args() ) me.arg(0) => Std.atoi => device;

    // open keyboard (get device number from command line)
    if( !hi.openKeyboard( device ) ) return 0;
    <<< "keyboard '" + hi.name() + "' ready", "" >>>;

    // infinite event loop
    while( 1 )
    {
        // wait on event
        hi => now;

        // get one or more messages
        while( hi.recv( msg ) )
        {
            // check for action type
            0 => m;
            if( msg.isButtonDown() && msg.ascii == 'A')
            {
                //0 => m;
                <<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                1 => position;
                //0 => m;
                return m;
            }
            else if( msg.isButtonUp() )
            {
                0 => position;
            }
            i++;
        }
        i++;
    }
    return 0;
}

fun int detect()
{
    int t;
    while(1)
    {
        1::ms => now;
        <<<t,m>>>;
        if( m == 1 )
        {
            <<<"up">>>;
            <<<t,m>>>;
            return 1;
        }
        else if( m == 2)
        {
            <<<"down">>>;
            <<<t,m>>>;
            return 2;
        }
    }
    return 0;
}

spork ~ mouse();
me.dir() + "rabbit.ck" => string rabbit;
me.dir() + "ufo.ck" => string ufo;
me.dir() + "waves.ck" => string waves;
me.dir() + "bar.ck" => string bar;
me.dir() + "wine.ck" => string wine;
me.dir() + "garden.ck" => string garden;
me.dir() + "ending5.ck" => string ending5;
me.dir() + "ending6.ck" => string ending6;
me.dir() + "ending7.ck" => string ending7;
me.dir() + "ending8.ck" => string ending8;

int id;
int t;
0 => int event;
1 => int is_running;
0 => int state;
while( is_running )
{
    -1 => event;
    if( state == 0 )
    {
        <<<"enter introduction">>>;
        Machine.add( rabbit ) => id;
        key() => t;
        detect() => event;
        if( event == 1 ) 'A' => state;
        else if( event == 2 ) 'B' => state;
        <<<"leave introduction">>>;
    }
    else if( state == 'A' )
    {
        <<<"enter A">>>;
        key() => t;
        detect() => event;
        if( event == 1 ) 'C' => state;
        else if( event == 2 ) 'D' => state;
        <<<"leave A">>>;
    }
    else if( state == 'B' )
    {
        <<<"enter B">>>;
        key() => t;
        detect() => event;
        if( event == 1 ) 'E' => state;
        else if( event == 2 ) 'F' => state;
        <<<"leave B">>>;
    }
    else if( state == 'C' )
    {
        <<<"enter C">>>;
        Machine.replace( id , garden );
        key() => t;
        detect() => event;
        if( event == 1 ) 'G' => state;
        else if( event == 2 ) 'H' => state;
        <<<"leave C">>>;
    }
    else if( state == 'D' )
    {
        <<<"enter D">>>;
        Machine.replace( id , waves );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave D">>>;
    }
    else if( state == 'E' )
    {
        <<<"enter E">>>;
        Machine.replace( id , ufo );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave E">>>;
    }
    else if( state == 'F' )
    {
        <<<"enter F">>>;
        Machine.replace( id , bar );
        key() => t;
        detect() => event;
        if( event == 1 ) 'I' => state;
        else if( event == 2 ) 'J' => state;
        <<<"leave F">>>;
    }
    else if( state == 'G')
    {
        <<<"enter G">>>;
        key() => t;
        detect() => event;
        if( event == 1 ) 'K' => state;
        else if( event == 2 ) 'L' => state;
        <<<"leave G">>>;
    }
    else if( state == 'H' )
    {
        <<<"enter H">>>;
        key() => t;
        detect() => event;
        if( event == 1 ) 'M' => state;
        else if( event == 2 ) 'N' => state;
        <<<"leave H">>>;
    }
    else if( state == 'I' )
    {
        <<<"enter I">>>;
        Machine.replace( id ,wine );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave I">>>;
    }
    else if( state == 'J' )
    {
        <<<"enter J">>>;
        Machine.replace( id ,wine );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave J">>>;
    }
    else if( state == 'K' )
    {
        <<<"enter K">>>;
        Machine.replace( id , ending5 );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave K">>>;
    }
    else if( state == 'L' )
    {
        <<<"enter L">>>;
        Machine.replace( id , ending6 );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave L">>>;
    }
    else if( state == 'M' )
    {
        <<<"enter M">>>;
        Machine.replace( id , ending7 );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave M">>>;
    }
    else if( state == 'N' )
    {
        <<<"enter N">>>;
        Machine.replace( id , ending8 );
        key() => t;
        detect() => event;
        if( event != -1 ) 0 => is_running;
        <<<"leave N">>>;
    }
}
<<<"end">>>;
Machine.remove( id );
