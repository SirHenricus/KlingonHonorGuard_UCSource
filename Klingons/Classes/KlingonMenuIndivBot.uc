//=============================================================================
// KlingonMenuIndivBot.
//=============================================================================
class KlingonMenuIndivBot expands KlingonMenu
	config
	localized;

var actor RealOwner;
var bool bSetup;
var int Num;
var() config string[32] PlayerClasses[16];
var() int NumPlayerClasses;
var int PlayerClassNum;
var string[32] RealName, RealTeam;
var byte SkinNum;
var	KlingonBotInfo BotConfig;
var MenuGrid1 BigTrig;
var bool WasBehindView;

function PostBeginPlay()
{
	if ( class'GameInfo'.Default.bShareWare )
		NumPlayerClasses = 1;
	if ( Level.Game.IsA('DeathMatchGame') )
		BotConfig = DeathMatchGame(Level.Game).BotConfig;
	else
		BotConfig = Spawn(class'KlingonBotInfo');
	Super.PostBeginPlay();
}

function Destroyed()
{
	Super.Destroyed();
	if ( !Level.Game.IsA('DeathMatchGame') || (BotConfig != DeathMatchGame(Level.Game).BotConfig) )
		BotConfig.Destroy();
}

function ProcessMenuInput( coerce string[64] InputString )
{
	InputString = Left(InputString, 20);
	if ( selection == 2 )
		BotConfig.SetBotName(InputString, Num);
//	else if ( selection == 6 )
//		BotConfig.SetBotTeam(InputString, Num);
}

function ProcessMenuEscape()
{
	if ( selection == 2 )
		BotConfig.SetBotName(RealName, Num);
	else if ( selection == 6 )
		BotConfig.SetBotTeam(RealTeam, Num);
}

function ProcessMenuUpdate( coerce string[64] InputString )
{
	InputString = Left(InputString, 19);
	if ( selection == 2 )
		BotConfig.SetBotName(InputString$"_", Num);
//	else if ( selection == 6 )
//		BotConfig.SetBotTeam(InputString$"_", Num);
}

function Menu ExitMenu()
{
	SetOwner(RealOwner);
	Super.ExitMenu();
	BigTrig.Destroy();
}

function bool ProcessLeft()
{
	local int i;
	local string[64] SkinName;
	local texture NewSkin;

	if ( Selection == 1 )
	{
		Num--;
		if ( Num < 0 )
			Num = 15;

		for ( i=0; i<NumPlayerClasses; i++ )
			if( (PlayerClasses[i]$"Bot") ~= BotConfig.GetBotClassName(Num) )
			{
				PlayerClassNum = i;
				break;
			}
		SkinName = BotConfig.GetBotSkin(Num);
		ChangeMesh();
		
		if ( SkinName != "" )
		{
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				BotConfig.SetBotSkin(SkinName, Num);
				BotConfig.SetBotTeam(string(NewSkin), Num);
			}
		}
	}
	else if ( Selection == 2 )
	{
		RealName = BotConfig.GetBotName(Num);
		BotConfig.SetBotName("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( selection == 3 )
	{
		PlayerClassNum++;
		if ( PlayerClassNum == NumPlayerClasses )
			PlayerClassNum = 0;
		ChangeMesh();
	}	
	else if ( Selection == 4 )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), -1);
		if ( SkinName != "" )
		{
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				BotConfig.SetBotSkin(SkinName, Num);
				BotConfig.SetBotTeam(string(NewSkin), Num);
			}
		}
	}
	else if ( selection == 5 )
		BotConfig.BotSkills[Num] = FMax(0, BotConfig.BotSkills[Num] - 0.2);
