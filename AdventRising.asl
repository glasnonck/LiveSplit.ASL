state("advent")
{
    int isNotLoading : "Engine.dll",  0x657AB0;
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
    return current.isNotLoading != 1;
}