//=============================================================================
// KlingonMenuKeyboard.
//=============================================================================
class KlingonMenuKeyboard expands KlingonMenu
	localized;

var string[64] MenuValues1[24];
var string[64] MenuValues2[24];
var string[64] AliasNames[24];
var string[255] PendingCommands[30];
var int Pending;
var() localized string[16] OrString;
var bool bSetUp;
var int CurPos;
var() texture Arrow[4];


function SaveConfigs()
{
	ProcessPending();
}


function ProcessPending()
{
	local int i;

	for ( i=0; i<Pending; i++ )
		PlayerOwner.ConsoleCommand(PendingCommands[i]);
		
	Pending = 0;
}

function AddPending(string[255] newCommand)
{
	PendingCommands[Pending] = newCommand;
	Pending++;
	if ( Pending == 30 )
		ProcessPending();
}
	
function SetUpMenu()
{
	local int i, j, k, pos;
	local string[32] KeyName;
	local string[32] Alias;

	bSetup = true;
	CurPos = 0;
	
	for ( i=0; i<255; i++ )
	{
		KeyName = PlayerOwner.ConsoleCommandResult ( "KEYNAME "$i );
		if ( KeyName != "" )
		{	
			Alias = PlayerOwner.ConsoleCommandResult( "KEYBINDING "$KeyName );
			if ( Alias != "" )
			{
				pos = InStr(Alias, " " );
				if ( pos != -1 )
					Alias = Left(Alias, pos);
				for ( j=1; j < MenuLength; j++ )
				{
					if ( AliasNames[j] == Alias )
					{
						if ( MenuValues1[j] == "" )
							MenuValues1[j] = KeyName;
						else if ( MenuValues2[j] == "" )
							MenuValues2[j] = KeyName;
					}
				}
			}
		}
	}
}


function MenuProcessInput( byte KeyNum, byte ActionNum )
{
	if ( KeyNum == EInputKey.IK_Up )
	{
		PlayerOwner.PlaySound(MenuSnd[5]);
		Selection--;
		if ( Selection < 1 )
			Selection = MenuLength;
	}
	else if ( KeyNum == EInputKey.IK_Down )
	{
		PlayerOwner.PlaySound(MenuSnd[5]);
		Selection++;
		if ( Selection > MenuLength )
			Selection = 1;
	}
		
	if ( ( KeyNum != EInputKey.IK_Up ) && ( KeyNum != EInputKey.IK_Down ) )
		Super.MenuProcessInput( KeyNum, ActionNum );
		
	if ( Selection > 12 )
		CurPos = 12;
	else 
		CurPos = 0;
}


function ProcessMenuKey( int KeyNo, string[32] KeyName )
{
	local int i;

	if ( (KeyName == "") || (KeyName == "Escape")  
		|| ((KeyNo >= 0x70 ) && (KeyNo <= 0x79)) ) //function keys
		return;

	// make sure no overlapping
	for ( i=1; i<20; i++ )
	{
		if ( MenuValues2[i] == KeyName )
			MenuValues2[i] = "";
		if ( MenuValues1[i] == KeyName )
		{
			MenuValues1[i] = MenuValues2[i];
			MenuValues2[i] = "";
		}
	}
	if ( MenuValues1[Selection] != "_" )
		MenuValues2[Selection] = MenuValues1[Selection];
	else if ( MenuValues2[Selection] == "_" )
		MenuValues2[Selection] = "";

	MenuValues1[Selection] = KeyName;
	AddPending("SET Input "$KeyName$" "$AliasNames[Selection]);
}

function ProcessMenuEscape()
{
	ProcessPending();
}

function ProcessMenuUpdate( coerce string[64] InputString );

function bool ProcessSelection()
{
	local int i;

	if ( Selection == MenuLength )
	{
		Pending = 0;
		PlayerOwner.ResetKeyboard();
		for ( i=0; i<24; i++ )
		{
			MenuValues1[i] = "";
			MenuValues2[i] = "";
		}
		SetupMenu();
		return true;
	}
	if ( MenuValues2[Selection] != "" )
	{
		AddPending( "SET Input "$MenuValues2[Selection]$" ");
		AddPending( "SET Input "$MenuValues1[Selection]$" ");
		MenuValues1[Selection] = "_";
		MenuValues2[Selection] = "";
	}
	else
		MenuValues2[Selection] = "_";
		
	PlayerOwner.Player.Console.GotoState('KeyMenuing');
	return true;
}


function KDrawList( canvas Canvas, int StartX, int StartY)
{
	local int i;
	local int Spacing;
	local int j;

	Spacing = Clamp(0.04 * Canvas.ClipY, 11 * XRatio, 32  * YRatio);

	if ( StartX == 0 )
		StartX = Max(40, 160);
	
	if ( StartY == 0 )
		StartY = Max(60, 110);

	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMRedFont';
	else
		Canvas.Font = Font'hSRedFont';

	for (i=0; i < MenuLength; i++ )
	{
		if ( ( i >= CurPos ) && ( i < (CurPos + 12) ) )
		{
			j = i - CurPos;
			SetFontBrightness(Canvas, (i == Selection - 1) );
			Canvas.SetPos(StartX  * XRatio, ( StartY  * YRatio ) + Spacing * j);
			Canvas.DrawText(MenuList[i + 1], false);
		}
	}

	Canvas.DrawColor = Canvas.Default.DrawColor;
}


