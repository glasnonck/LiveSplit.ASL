state("swkotor")
{
    int isNotLoading   : "dinput8.dll", 0x02C1D4;
    int isActiveWindow : "swkotor.exe", 0x3A3A38;
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
        && current.isActiveWindow == 1;
}