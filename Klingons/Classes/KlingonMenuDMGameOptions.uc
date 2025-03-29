//=============================================================================
// KlingonMenuDMGameOptions.
//=============================================================================
class KlingonMenuDMGameOptions expands KlingonMenuGameOptions
	localized;

var int RestoreBotNum;

function SetUpDisplay()
{	
	Super.SetUpDisplay();
	if ( FALSE == DeathMatchGame(GameType).bMultiPlayerBots ) 
		DeathMatchGame(GameType).InitialBots = 0;
	else
		RestoreBotNum = DeathMatchGame(GameType).InitialBots;
}


function bool ProcessYes()
{
	if ( Selection == 6 )
		DeathMatchGame(GameType).bCoopWeaponMode = TRUE;
	else if ( Selection == 9 )
	{
		DeathMatchGame(GameType).bMultiPlayerBots = TRUE;
		DeathMatchGame(GameType).InitialBots = RestoreBotNum;
	}
	else 
		return Super.ProcessYes();
	return true;
}

function bool ProcessNo()
{
	if ( Selection == 6 )
		DeathMatchGame(GameType).bCoopWeaponMode = FALSE;		
	else if ( Selection == 9 )
	{
		DeathMatchGame(GameType).bMultiPlayerBots = FALSE;		
		RestoreBotNum = DeathMatchGame(GameType).InitialBots;
		DeathMatchGame(GameType).InitialBots = 0;
	}
	else 
		return Super.ProcessNo();
	return true;
}

function bool ProcessLeft()
{
	if ( Selection == 3 )
	{
		if ( DeathMatchGame(GameType).FragLimit <= 95 )
			DeathMatchGame(GameType).FragLimit = FMax(0, DeathMatchGame(GameType).FragLimit - 5);
	}
	else if ( Selection == 4 )
		DeathMatchGame(GameType).TimeLimit = FMax(0, DeathMatchGame(GameType).TimeLimit - 5);
	else if ( Selection == 5 )
		DeathMatchGame(GameType).MaxPlayers = Max(1, DeathMatchGame(GameType).MaxPlayers - 1);
	else if ( Selection == 6 )
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 7 )
	{
		if ( TRUE == DeathMatchGame(GameType).bMultiPlayerBots ) 
			DeathMatchGame(GameType).InitialBots = Max(0, DeathMatchGame(GameType).InitialBots - 1);
	}
	else if ( Selection == 9 )
	{
		DeathMatchGame(GameType).bMultiPlayerBots = !DeathMatchGame(GameType).bMultiPlayerBots;
		if ( FALSE == DeathMatchGame(GameType).bMultiPlayerBots )
		{
			RestoreBotNum = DeathMatchGame(GameType).InitialBots;
			DeathMatchGame(GameType).InitialBots = 0;
		}
		else
			DeathMatchGame(GameType).InitialBots = RestoreBotNum;
	}		
	else if ( Selection == 10 )
		KlingonHUD(PlayerOwner.myHUD).ChangeDMHUD(-1);
	else 
		return Super.ProcessLeft();

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 3 )
	{
		if ( DeathMatchGame(GameType).FragLimit < 95 )
			DeathMatchGame(GameType).FragLimit += 5;
	}
	else if ( Selection == 4 )
		DeathMatchGame(GameType).TimeLimit += 5;
	else if ( Selection == 5 )
		DeathMatchGame(GameType).MaxPlayers = Min(16, DeathMatchGame(GameType).MaxPlayers + 1);
	else if ( Selection == 6 )
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 7 )
	{
		if ( TRUE == DeathMatchGame(GameType).bMultiPlayerBots ) 
			DeathMatchGame(GameType).InitialBots = Min(15, DeathMatchGame(GameType).InitialBots + 1);
	}
	else if ( Selection == 9 )
	{
		DeathMatchGame(GameType).bMultiPlayerBots = !DeathMatchGame(GameType).bMultiPlayerBots;		
		if ( FALSE == DeathMatchGame(GameType).bMultiPlayerBots ) 
		{
			RestoreBotNum = DeathMatchGame(GameType).InitialBots;
			DeathMatchGame(GameType).InitialBots = 0;
		}
		else
			DeathMatchGame(GameType).InitialBots = RestoreBotNum;
	}
	else if ( Selection == 10 )
		KlingonHUD(PlayerOwner.myHUD).ChangeDMHUD(1);
	else 
		return Super.ProcessRight();
	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 6 )
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 8 )
		ChildMenu = spawn(class'KlingonMenuBotConfig', owner);
	else if ( Selection == 9 )
	{
		DeathMatchGame(GameType).bMultiPlayerBots = !DeathMatchGame(GameType).bMultiPlayerBots;		
		if ( FALSE == DeathMatchGame(GameType).bMultiPlayerBots ) 
		{
			RestoreBotNum = DeathMatchGame(GameType).InitialBots;
			DeathMatchGame(GameType).InitialBots = 0;
		}
		else
			DeathMatchGame(GameType).InitialBots = RestoreBotNum;
	}
	else
		return Super.ProcessSelection();

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}

	return true;
}

function DrawOptions(canvas Canvas)
{
	local int i;

	for ( i=3; i<MenuLength+1; i++ )
		MenuList[i] = Default.MenuList[i];

	Super.DrawOptions(Canvas);
}

function DrawValues(canvas Canvas)
{
	local DeathMatchGame DMGame;

	DMGame = DeathMatchGame(GameType);

	// draw text
	MenuValues[3] = string(DMGame.FragLimit);
	MenuValues[4] = string(DMGame.TimeLimit);
	MenuValues[5] = string(DMGame.MaxPlayers);
	MenuValues[6] = string(DMGame.bCoopWeaponMode);
	MenuValues[7] = string(DMGame.InitialBots);
	MenuValues[8] = "";
	MenuValues[9] = string(DMGame.bMultiPlayerBots);
	MenuValues[10] = string(KlingonHUD(PlayerOwner.myHUD).DMHudMode);

	Super.DrawValues(Canvas);
}

defaultproperties
{
     GameClass=Class'Klingons.DeathMatchGame'
     MenuLength=9
     HelpMessage(3)="NUMBER OF FRAGS TO END GAME.  IF 0, NO LIMIT."
     HelpMessage(4)="TIME LIMIT (IN MINUTES) TO END GAME.  IF 0, NO LIMIT."
     HelpMessage(5)="MAXIMUM NUMBER OF PLAYERS ALLOWED IN THE GAME."
     HelpMessage(6)="WEAPONS RESPAWN INSTANTLY, BUT CAN ONLY BE PICKED UP ONCE BY A GIVEN PLAYER."
     HelpMessage(7)="NUMBER OF BOTS TO START PLAY (MAX 15)."
     HelpMessage(8)="CONFIGURE BOT GAME AND INDIVIDUAL PARAMETERS."
     HelpMessage(9)="USE BOTS WHEN PLAYING WITH OTHER PEOPLE."
     HelpMessage(10)="SHOW DEATHRITE HUD ON THE SCREEN"
     MenuList(3)="FRAG LIMIT"
     MenuList(4)="TIME LIMIT"
     MenuList(5)="MAX PLAYERS"
     MenuList(6)="WEAPON STAY"
     MenuList(7)="NUMBER OF BOTS"
     MenuList(8)="CONFIGURE BOTS"
     MenuList(9)="BOTS IN MULTIPLAYER"
     MenuList(10)="DEATHRITE HUD"
}