function KDrawChangeList(canvas Canvas, int StartX, int StartY)
{
	local int i;
	local int Spacing;
	local int j;

	Spacing = Clamp(0.04 * Canvas.ClipY, 11 * XRatio, 32 * YRatio);

	if ( StartX == 0 )
		StartX = Max(85, 310);
			
	if ( StartY == 0 )
		StartY = Max(60, 110);
			
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMGreenFont';
	else
		Canvas.Font = Font'hSGreenFont';

	for (i=0; i < MenuLength; i++ )
	{
		if ( ( i >= CurPos ) && ( i < (CurPos + 12) ) )
		{
			j = i - CurPos; 
			SetFontBrightness(Canvas, (i == Selection - 1) );
			Canvas.SetPos(StartX  * XRatio, ( StartY  * YRatio ) + Spacing * j);
			Canvas.DrawText(MenuValues[i + 1], false);
		}
	}

	Canvas.DrawColor = Canvas.Default.DrawColor;
}


function DrawMenu(canvas Canvas)
{
	local int k;
	local int TU;
	local int TV;
	
	DrawBackGround(Canvas, false);

	if ( !bSetup )
		SetupMenu();
	
	TU = 32 * XRatio;
	TV = 32 * YRatio;
	
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = True;	

	Canvas.Style = 2;
		
	if ( CurPos == 12 )
    {
	   	Canvas.SetPos(64 * XRatio, 315 * YRatio );
	    Canvas.DrawTile(Arrow[0], TU, TV, 0, 0, Arrow[0].UClamp, Arrow[0].VClamp );
	   	Canvas.SetPos(64 * XRatio, 339 * YRatio );
	    Canvas.DrawTile(Arrow[3], TU, TV, 0, 0, Arrow[2].UClamp, Arrow[2].VClamp );
	}
	else
	{
	   	Canvas.SetPos(64 * XRatio, (315 * YRatio) );
	    Canvas.DrawTile(Arrow[1], TU, TV, 0, 0, Arrow[0].UClamp, Arrow[0].VClamp );
	   	Canvas.SetPos(64 * XRatio, (339 * YRatio) );
	    Canvas.DrawTile(Arrow[2], TU, TV, 0, 0, Arrow[3].UClamp, Arrow[3].VClamp );
	}
	
	Canvas.Style = 1;

	KDrawList( Canvas, 95, 0);

	for (k=0; k < MenuLength; k++ )
	{
		if ( MenuValues2[k] == "" )
			MenuValues[k] = MenuValues1[k];
		else
			MenuValues[k] = MenuValues1[k]$OrString$MenuValues2[k];
	}

	KDrawChangeList(Canvas, 310, 0);
}

defaultproperties
{
     AliasNames(1)="Fire"
     AliasNames(2)="AltFire"
     AliasNames(3)="MoveForward"
     AliasNames(4)="MoveBackward"
     AliasNames(5)="TurnLeft"
     AliasNames(6)="TurnRight"
     AliasNames(7)="StrafeLeft"
     AliasNames(8)="StrafeRight"
     AliasNames(9)="Jump"
     AliasNames(10)="Duck"
     AliasNames(11)="Look"
     AliasNames(12)="InventoryActivate"
     AliasNames(13)="InventoryNext"
     AliasNames(14)="InventoryPrevious"
     AliasNames(15)="LookUp"
     AliasNames(16)="LookDown"
     AliasNames(17)="CenterView"
     AliasNames(18)="Walking"
     AliasNames(19)="Strafe"
     AliasNames(20)="NextWeapon"
     OrString=" or "
     Arrow(0)=Texture'KlingonHUD.HUDBack.S-up1'
     Arrow(1)=Texture'KlingonHUD.HUDBack.S-up2'
     Arrow(2)=Texture'KlingonHUD.HUDBack.S-down1'
     Arrow(3)=Texture'KlingonHUD.HUDBack.S-down2'
     MenuLength=21
     HelpMessage(1)=""
     MenuList(1)="FIRE"
     MenuList(2)="ALTERNATE FIRE"
     MenuList(3)="MOVE FORWARD"
     MenuList(4)="MOVE BACKWARD"
     MenuList(5)="TURN LEFT"
     MenuList(6)="TURN RIGHT"
     MenuList(7)="STRAFE LEFT"
     MenuList(8)="STRAFE RIGHT"
     MenuList(9)="JUMP/UP"
     MenuList(10)="CROUCH/DOWN"
     MenuList(11)="MOUSE LOOK"
     MenuList(12)="ACTIVATE ITEM"
     MenuList(13)="NEXT ITEM"
     MenuList(14)="PREVIOUS ITEM"
     MenuList(15)="LOOK UP"
     MenuList(16)="LOOK DOWN"
     MenuList(17)="CENTER VIEW"
     MenuList(18)="WALK"
     MenuList(19)="STRAFE"
     MenuList(20)="NEXT WEAPON"
     MenuList(21)="RESET TO DEFAULTS"
     MenuTitle="CONTROLS"
}
