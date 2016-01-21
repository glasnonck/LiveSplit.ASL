state("swkotor2")
{
    int isNotLoading   : "dinput8.dll",  0x02C1D4;
    int isActiveWindow : "swkotor2.exe", 0x61B4E0;
    int isMoviePlaying : "ddraw.dll",    0x07A00C;
}

isLoading
{
    if (game == null || game.HasExited)
        return false;
    return current.isNotLoading == 0
        && current.isActiveWindow != 0
        && current.isMoviePlaying == 0;
}
