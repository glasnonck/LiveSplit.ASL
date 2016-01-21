state("sw")
{
    int IsLoading : "sw.exe", 0x0C85198;
}

isLoading
{
    if (game == null || game.HasExited)
        return false;
    return current.IsLoading != 0;
}
