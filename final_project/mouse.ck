//-----------------------------------------------------------------------------
// name: mouse-abs.ck
// desc: basic mouse input (absolute normalized screen X Y coordinates)
//       also see mouse.ck for relative X Y deltas
//
// note: select between mice/trackpads by specifying device number;
//       to see a list of devices and their numbers, either...
//       1) view the Device Browser window in miniAudicle (select
//          "Human Interface Devices" in the drop-down menu)
//       OR 2) from the command line:
//          > chuck --probe
//
// author: Ge Wang (https://ccrma.stanford.edu/~ge/)
//-----------------------------------------------------------------------------
0 => int event;
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
                0 => event;
                <<< "mouse button", msg.which, "down", "x:", x, "y:", y >>>;
            }
            
            // mouse button up
            else if( msg.isButtonUp() )
            {
                <<< "mouse button", msg.which, "up", "x:", x, "y:", y >>>;
                if( yy < 0.5 && position == 1 ) return 1 => event;
                if( yy > 0.5 && position == 1 ) return 2 => event;
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
            if( msg.isButtonDown() && msg.ascii == 'A')
            {
                <<< "down:", msg.which, "(code)", msg.key, "(usb key)", msg.ascii, "(ascii)" >>>;
                //1 => position;
                return 1;
            }
            //else if( msg.isButtonUp() ) 0 => position;
            i++;
        }
        i++;
    }
    return 0;
}
spork ~ mouse();
int t;
while(1)
{
    key() => t;
    if( t == 1 && event == 1 )
    {
        <<<"up">>>;
        0 => event;
        return 1;
    }
    else if( t == 1 && event == 2 )
    {
        <<<"down">>>;
        0 => event;
        return 2;
    }
}
