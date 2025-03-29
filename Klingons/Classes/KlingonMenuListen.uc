//=============================================================================
// KlingonMenuListen.
//=============================================================================
class KlingonMenuListen expands KlingonMenu
	localized;

var string[128] LastServer;
var ClientBeaconReceiver receiver;
var float ListenTimer;

function PostBeginPlay()
{
	local class<ClientBeaconReceiver> C;

	Super.PostBeginPlay();
	C = class<ClientBeaconReceiver>(DynamicLoadObject("IpDrv.ClientBeaconReceiver", class'Class'));
	receiver = spawn(C);
}

function Destroyed()
{
	Super.Destroyed();
	if ( receiver != None )
		receiver.Destroy();
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( MenuLength == 0 )
		return false;

	ChildMenu = spawn(class'KlingonMenuMesh', owner);
	KlingonMenuMesh(ChildMenu).StartMap = Receiver.GetBeaconAddress(Selection - 1);

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}
	return true;
}

function DrawMenu(canvas Canvas)
{
	local int StartX, StartY, Spacing, i;
	
	DrawBackGround(Canvas, false);	

	MenuLength = 0;
	for ( i=0; i<16; i++ )
	{
		if ( Receiver.GetBeaconAddress(i) != "" )
		{
			MenuLength++;
			MenuList[i+1] =  Receiver.GetBeaconText(i);
		}
	}

	if ( MenuLength == 0 )	
		return;
	else if ( Selection == 0 )
		Selection = 1;

	KDrawList( Canvas, 320, 0);
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     HelpMessage(1)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(2)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(3)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(4)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(5)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(6)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(7)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(8)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(9)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(10)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(11)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(12)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(13)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(14)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(15)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(16)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(17)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(18)="HIT ENTER TO SELECT THIS SERVER."
     HelpMessage(19)="HIT ENTER TO SELECT THIS SERVER."
     MenuTitle="LOCAL SERVERS"
}
