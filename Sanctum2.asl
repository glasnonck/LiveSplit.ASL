state("SanctumGame-Win32-Shipping")
{
	int loadingComicStrip : "SanctumGame-Win32-Shipping.exe", 0x0269A050;
	int creatingLobby     : "steam_api.dll", 0x0170E4;
	int greySpinnerLoad   : "SanctumGame-Win32-Shipping.exe", 0x0267F3E8;
	int splashScreenLoad  : "SanctumGame-Win32-Shipping.exe", 0x0269A158;
}

init
{
    timer.IsGameTimePaused = false;
    game.Exited += (s, e) => timer.IsGameTimePaused = false;
}

isLoading
{
	return current.loadingComicStrip == 1
		&& current.creatingLobby == 1
		&& current.greySpinnerLoad > 0
		&& current.splashScreenLoad == 1;
}
