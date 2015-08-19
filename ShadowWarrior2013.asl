state("sw")
{
    int IsLoading : "sw.exe", 0x0C85198;
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
    return current.IsLoading != 0;
}