state("swkotor2")
{
    int isNotLoading   : "dinput8.dll",  0x02C1D4;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07A00C;
    int modifierKeys   : "MSCTF.dll",    0x0C1FD8;
    
    int isNotLoading1803:"dinput8.dll",  0x032238;
    int isMoviePlaying1803:"ddraw.dll",  0x07DC1C;
}

state("swkotor2", "win10_1703")
{
    int isNotLoading   : "dinput8.dll",  0x0311D8;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x080C04;
    int modifierKeys   : "MSCTF.dll",    0x0C1FD8;
    
    int isNotLoading1803:"dinput8.dll",  0x032238;
    int isMoviePlaying1803:"ddraw.dll",  0x07DC1C;
}

state("swkotor2", "win10_1803")
{
    int isNotLoading   : "dinput8.dll",  0x032238;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07DC1C;
    int modifierKeys   : "MSCTF.dll",    0x0C1FD8;

    int isNotLoading1803:"dinput8.dll",  0x032238;
    int isMoviePlaying1803:"ddraw.dll",  0x07DC1C;
}

state("swkotor2", "win10_1809")
{
    int isNotLoading   : "dinput8.dll",  0x030218;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07CACC;
    int modifierKeys   : "MSCTF.dll",    0x0C1FD8;

    int isNotLoading1803:"dinput8.dll",  0x032238;
    int isMoviePlaying1803:"ddraw.dll",  0x07DC1C;
}

startup
{
    if (Environment.OSVersion.Version.Major == 6 &&
        Environment.OSVersion.Version.Minor >  1 &&
        Environment.OSVersion.Version.Build > 1800)
    {
        settings.Add("use1803Addr", false, "Use Windows 10 version 1803 addresses");
    }
}

init
{
    if (Environment.OSVersion.Version.Major == 10
        || (Environment.OSVersion.Version.Major == 6 &&
            Environment.OSVersion.Version.Minor >  1))
    {
        if (Environment.OSVersion.Version.Build > 1805)
        {
            version = "win10_1809";
        }
        else if (Environment.OSVersion.Version.Build > 1800)
        {
            version = "win10_1803";
        }
        else if (Environment.OSVersion.Version.Build > 1700)
        {
            version = "win10_1703";
        }
    }

    // Variable used to determine trust of isNotLoading.
    vars.trust = 0;

    // Game is not paused at start, and keep timer running if game exits.
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

update
{
    // Begin trusting when no modifier keys are pressed.
    if (current.modifierKeys == 0)  // no modifier keys pressed
    {
        vars.trust = 1;
    }
    
    // Stop trusting when any combination of ALT and SHIFT are pressed,
    // or if the WIN key is pressed.
    if (current.modifierKeys == 9   ||  // r ALT
        current.modifierKeys == 45  ||  // r SHIFT, r ALT
        current.modifierKeys == 269 ||  // l SHIFT, r ALT
        current.modifierKeys == 301 ||  // lr SHIFT, r ALT
        current.modifierKeys == 65  ||  // l ALT
        current.modifierKeys == 101 ||  // r SHIFT, l ALT
        current.modifierKeys == 325 ||  // l SHIFT, l ALT
        current.modifierKeys == 357 ||  // lr SHIFT, l ALT
        current.modifierKeys > 16000)   // WIN key pressed, too many combinations
    {
        vars.trust = 0;
    }

    // print("inl: " + current.isNotLoading.ToString() + System.Environment.NewLine
    //     + "mov: " + current.isMoviePlaying.ToString() + System.Environment.NewLine
    //     + "key: " + current.modifierKeys.ToString() + System.Environment.NewLine
    //     + "tru: " + vars.trust.ToString());
}

isLoading
{
    // Only check addresses if they are trusted.
    if (vars.trust == 1)
    {
        if (settings["use1803Addr"])
        {
          return current.isNotLoading1803   == 0
              && current.isActiveWindow     == 1
              && current.isMoviePlaying1803 == 0;
        }
        else
        {
          return current.isNotLoading   == 0
              && current.isActiveWindow == 1
              && current.isMoviePlaying == 0;
        }
    }
    else
    {
        return false;   // Do not pause timer if addresses aren't trusted.
    }
}
