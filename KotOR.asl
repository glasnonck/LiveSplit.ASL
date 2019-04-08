state("swkotor")
{
    int isNotLoading   : "dinput8.dll", 0x02C1D4;
    int isNotLoading1803:"dinput8.dll", 0x02C1D4;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-18xx")
{
    int isNotLoading   : "dinput8.dll", 0x030218;
    int isNotLoading1803:"dinput8.dll", 0x032238;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-10-17")
{
    int isNotLoading   : "dinput8.dll", 0x0311D8;
    int isNotLoading1803:"dinput8.dll", 0x0311D8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-old")
{
    int isNotLoading   : "dinput8.dll", 0x02FEB8;
    int isNotLoading1803:"dinput8.dll", 0x02FEB8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
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
    
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
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
