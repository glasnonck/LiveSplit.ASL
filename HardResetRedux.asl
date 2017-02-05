state("hr.x64")
{
    int IsLoading : "hr.x64.exe", 0x0D6FE14;
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
