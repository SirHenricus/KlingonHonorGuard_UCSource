//=============================================================================
// KlingonMenuJoin.
//=============================================================================
class KlingonMenuJoin expands KlingonMenu
	localized
	config;

var string[128] LastServer;
var string[128] OldLastServer;
var() localized string[128] InternetOption;
var() localized string[128] FastInternetOption;
var() localized string[128] LANOption;
var int netspeed;

function PostBeginPlay()
{
	Super.PostBeginPlay();
	OldLastServer = LastServer;
} 

function ProcessMenuInput( coerce string[64] InputString )
{
	local KlingonMenuMesh ChildMenu;

	if ( selection == 3 )
	{
		LastServer = InputString;
		SaveConfigs();
		ChildMenu = spawn(class'KlingonMenuMesh', owner);
		if ( ChildMenu != None )
		{
			ChildMenu.StartMap = LastServer;
			HUD(Owner).MainMenu = ChildMenu;
			ChildMenu.ParentMenu = self;
			ChildMenu.PlayerOwner = PlayerOwner;
		}
	}
}

function ProcessMenuEscape()
{
	if ( selection == 3 )
		LastServer = OldLastServer;
}

function ProcessMenuUpdate( coerce string[64] InputString )
{
	if ( selection == 3 )
		LastServer = (InputString$"_");
}

function bool ProcessLeft()
{
	if ( Selection == 4 )
	{
		netspeed--;
		if ( netspeed < 0 )
			netspeed = 2;
		PlayerOwner.ChangeNetSpeed(netspeed);
	}
	else
		ProcessRight();
}

function bool ProcessRight()
{
	if ( Selection == 3 )
	{
		LastServer = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( Selection == 4 )
	{
		netspeed++;
		if ( netspeed > 2 )
			netspeed = 0;
		PlayerOwner.ChangeNetSpeed(netspeed);
	}
}

function bool ProcessSelection()
{
	local Menu ChildMenu;
	local class<Menu> KlingonMenuListenClass;

	if ( Selection == 3 )
	{
		LastServer = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( Selection == 1 )
	{
		if ( PlayerOwner.NetSpeed < 12500 )
			PlayerOwner.ChangeNetSpeed(2);
		SaveConfigs();
		KlingonMenuListenClass = class<Menu>(DynamicLoadObject("Klingons.KlingonMenuListen", class'Class'));
		ChildMenu = spawn(KlingonMenuListenClass, owner);
	}
	else if ( Selection == 2 )
	{
		SaveConfigs();
		ChildMenu = spawn(class'KlingonMenuFavorites', owner);
	}
	else if ( Selection == 5 )
		PlayerOwner.ConsoleCommand("start http://www.microprose.com/serverlist");
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
	PlayerOwner.SaveConfig();
	SaveConfig();
}

function DrawMenu(canvas Canvas)
{
	local int StartX, StartY, Spacing;
	
	DrawBackGround(Canvas, false);	

	KDrawList( Canvas, 0, 0);
	
	if ( PlayerOwner.NetSpeed <= 3000 )
	{
		netspeed = 0;
		MenuValues[4] = InternetOption;
	}
	else if ( PlayerOwner.NetSpeed < 12500 )
	{
		netspeed = 1;
		MenuValues[4] = FastInternetOption;
	}
	else
	{
		netspeed = 2;
		MenuValues[4] = LANOption;
	}

	MenuValues[3] = LastServer;
	
	KDrawChangeList(Canvas, 0, 0);

	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     InternetOption="Internet (28.8)"
     FastInternetOption="Fast Internet (56K)"
     LANOption="LAN"
     MenuLength=4
     HelpMessage(1)="LISTEN FOR LOCAL STATIONS"
     HelpMessage(2)="CHOOSE A SERVER FROM A LIST OF FAVORITES"
     HelpMessage(3)="HIT ENTER TO TYPE IN A SERVER ADDRESS.  HIT ENTER AGAIN TO GO TO THIS SERVER."
     HelpMessage(4)="SET NETWORKING OPTIMIZATION TO LAN, FAST INTERNET (56K MODEM OR ISDN) OR INTERNET (28.8 TO 33.6 MODEM SPEED)"
     HelpMessage(5)="OPEN THE MICROPROSE KHG SERVER LIST WWW PAGE"
     MenuList(1)="FIND LOCAL SERVERS"
     MenuList(2)="CHOOSE FROM FAVORITES"
     MenuList(3)="OPEN"
     MenuList(4)="OPTIMIZED FOR"
     MenuList(5)="GO TO THE KHG SERVERS"
     MenuTitle="JOIN GAME"
}
