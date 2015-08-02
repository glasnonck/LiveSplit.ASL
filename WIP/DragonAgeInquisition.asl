state("DragonAgeInquisition")
{
    int isLoading : "DragonAgeInquisition.exe",  0x02660990, 0x378, 0x140, 0x0;
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
    return current.isLoading == 1;
}