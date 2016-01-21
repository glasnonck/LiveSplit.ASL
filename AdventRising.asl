state("advent")
{
    int isNotLoading : "Engine.dll",  0x657AB0;
}

isLoading
{
    if (game == null || game.HasExited)
        return false;
    return current.isNotLoading != 1;
}
