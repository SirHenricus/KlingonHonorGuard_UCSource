//=============================================================================
// KlingonMenuSinglePlayer.
//=============================================================================
class KlingonMenuSinglePlayer expands KlingonMenu
	config
	localized;

var actor RealOwner;
var bool bSetup;
var string[21] PlayerName;
var MenuGrid1 BigTrig;

var config string[32] PlayerClasses[16];
var config int NumPlayerClasses;
var int PlayerClassNum;
var string[128] StartMap;
var config byte SinglePlayerMesh[16];
var bool SinglePlayerOnly;
var string[64] ClassString;
var bool HasProcessed;
var texture OldSkin;
var mesh    OldMesh;
var bool  WasBehindView;


function ProcessMenuInput( coerce string[64] InputString )
{
	InputString = Left(InputString, 20);

	if ( selection == 1 )
	{
		PlayerOwner.ChangeName(InputString);
		PlayerName = PlayerOwner.PlayerName;
		PlayerOwner.UpdateURL("Name="$InputString);
	}
}

function ProcessMenuEscape()
{
	PlayerName = PlayerOwner.PlayerName;
}

function ProcessMenuUpdate( coerce string[64] InputString )
{
	InputString = Left(InputString, 20);

	if ( selection == 1 )
		PlayerName = (InputString$"_");
}

function Menu ExitMenu()
{
	SetOwner(RealOwner);
	PlayerOwner.Skin = OldSkin; 
	PlayerOwner.Mesh = OldMesh;
	Super.ExitMenu();
	BigTrig.Destroy();
	KlingonHUD(PlayerOwner.myhud).ExitSetupMenu( );
}

function bool ProcessLeft()
{
	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( selection == 2 )
	{
		PlayerClassNum++;
		if ( PlayerClassNum == NumPlayerClasses )
			PlayerClassNum = 0;
		if ( SinglePlayerOnly && (SinglePlayerMesh[PlayerClassNum] == 0) )
		{
			ProcessLeft();
			return true;
		}
		ChangeMesh();
	}
	
	return true;
}

function bool ProcessRight()
{
	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( selection == 2 )
	{
		PlayerClassNum--;
		if ( PlayerClassNum < 0 )
			PlayerClassNum = NumPlayerClasses - 1;
		if ( SinglePlayerOnly && (SinglePlayerMesh[PlayerClassNum] == 0) )
		{
			ProcessRight();
			return true;
		}
		ChangeMesh();
	}

	return true;
}

function bool ProcessSelection()
{
	local int i, p;

	if ( HasProcessed == true )
		return true;

	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if( selection == 3 )
	{
		HasProcessed = true;
		SetOwner(RealOwner);
		bExitAllMenus = true;

		PlayerOwner.ClientSetMusic( None, 0, 255, MTRAN_Instant );	

		if ( ClassString == "" )
			ClassString = string(PlayerOwner.Class.Name);

		while ( i<NumPlayerClasses )
		{
			p = InStr(PlayerClasses[i],".");
			if ( (p != -1) 
				&& (Right(PlayerClasses[i], Len(PlayerClasses[i]) - p - 1) ~= ClassString) )
			{
				ClassString = PlayerClasses[i];
				break;
			}
			i++;
		}
					
		PlayerOwner.ConsoleCommand( "playavi brief0102.avi Y None N None N None N None N" );
				
		StartMap = StartMap
					$"?Class="$ClassString
					$"?Skin="$PlayerOwner.Skin
					$"?Name="$PlayerOwner.PlayerName
					$"?Team=Red"
					$"?Rate="$PlayerOwner.NetSpeed;

		SaveConfigs();
		PlayerOwner.ClientTravel(StartMap, TRAVEL_Absolute, false);

		KlingonPlayer(Owner).LogBook.ResetAVI();
		KlingonPlayer(Owner).LogBook.AVIIndex++;
		KlingonPlayer(Owner).LogBook.CurrentAVI = "brief0102.avi";											
		HasProcessed = false;
	}

	return true;
}



function SaveConfigs()
{
	PlayerOwner.SaveConfig();
	SaveConfig();
}


function SetUpDisplay()
{	
	local rotator spin;
	local int i;

	KlingonHUD(PlayerOwner.myhud).EnterSetupMenu( );
	
	bSetup = true;
	HasProcessed = false;
	RealOwner = Owner;
	SetOwner(PlayerOwner);
	PlayerName = PlayerOwner.PlayerName;
	PlayerOwner.bBehindView = false;
	WasBehindView = false;

	OldSkin = PlayerOwner.Skin; 
	OldMesh = PlayerOwner.Mesh;
	
	if ( string(PlayerOwner.Mesh) != "DMVacSuit" )
	{
		Mesh = PlayerOwner.Mesh;
		Skin = PlayerOwner.Skin;
	}
	else
	{
		Mesh = PlayerOwner.default.Mesh;
		Skin = KlingonPlayer(PlayerOwner).MySkin;
	}			

	LoopAnim(AnimSequence);
	
	KlingonPlayer(PlayerOwner).ShowWeapon();

	Spin.Pitch = 0;
	Spin.Yaw   = 49052 + PlayerOwner.ViewRotation.Yaw;	
	Spin.Roll  = 0;

	BigTrig = spawn( Class'MenuGrid1',PlayerOwner,,,Spin);
	BigTrig.DrawScale = 0.09;
	BigTrig.BHidden = false;	
	BigTrig.BUnlit = true;	

	for ( i=0; i<NumPlayerClasses; i++ )
	{
		if ( PlayerClasses[i] ~= ("Klingons."$PlayerOwner.Class) )
		{
			PlayerClassNum = i;
			break;
		}
	}
}