/*
	else if ( Selection == 6 )
	{
		RealName = BotConfig.GetBotTeam(Num);
		BotConfig.SetBotTeam("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/
	else
		return false;

	return true;
}

function bool ProcessRight()
{
	local int i;
	local string[64] SkinName;
	local texture NewSkin;

	if ( Selection == 1 )
	{
		Num++;
		if ( Num > 15 )
			Num = 0;

		for ( i=0; i<NumPlayerClasses; i++ )
			if ( (PlayerClasses[i]$"Bot") ~= BotConfig.GetBotClassName(Num) )
			{
				PlayerClassNum = i;
				break;
			}
		SkinName = BotConfig.GetBotSkin(Num);
		ChangeMesh();
		if ( SkinName != "" )
		{
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				BotConfig.SetBotSkin(SkinName, Num);
				BotConfig.SetBotTeam(string(NewSkin), Num);
			}
		}
	}
	else if ( Selection == 2 )
	{
		RealName = BotConfig.GetBotName(Num);
		BotConfig.SetBotName("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
	else if ( selection == 3 )
	{
		PlayerClassNum--;
		if ( PlayerClassNum < 0 )
			PlayerClassNum = NumPlayerClasses - 1;
		ChangeMesh();
	}
	else if ( Selection == 4 )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), 1);
		if ( SkinName != "" )
		{
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				BotConfig.SetBotSkin(SkinName, Num);
				BotConfig.SetBotTeam(string(NewSkin), Num);
			}
		}
	}
	else if ( selection == 5 )
		BotConfig.BotSkills[Num] = FMin(3.0, BotConfig.BotSkills[Num] + 0.2);
/*
	else if ( Selection == 6 )
	{
		RealName = BotConfig.GetBotTeam(Num);
		BotConfig.SetBotTeam("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/
	else
		return false;

	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 2 )
	{
		RealName = BotConfig.GetBotName(Num);
		BotConfig.SetBotName("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
/*
	else if ( Selection == 6 )
	{
		RealName = BotConfig.GetBotTeam(Num);
		BotConfig.SetBotTeam("_", Num);
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/
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
	BotConfig.SaveConfig();
}

function SetUpDisplay()
{
	local int i;
	local string[64] SkinName;
	local texture NewSkin;
	local rotator spin;

	for ( i=0; i<NumPlayerClasses; i++ )		
		if ( (PlayerClasses[i]$"Bot") ~= BotConfig.GetBotClassName(Num) )
		{
			PlayerClassNum = i;
			break;
		}

	bSetup = true;
	RealOwner = Owner;
	SetOwner(PlayerOwner);
	WasBehindView = false;
	SkinName = BotConfig.GetBotSkin(Num);	
	ChangeMesh();

	if ( SkinName != "" )
	{
		NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
		if ( NewSkin != None )
		{
			Skin = NewSkin;
			BotConfig.SetBotSkin(SkinName, Num);
		}
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

}


function DrawMenu(canvas Canvas)
{
	local int i;
	local bool bFoundValue;
	local vector DrawOffset;
	local vector DrawOffset2;
	local rotator NewRot;
	local string[64] SkinName;
	local texture NewSkin;

	if ( PlayerOwner.bBehindView == true )
	{
		WasBehindView = true;
		PlayerOwner.bBehindView = false;
	}

	DrawSetupBackGround( Canvas );

	if ( !bSetup )
		SetupDisplay();

	// draw text
	KDrawList( Canvas, 45, 140);

	MenuValues[1] = string(Num);
	MenuValues[2] = BotConfig.GetBotName(Num);
	MenuValues[3] = string(Mesh);
		
	if ( Skin == None )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), 1);
		if ( SkinName != "" )
		{
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				BotConfig.SetBotSkin(SkinName, Num);
				BotConfig.SetBotTeam(string(NewSkin), Num);
			}
		}
	}		
	
	MenuValues[4] = string(Skin);
	MenuValues[5] = string(BotConfig.BotSkills[Num]);
	MenuValues[6] = BotConfig.GetBotTeam(Num);
	KDrawChangeList(Canvas, 170, 140);
	
	// Draw help panel
	KDrawHelpPanel(Canvas);


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

function ChangeMesh()
{ 
	local class<playerpawn> NewPlayerClass;

	BotConfig.SetBotClass(PlayerClasses[PlayerClassNum]$"Bot", Num);
 	NewPlayerClass = class<playerpawn>(DynamicLoadObject(PlayerClasses[PlayerClassNum], class'Class'));
	BotConfig.SetBotSkin(string(NewPlayerClass.Default.Skin), Num); 
	mesh = NewPlayerClass.Default.mesh;
	skin = NewPlayerClass.Default.skin;
	BotConfig.SetBotTeam(string(skin), Num);
}	

defaultproperties
{
     PlayerClasses(0)="Klingons.DMFemale"
     PlayerClasses(1)="Klingons.DMMale"
     NumPlayerClasses=2
     MenuLength=5
     HelpMessage(1)="WHICH BOT CONFIGURATION IS BEING EDITED. USE LEFT AND RIGHT ARROWS TO CHANGE."
     HelpMessage(2)="HIT ENTER TO EDIT THE NAME OF THIS BOT."
     HelpMessage(3)="USE THE LEFT AND RIGHT ARROW KEYS TO CHANGE THE CLASS OF THIS BOT."
     HelpMessage(4)="USE THE LEFT AND RIGHT ARROW KEYS TO CHANGE THE SKIN OF THIS BOT."
     HelpMessage(5)="ADJUST THE OVERALL SKILL OF THIS BOT BY THIS AMOUNT (RELATIVE TO THE BASE SKILL FOR BOTS)."
     HelpMessage(6)="TYPE IN WHICH TEAM THIS BOT PLAYS ON (RED, GREY, GREEN, OR GOLD)."
     MenuList(1)="BOT #"
     MenuList(2)="NAME"
     MenuList(3)="CLASS"
     MenuList(4)="TEAM"
     MenuList(5)="SKILL ADJUST"
     MenuList(6)="SKIN"
     MenuTitle="BOT CONFIG"
     bHidden=False
     Physics=PHYS_Rotating
     AnimSequence=Taunt1
     DrawType=DT_Mesh
     DrawScale=0.040000
     bUnlit=True
     bOnlyOwnerSee=True
     bFixedRotationDir=True
     RotationRate=(Yaw=8000)
     DesiredRotation=(Yaw=30000)
}
