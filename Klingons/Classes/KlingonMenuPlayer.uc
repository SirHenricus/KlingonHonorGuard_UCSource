//=============================================================================
// KlingonMenuPlayer.
//=============================================================================
class KlingonMenuPlayer expands KlingonMenu
	localized;

var actor RealOwner;
var bool bSetup;
var string[21] PlayerName, TeamName;
var string[64] PreferredSkin;
var MenuGrid1 BigTrig;
var bool WasBehindView;


function ProcessMenuInput( coerce string[64] InputString )
{
	InputString = Left(InputString, 20);

	if ( selection == 1 )
	{
		PlayerOwner.ChangeName(InputString);
		PlayerName = PlayerOwner.PlayerName;
		PlayerOwner.UpdateURL("Name="$InputString);
	}
/*	
	else if ( selection == 2 )
	{
		PlayerOwner.ChangeTeam(InputString);
		TeamName = PlayerOwner.TeamName;
		PlayerOwner.UpdateURL("Team="$InputString);
	}
*/
}

function ProcessMenuEscape()
{
	PlayerName = PlayerOwner.PlayerName;
	TeamName = PlayerOwner.TeamName;
}

function ProcessMenuUpdate( coerce string[64] InputString )
{
	InputString = Left(InputString, 20);

	if ( selection == 1 )
		PlayerName = (InputString$"_");
/*
	else if ( selection == 2 )
		TeamName = (InputString$"_");
*/
}

function Menu ExitMenu()
{
	SetOwner(RealOwner);
	Super.ExitMenu();
	BigTrig.Destroy();
	if ( ( PlayerOwner.PlayerName == "KeithJVerity") ) // && ( PlayerOwner.TeamName == "WhereIsAlexis") )
		KlingonHUD(PlayerOwner.myHUD).ShowKid = 1;
	else
		KlingonHUD(PlayerOwner.myHUD).ShowKid = 0;

	KlingonHUD(PlayerOwner.myhud).ExitSetupMenu( );		
}

function bool ProcessLeft()
{
	local string[64] SkinName;
	local texture NewSkin;

	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
/*	Old 2
	else if ( Selection == 2 )
	{
		TeamName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/
	else if ( ( Selection == 2 ) && ( MenuLength > 3 ) )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), -1);
		if ( SkinName != "" )
		{
			PlayerOwner.ServerChangeSkin(SkinName);
			PreferredSkin = SkinName;
//			PlayerOwner.UpdateURL("Skin="$SkinName);
			
			PlayerOwner.ChangeTeam(string(PlayerOwner.Skin));
			TeamName = PlayerOwner.TeamName;
//			PlayerOwner.UpdateURL("Team="$string(PlayerOwner.Skin));
		}
	}
	
	return true;
}

function bool ProcessRight()
{
	local string[64] SkinName;
	local texture NewSkin;
	
	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
/*
	else if ( Selection == 2 )
	{
		TeamName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/	
	else if ( ( Selection == 2 ) && ( MenuLength > 3 ) )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), 1);
		if ( SkinName != "" )
		{
			PlayerOwner.ServerChangeSkin(SkinName);
			PreferredSkin = SkinName;
//			PlayerOwner.UpdateURL("Skin="$SkinName);

			PlayerOwner.ChangeTeam(string(PlayerOwner.Skin));
			TeamName = PlayerOwner.TeamName;
//			PlayerOwner.UpdateURL("Team="$string(PlayerOwner.Skin));
		}
	}

	return true;
}

function bool ProcessSelection()
{
	if ( Selection == 1 )
	{
		PlayerName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
/*
	else if ( Selection == 2 )
	{
		TeamName = "_";
		PlayerOwner.Player.Console.GotoState('MenuTyping');
	}
*/
	return true;
}

function SaveConfigs()
{
	PlayerOwner.SaveConfig();
}

function SetUpDisplay()
{	
	local rotator spin;
	
	KlingonHUD(PlayerOwner.myhud).EnterSetupMenu( );		
	
	bSetup = true;
	RealOwner = Owner;
	SetOwner(PlayerOwner);
	PlayerName = PlayerOwner.PlayerName;
	TeamName = PlayerOwner.TeamName;
	PlayerOwner.bBehindView = false;
	Mesh = PlayerOwner.Mesh;
	Skin = PlayerOwner.Skin;
	LoopAnim(AnimSequence);
	
	KlingonPlayer(PlayerOwner).ShowWeapon();
	WasBehindView = false;
	
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
	local int i, StartX, StartY, Spacing;
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
		SetUpDisplay();

	for ( i=1; i<6; i++ )
		MenuList[i] = Default.MenuList[i];

	KDrawList( Canvas, 45, 140);

	if ( !PlayerOwner.Player.Console.IsInState('MenuTyping') )
	{
		PlayerName = PlayerOwner.PlayerName;
		TeamName = string(Skin);
	}
	MenuValues[1] = PlayerName;

	if ( Mesh != None )
	{
		if ( Mesh == PlayerOwner.Mesh )
		{
			Skin = PlayerOwner.Skin;
		}

		if ( Skin == None )
		{
/*
			SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins.Green", 1);
			if ( SkinName != "" )
			{
				PlayerOwner.ServerChangeSkin(SkinName);
				PreferredSkin = SkinName;
				PlayerOwner.UpdateURL("Skin="$SkinName);
	
				PlayerOwner.ChangeTeam(string(PlayerOwner.Skin));
				TeamName = PlayerOwner.TeamName;
				PlayerOwner.UpdateURL("Team="$string(PlayerOwner.Skin));
			}
		}		

		MenuValues[2] = TeamName;
		MenuValues[3] = string(Skin);
		MenuValues[4] = string(Mesh);

		if ( MenuValues[3] == "None" )
		{
*/
			SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins.Green", 1);
		
			NewSkin = texture(DynamicLoadObject(SkinName, class'Texture'));
			
			if ( NewSkin != None )
			{
				Skin = NewSkin;
				PreferredSkin = SkinName;
//				PlayerOwner.UpdateURL("Skin="$SkinName);
	
				PlayerOwner.ChangeTeam(string(Skin));
				TeamName = string(Skin);		
//				PlayerOwner.UpdateURL("Team="$string(Skin));
			}
			
			MenuValues[2] = TeamName;
			MenuValues[3] = string(Mesh);
//			MenuValues[4] = string(Mesh);			
		}
		else
		{
			MenuValues[2] = TeamName;
			MenuValues[3] = string(Mesh);
//			MenuValues[4] = string(Mesh);			
		}
	}
	else
	{
		MenuValues[3] = "";
//		MenuValues[4] = "";
	}

	MenuValues[5] = "";
	KDrawChangeList(Canvas, 160, 140);

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

defaultproperties
{
     MenuLength=2
     HelpMessage(1)="HIT ENTER TO TYPE IN YOUR NAME."
     HelpMessage(2)="CHANGE YOUR TEAM USING THE LEFT AND RIGHT ARROW KEYS."
     MenuList(1)="NAME:"
     MenuList(2)="TEAM:"
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
