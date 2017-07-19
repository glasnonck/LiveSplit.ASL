state("swkotor2")
{
    int isNotLoading   : "dinput8.dll",  0x02C1D4;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07A00C;
}

state("swkotor2", "win10")
{
    int isNotLoading   : "dinput8.dll",  0x0311D8;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x080C04;
}

init
{
    if (Environment.OSVersion.Version.Major == 10
        || (Environment.OSVersion.Version.Major == 6 &&
            Environment.OSVersion.Version.Minor >  1))
    {
        if (Environment.OSVersion.Version.Build > 1700)
        {
            version = "win10";
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
