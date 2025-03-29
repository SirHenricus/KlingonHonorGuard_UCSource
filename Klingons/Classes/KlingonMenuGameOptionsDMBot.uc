//=============================================================================
// KlingonMenuGameOptionsDMBot.
//=============================================================================
class KlingonMenuGameOptionsDMBot expands KlingonMenuGameOptions
	localized;

function bool ProcessYes()
{
	if ( Selection == 5 )
		DeathMatchGame(GameType).bCoopWeaponMode = TRUE;		
	else 
		return Super.ProcessYes();
	return true;
}

function bool ProcessNo()
{
	if ( Selection == 5 )
		DeathMatchGame(GameType).bCoopWeaponMode = FALSE;		
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
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 6 )
		DeathMatchGame(GameType).InitialBots = Max(0, DeathMatchGame(GameType).InitialBots - 1);
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
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 6 )
		DeathMatchGame(GameType).InitialBots = Min(15, DeathMatchGame(GameType).InitialBots + 1);
	else 
		return Super.ProcessRight();
	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 5 )
		DeathMatchGame(GameType).bCoopWeaponMode = !DeathMatchGame(GameType).bCoopWeaponMode;		
	else if ( Selection == 7 )
		ChildMenu = spawn(class'KlingonMenuBotConfig', owner);
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
	MenuValues[5] = string(DMGame.bCoopWeaponMode);
	MenuValues[6] = string(DMGame.InitialBots);

	Super.DrawValues(Canvas);
}

defaultproperties
{
     GameClass=Class'Klingons.DeathMatchGame'
     MenuLength=7
     HelpMessage(3)="NUMBER OF FRAGS TO END GAME.  IF 0, NO LIMIT."
     HelpMessage(4)="TIME LIMIT (IN MINUTES) TO END GAME.  IF 0, NO LIMIT."
     HelpMessage(5)="WEAPONS RESPAWN INSTANTLY, BUT CAN ONLY BE PICKED UP ONCE BY A GIVEN PLAYER."
     HelpMessage(6)="NUMBER OF BOTS TO START PLAY (MAX 15)."
     HelpMessage(7)="CONFIGURE BOT GAME AND INDIVIDUAL PARAMETERS."
     MenuList(3)="FRAG LIMIT"
     MenuList(4)="TIME LIMIT"
     MenuList(5)="WEAPON STAY"
     MenuList(6)="NUMBER OF BOTS"
     MenuList(7)="CONFIGURE BOTS"
}
