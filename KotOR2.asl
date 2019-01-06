state("swkotor2")
{
    int isNotLoading   : "dinput8.dll",  0x02C1D4;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07A00C;
}

state("swkotor2", "win10_1703")
{
    int isNotLoading   : "dinput8.dll",  0x0311D8;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x080C04;
}

state("swkotor2", "win10_1803")
{
    int isNotLoading   : "dinput8.dll",  0x032238;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07DC1C;
}

init
{
    if (Environment.OSVersion.Version.Major == 10
        || (Environment.OSVersion.Version.Major == 6 &&
            Environment.OSVersion.Version.Minor >  1))
    {
        if (Environment.OSVersion.Version.Build > 1800)
        {
            version = "win10_1803";
        }
        else if (Environment.OSVersion.Version.Build > 1700)
        {
            version = "win10_1703";
        }
    }

    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
{
    return current.isNotLoading == 0
        && current.isActiveWindow == 1
        && current.isMoviePlaying == 0;
}
