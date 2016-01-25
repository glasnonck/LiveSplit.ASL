state("swkotor")
{
    int isNotLoading   : "dinput8.dll", 0x02C1D4;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

state("swkotor", "win10")
{
    int isNotLoading   : "dinput8.dll", 0x02FE98;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
}

init
{
    if (Environment.OSVersion.Version.Major == 10
        || (Environment.OSVersion.Version.Major == 6 &&
            Environment.OSVersion.Version.Minor >  1))
        version = "win10";
    
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
{
    return current.isNotLoading == 0
        && current.isActiveWindow == 1;
}
