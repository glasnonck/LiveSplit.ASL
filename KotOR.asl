state("swkotor")
{
    int isNotLoading   : "dinput8.dll", 0x02C1D4;
    int isNotLoading1803:"dinput8.dll", 0x02C1D4;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
    int inGamePause    : "swkotor.exe", 0x432890;
    int runningTimer   : "swkotor.exe", 0x3B9288;
}

state("swkotor", "win10-18xx")
{
    int isNotLoading   : "dinput8.dll", 0x030218;
    int isNotLoading1803:"dinput8.dll", 0x032238;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
    int inGamePause    : "swkotor.exe", 0x432890;
    int runningTimer   : "swkotor.exe", 0x3B9288;
}

state("swkotor", "win10-10-17")
{
    int isNotLoading   : "dinput8.dll", 0x0311D8;
    int isNotLoading1803:"dinput8.dll", 0x0311D8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
    int inGamePause    : "swkotor.exe", 0x432890;
    int runningTimer   : "swkotor.exe", 0x3B9288;
}

state("swkotor", "win10-old")
{
    int isNotLoading   : "dinput8.dll", 0x02FEB8;
    int isNotLoading1803:"dinput8.dll", 0x02FEB8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
    int inGamePause    : "swkotor.exe", 0x432890;
    int runningTimer   : "swkotor.exe", 0x3B9288;
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
        if (Environment.OSVersion.Version.Build > 1800)
        {
            version = "win10-18xx";
        }
        else if (Environment.OSVersion.Version.Build > 1700)
        {
            version = "win10-10-17";
        }
        else
        {
            version = "win10-old";
        }
    }
    
    int moduleSize = modules.First().ModuleMemorySize;
    print("module size is " + moduleSize);

    // swkotor module sizes
    //   w10_v1809  steam   2019328 || 4993024

    vars.trust = 0;
    vars.vOldRunningTimer = 0;
    vars.vvOldRunningTimer = 0;
    vars.maxTimeSinceIGP = 10;
    vars.timeSinceIGP = 10;

    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

update
{
    if (vars.timeSinceIGP <= vars.maxTimeSinceIGP)
    {
        ++vars.timeSinceIGP;
    }
    
    // To begin trusting...
    if (current.isNotLoading == 0 && current.isActiveWindow == 1
        && current.inGamePause == 1
        && old.runningTimer == current.runningTimer)
    {
        if (vars.vvOldRunningTimer == current.runningTimer)
        {
            vars.trust = 1;
            vars.timeSinceIGP = 0;
        }
    }
    // To continue trusting...
    // To stop trusting...
    if (current.inGamePause == 0 && vars.timeSinceIGP > vars.maxTimeSinceIGP
        || current.inGamePause == 1 && current.isNotLoading == 1 && current.isActiveWindow == 1)
    {
        vars.trust = 0;
    }
    
    vars.vvOldRunningTimer = vars.vOldRunningTimer;
    vars.vOldRunningTimer = old.runningTimer;
    
    //print("old: " + old.runningTimer.ToString() + System.Environment.NewLine
    //    + "cur: " + current.runningTimer.ToString() + System.Environment.NewLine
    //    + "igp: " + current.inGamePause.ToString() + System.Environment.NewLine
    //    + "inl: " + current.isNotLoading.ToString() + System.Environment.NewLine
    //    + "tru: " + vars.trust.ToString());
}

isLoading
{
    if (vars.trust == 1)
    {
        if (settings["use1803Addr"])
        {
            return current.isNotLoading1803 == 0
                && current.isActiveWindow   == 1;
        }
        else
        {
            return current.isNotLoading   == 0
                && current.isActiveWindow == 1;
        }
    }
    else
        return false;
}