function DrawMenu(canvas Canvas)
{
	local int i, StartX, StartY, Spacing;
	local vector DrawOffset;
	local vector DrawOffset2;
	local rotator NewRot;

	if ( PlayerOwner.bBehindView == true )
	{
		WasBehindView = true;
		PlayerOwner.bBehindView = false;
	}

	DrawSetupBackGround( Canvas );
	
	if ( !bSetup )
		SetUpDisplay();

	PlayerOwner.ViewRotation.Pitch = 0;
	PlayerOwner.ViewRotation.Roll = 0;
// 4.0 2.0 0.0 	
	DrawOffset = ((vect(4.0,1.8,0.0)) >> PlayerOwner.ViewRotation);
	DrawOffset += (PlayerOwner.EyeHeight * vect(0,0,1));	
	SetLocation(PlayerOwner.Location + DrawOffset);
	
//	6.0 2.0 0.0 
	DrawOffset2 += ((vect(6.0,6.1,1.0)) >> PlayerOwner.ViewRotation);
	DrawOffset2 += (PlayerOwner.EyeHeight * vect(0,0,0.98));
	BigTrig.SetLocation (PlayerOwner.Location + DrawOffset2);
		
	NewRot = PlayerOwner.ViewRotation;
	NewRot.Yaw = Rotation.Yaw;
	SetRotation(NewRot);
			
	for ( i=1; i<6; i++ )
		MenuList[i] = Default.MenuList[i];

	KDrawList( Canvas, 45, 140);

	if ( !PlayerOwner.Player.Console.IsInState('MenuTyping') )
	{
		PlayerName = PlayerOwner.PlayerName;
	}
	MenuValues[1] = PlayerName;
	MenuValues[2] = string(Mesh);

	KDrawChangeList(Canvas, 160, 140);

	// Draw help panel
	KDrawHelpPanel(Canvas);	

	if ( WasBehindView == true )
	{
		PlayerOwner.bBehindView = true;	
		WasBehindView = false;	
	}
}


function MenuTick( float DeltaTime )
{
	local rotator newRot;
	local float RemainingTime;

	if ( Level.Pauser == "" )
		return;

	// explicit rotation, since game is paused
	newRot = Rotation;
	newRot.Yaw = newRot.Yaw + RotationRate.Yaw * DeltaTime;
	SetRotation(newRot);

	//explicit animation
	RemainingTime = DeltaTime * 0.5;
	while ( RemainingTime > 0 )
	{
		if ( AnimFrame < 0 )
		{
			AnimFrame += TweenRate * RemainingTime;
			if ( AnimFrame > 0 )
				RemainingTime = AnimFrame/TweenRate;
			else
				RemainingTime = 0;
		}
		else
		{
			AnimFrame += AnimRate * RemainingTime;
			if ( AnimFrame > 1 )
			{
				RemainingTime = (AnimFrame - 1)/AnimRate;
				AnimFrame = 0;
			}
			else
				RemainingTime = 0;
		}
	}
}


function bool ChangeMesh()
{ 
	local class<playerpawn> NewPlayerClass;

	NewPlayerClass = class<playerpawn>(DynamicLoadObject(PlayerClasses[PlayerClassNum], class'Class'));

	if ( NewPlayerClass != None )
	{
		ClassString = PlayerClasses[PlayerClassNum];
		mesh = NewPlayerClass.Default.mesh;
		skin = NewPlayerClass.Default.skin;

		if (KlingonPlayer(Owner) != None) {
			if (ClassString == "Klingons.DMMale") {
				KlingonPlayer(Owner).bIsMale=True;
			}
			else {
				KlingonPlayer(Owner).bIsMale=False;
			}
		}
		return true;
	}
	return false;
}	

defaultproperties
{
     PlayerClasses(0)="Klingons.DMFemale"
     PlayerClasses(1)="Klingons.DMMale"
     PlayerClasses(2)="Klingons.DMVacSuit"
     NumPlayerClasses=3
     SinglePlayerMesh(0)=1
     SinglePlayerMesh(1)=1
     MenuLength=3
     HelpMessage(1)="HIT ENTER TO TYPE IN YOUR NAME."
     HelpMessage(2)="CHANGE YOUR GENDER USING THE LEFT AND RIGHT ARROW KEYS."
     HelpMessage(3)="PRESS ENTER TO START GAME."
     MenuList(1)="NAME:"
     MenuList(2)="GENDER:"
     MenuList(3)="START GAME"
     MenuTitle="SETUP"
     bHidden=False
     Physics=PHYS_Rotating
     AnimSequence=Taunt1
     DrawType=DT_Mesh
     DrawScale=0.040000
     AmbientGlow=200
     bOnlyOwnerSee=True
     bFixedRotationDir=True
     RotationRate=(Yaw=8000)
     DesiredRotation=(Yaw=3000)
}
