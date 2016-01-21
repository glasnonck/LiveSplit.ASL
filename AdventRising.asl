state("advent")
{
    int isNotLoading : "Engine.dll",  0x657AB0;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = true;
}

isLoading
{
    return current.isNotLoading != 1;
}
