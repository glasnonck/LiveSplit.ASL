state("swkotor")
{
    int isNotLoading   : "dinput8.dll", 0x02C1D4;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-04-18")
{
    int isNotLoading   : "dinput8.dll", 0x032238;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-10-17")
{
    int isNotLoading   : "dinput8.dll", 0x0311D8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10-old")
{
    int isNotLoading   : "dinput8.dll", 0x02FEB8;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

init
{
    if (Environment.OSVersion.Version.Major == 10
        || (Environment.OSVersion.Version.Major == 6 &&
            Environment.OSVersion.Version.Minor >  1))
    {
        if (Environment.OSVersion.Version.Build > 1800)
        {
            version = "win10-04-18";
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
    
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
{
    return current.isNotLoading == 0
        && current.isActiveWindow == 1;
}
