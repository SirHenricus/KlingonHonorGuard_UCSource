//=============================================================================
// KlingonMenuFavorites.
//=============================================================================
class KlingonMenuFavorites expands KlingonMenu
	config
	localized;

var config string[128] Favorites[12]; //Menu List has aliases
var config string[128] Aliases[12]; //Menu List has aliases
var() localized string[32] EditList[2];
var bool	bEditMode;
var bool	bEditAlias;
var bool	bEditFavorite;
var string[128] OldFavorite;
var string[128] OldAlias;
var int EditSelection;
var() localized string[32] EmptyString;

function SaveConfigs()
{
	SaveConfig();
}	

function ProcessMenuInput( coerce string[64] InputString )
{
	if ( bEditAlias )
	{
		Aliases[EditSelection] = InputString;
		bEditAlias = false;
		Favorites[EditSelection] = "_";
		bEditFavorite = true;
	}
	else
	{
		bEditFavorite = false;
		bEditMode = false;
		Selection = EditSelection + 1;
		Favorites[EditSelection] = InputString;
	}
}

function ProcessMenuEscape()
{
	if ( bEditAlias )
		Aliases[EditSelection] = OldAlias;
	else
		Favorites[EditSelection] = OldFavorite; 
}

function ProcessMenuUpdate( coerce string[64] InputString )
{
	if ( bEditAlias )
		Aliases[EditSelection] = (InputString$"_");
	else
		Favorites[EditSelection] = (InputString$"_");
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Aliases[Selection-1] ~= EmptyString )
		return false;

	if ( Aliases[Selection-1] != "....." )
	{
		SaveConfigs();
		ChildMenu = spawn(class'KlingonMenuMesh', owner);
		if ( ChildMenu != None )
		{
			KlingonMenuMesh(ChildMenu).StartMap = Favorites[Selection - 1];
			HUD(Owner).MainMenu = ChildMenu;
			ChildMenu.ParentMenu = self;
			ChildMenu.PlayerOwner = PlayerOwner;
		}
	}
	return true;
}

function bool ProcessLeft()
{
	bEditMode = true;
	bEditAlias = true;
	OldFavorite = Favorites[Selection-1];
	OldAlias = Aliases[Selection-1];
	Favorites[Selection-1] = "";
	Aliases[Selection-1] = "_";	
	EditSelection = Selection - 1;	
	PlayerOwner.Player.Console.GotoState('MenuTyping');
}

function bool ProcessRight()
{
	ProcessLeft();
}

function DrawMenu(canvas Canvas)
{
	local int StartX, StartY, Spacing, i;

	DrawBackGround(Canvas, false);

	if ( !bEditMode )
	{		
		MenuList[4] = "";
		MenuList[5] = "";	
		
		for ( i=0; i<12; i++ )
		{
			if ( Aliases[i] != "" )
			{
				MenuList[i+1] = Aliases[i];
			}
		}

		KDrawList( Canvas, 320, 0);
		KDrawHelpPanel(Canvas);
	}
	else
	{
		for ( i=0; i<13; i++ )
			MenuList[i] = "";

		if ( bEditFavorite )
		{
			bEditFavorite = false;
			PlayerOwner.Player.Console.GotoState('MenuTyping');
		}

		MenuList[4] = EditList[0];
		MenuValues[4] = Aliases[EditSelection];
		
		MenuList[5] = EditList[1];		
		MenuValues[5] = Favorites[EditSelection];
		
		KDrawList( Canvas, 0, 0);
		KDrawChangeList(Canvas, 350, 0);
	}
}

defaultproperties
{
     Favorites(0)="..Empty.."
     Favorites(1)="..Empty.."
     Favorites(2)="..Empty.."
     Favorites(3)="..Empty.."
     Favorites(4)="..Empty.."
     Favorites(5)="..Empty.."
     Favorites(6)="..Empty.."
     Favorites(7)="..Empty.."
     Favorites(8)="..Empty.."
     Aliases(0)="..Empty.."
     Aliases(1)="..Empty.."
     Aliases(2)="..Empty.."
     Aliases(3)="..Empty.."
     Aliases(4)="..Empty.."
     Aliases(5)="..Empty.."
     Aliases(6)="..Empty.."
     Aliases(7)="..Empty.."
     Aliases(8)="..Empty.."
     Aliases(9)="..Empty.."
     Aliases(10)="..Empty.."
     Aliases(11)="..Empty.."
     EditList(0)="Name for Server:"
     EditList(1)="Address:"
     EmptyString="..Empty.."
     MenuLength=12
     HelpMessage(1)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(2)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(3)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(4)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(5)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(6)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(7)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(8)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(9)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(10)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(11)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     HelpMessage(12)="HIT ENTER TO GO TO THIS SERVER.  HIT THE RIGHT ARROW KEY TO EDIT THIS ENTRY."
     MenuTitle="FAVORITES"
}
