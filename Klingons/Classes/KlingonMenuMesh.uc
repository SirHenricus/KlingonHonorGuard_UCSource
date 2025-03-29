//=============================================================================
// KlingonMenuMesh.
//=============================================================================
class KlingonMenuMesh expands KlingonMenuPlayer
	config
	localized;

var config string[32] PlayerClasses[16];
var config int NumPlayerClasses;
var int PlayerClassNum;
var string[128] StartMap;
var config byte SinglePlayerMesh[16];
var bool SinglePlayerOnly;
var string[64] ClassString;
var texture OldSkin;
var mesh    OldMesh;


function Menu ExitMenu()
{
	PlayerOwner.Skin = OldSkin; 
	PlayerOwner.Mesh = OldMesh;
	Super.ExitMenu();
}


function PostBeginPlay()
{
	Super.PostBeginPlay();

	if ( class'GameInfo'.Default.bShareware )
		NumPlayerClasses = 2;
		
	Selection = 4;
}
	
function SaveConfigs()
{
	PlayerOwner.SaveConfig();
	SaveConfig();
}

function bool ProcessSelection()
{
	local int i, p;

	if( selection == 4 )
	{
		SetOwner(RealOwner);
		bExitAllMenus = true;
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
						
		StartMap = StartMap
					$"?Class="$ClassString
					$"?Skin="$PreferredSkin
					$"?Name="$PlayerOwner.PlayerName
					$"?Team="$PlayerOwner.TeamName
					$"?Rate="$PlayerOwner.NetSpeed;

		SaveConfigs();
		PlayerOwner.ClientTravel(StartMap, TRAVEL_Absolute, false);
	}
	else
		Super.ProcessSelection();
	return true;
}

function bool ProcessLeft()
{
	local string[64] SkinName;
	local texture NewSkin;

	if ( selection == 3 )
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
	else if ( Selection == 2 )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), -1);
		if ( SkinName != "" )
		{
			if ( Mesh == PlayerOwner.Mesh )
			{
				PlayerOwner.ServerChangeSkin(SkinName);
				PreferredSkin = SkinName;

				PlayerOwner.ChangeTeam(string(PlayerOwner.Skin));			
			}
			else
			{
				NewSkin = texture(DynamicLoadObject(string(Mesh)$"Skins."$SkinName, class'Texture'));
				if ( NewSkin != None )
				{
					Skin = NewSkin;
					PreferredSkin = SkinName;

					PlayerOwner.ChangeTeam(string(Skin));
				}
			}
		}
	}
	else
		Super.ProcessLeft();
	return true;
}

function bool ProcessRight()
{
	local string[64] SkinName;
	local texture NewSkin;

	if ( selection == 3 )
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
	else if ( Selection == 2 )
	{
		SkinName = GetNextSkin(string(Mesh), string(Mesh)$"Skins."$string(Skin), 1);
		if ( SkinName != "" )
		{
			if ( Mesh == PlayerOwner.Mesh )
			{
				PlayerOwner.ServerChangeSkin(SkinName);
				PreferredSkin = SkinName;

				PlayerOwner.ChangeTeam(string(PlayerOwner.Skin));			
			}
			else
			{
				NewSkin = texture(DynamicLoadObject(string(Mesh)$"Skins."$SkinName, class'Texture'));
				if ( NewSkin != None )
				{
					Skin = NewSkin;
					PreferredSkin = SkinName;

					PlayerOwner.ChangeTeam(string(Skin));			
				}
			}
		}
	}
	else 
		Super.ProcessRight();
	return true;
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

		PreferredSkin="";
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

function LoadAllMeshes()
{
	local int i;

	for ( i=0; i<NumPlayerClasses; i++ )
		DynamicLoadObject(PlayerClasses[i], class'Class');
}

function SetUpDisplay()
{
	local int i;

	Super.SetUpDisplay();

	OldSkin = PlayerOwner.Skin; 
	OldMesh = PlayerOwner.Mesh;
	
	for ( i=0; i<NumPlayerClasses; i++ )
		if ( PlayerClasses[i] ~= ("Klingons."$PlayerOwner.Class) )
		{
			PlayerClassNum = i;
			break;
		}
		
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
}

defaultproperties
{
     PlayerClasses(0)="Klingons.DMFemale"
     PlayerClasses(1)="Klingons.DMMale"
     PlayerClasses(2)="Klingons.DMVacSuit"
     NumPlayerClasses=2
     SinglePlayerMesh(0)=1
     SinglePlayerMesh(1)=1
     Selection=5
     MenuLength=4
     HelpMessage(3)="CHANGE YOUR CLASS USING THE LEFT AND RIGHT ARROW KEYS."
     HelpMessage(4)="PRESS ENTER TO START GAME."
     MenuList(3)="CLASS:"
     MenuList(4)="START GAME"
}
