state("sw")
{
    int IsLoading : "sw.exe", 0x0C85198;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
{
    return current.IsLoading != 0;
}
