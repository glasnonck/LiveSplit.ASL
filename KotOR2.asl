state("swkotor2")
{
    int isNotLoading   : "dinput8.dll",  0x02C1D4;
    int isActiveWindow : "swkotor2.exe", 0x6194D8;
    int isMoviePlaying : "swkotor2.exe", 0x61975C;
}

start
{
}

reset
{
}

split
{
}

isLoading
{
    return current.isNotLoading == 0
        && current.isActiveWindow == 1
        && current.isMoviePlaying == 0;
}