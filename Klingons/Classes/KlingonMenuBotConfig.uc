//=============================================================================
// KlingonMenuBotConfig.
//=============================================================================
class KlingonMenuBotConfig expands KlingonMenu
	localized;

var		bool bAdjustSkill;
var		bool bRandomOrder;

function PostBeginPlay()
{
	local KlingonBotInfo BotConfig;

	Super.PostBeginPlay();

	if ( Level.Game.IsA('DeathMatchGame') )
		BotConfig = DeathMatchGame(Level.Game).BotConfig;
	else
		BotConfig = Spawn(class'KlingonBotInfo');

	bAdjustSkill = BotConfig.bAdjustSkill;
	bRandomOrder = BotConfig.bRandomOrder;

	if ( !Level.Game.IsA('DeathMatchGame') )
		BotConfig.Destroy();
}

function bool ProcessYes()
{
	if ( Selection == 1 )
		bAdjustSkill = true;
	else if ( Selection == 3 )
		bRandomOrder = true;
	else
		return false;

	return true;
}

function bool ProcessNo()
{
	if ( Selection == 1 )
		bAdjustSkill = false;
	else if ( Selection == 3 )
		bRandomOrder = false;
	else
		return false;

	return true;
}

function bool ProcessLeft()
{
	if ( Selection == 1 )
		bAdjustSkill = !bAdjustSkill;
	else if ( Selection == 2 )
		Level.Game.Difficulty = Max( 0, Level.Game.Difficulty - 1 );
	else if ( Selection == 3 )
		bRandomOrder = !bRandomOrder;
	else
		return false;

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 1 )
		bAdjustSkill = !bAdjustSkill;
	else if ( Selection == 2 )
		Level.Game.Difficulty = Min( 3, Level.Game.Difficulty + 1 );
	else if ( Selection == 3 )
		bRandomOrder = !bRandomOrder;
	else
		return false;

	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 1 )
		bAdjustSkill = !bAdjustSkill;
	else if ( Selection == 3 )
		bRandomOrder = !bRandomOrder;
	else if ( Selection == 4 )
		ChildMenu = spawn(class'KlingonMenuIndivBot', owner);
	else
		return false;

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}
	return true;
}

function SaveConfigs()
{
	local KlingonBotInfo BotConfig;

	if ( Level.Game.IsA('DeathMatchGame') )
	{
		DeathMatchGame(Level.Game).BotConfig.bAdjustSkill = bAdjustSkill;
		DeathMatchGame(Level.Game).BotConfig.bRandomOrder = bRandomOrder;
	}
	BotConfig = Spawn(class'KlingonBotInfo');
	BotConfig.bAdjustSkill = bAdjustSkill;
	BotConfig.bRandomOrder = bRandomOrder;
	Level.Game.SaveConfig();
	BotConfig.SaveConfig();

	if ( !Level.Game.IsA('DeathMatchGame') )
		BotConfig.Destroy();
}


function DrawMenu(canvas Canvas)
{
	local int i;
	local bool bFoundValue;

	DrawBackGround(Canvas, false );
		
	KDrawList(Canvas, 0, 0);

	MenuValues[1] = string(bAdjustSkill);
	MenuValues[2] = string(Level.Game.Difficulty);
	MenuValues[3] = string(bRandomOrder);
	
	KDrawChangeList(Canvas, 380, 0);

	// Draw help panel
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuLength=4
     HelpMessage(1)="BOTS ADJUST THEIR SKILL LEVEL BASED ON HOW THEY ARE DOING AGAINST PLAYERS."
     HelpMessage(2)="BASE SKILL LEVEL OF BOTS (BETWEEN 0 AND 3)."
     HelpMessage(3)="IF TRUE, BOTS ENTER THE GAME IN RANDOM ORDER. IF FALSE, THEY ENTER IN THEIR CONFIGURATION ORDER."
     HelpMessage(4)="CHANGE THE CONFIGURATION OF INDIVIDUAL BOTS."
     MenuList(1)="AUTO-ADJUST SKILLS"
     MenuList(2)="BASE SKILL"
     MenuList(3)="RANDOM ORDER"
     MenuList(4)="CONFIGURE INDIVIDUAL BOTS"
     MenuTitle="BOTS"
}
