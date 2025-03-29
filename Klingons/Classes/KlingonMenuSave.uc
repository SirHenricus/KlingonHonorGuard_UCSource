//=============================================================================
// KlingonMenuSave.
//=============================================================================
class KlingonMenuSave expands KlingonMenuSlot
	localized
	config;

var() localized string[64] Info1;
var() localized string[128] CantSave;
var   bool bResponse;
var() localized string[32] YesSelString;
var() localized string[32] NoSelString;
var	  bool OverWrite;

function BeginPlay()
{
	local int i;

	Super.BeginPlay();
	For (i=0; i<9; i++ )
		if (SlotNames[i] ~= EmptyString )
		{
			Selection = i + 1;
			break;
		}
		
	OverWrite = false;
}


function bool ProcessYes()
{
	bResponse = true;
	return true;
}

function bool ProcessNo()
{
	bResponse = false;
	return true;
}

function bool ProcessLeft()
{
	bResponse = !bResponse;
	return true;
}

function bool ProcessRight()
{
	bResponse = !bResponse;
	return true;
}


function bool ProcessSelection()
{
	if ( PlayerOwner.Health <= 0 )
		return true;

	if ( ( SlotNames[Selection - 1] != EmptyString ) && ( OverWrite == false ) )
	{
		OverWrite = true;
		return true;
	}

	if ( ( SlotNames[Selection - 1] == EmptyString ) || ( ( OverWrite == true ) && ( bResponse == true ) ) )
	{
		if ( Level.Minute < 10 )
			SlotNames[Selection - 1] = (Level.Title$" "$Level.Hour$"\:0"$Level.Minute$" "$Level.Year$Level.Month$Level.Day);
		else
			SlotNames[Selection - 1] = (Level.Title$" "$Level.Hour$"\:"$Level.Minute$" "$Level.Year$Level.Month$Level.Day);
	
		if ( Level.NetMode != NM_Standalone )
			SlotNames[Selection - 1] = "Net:"$SlotNames[Selection - 1];
		SaveConfig();
		bExitAllMenus = true;
		PlayerOwner.ClientMessage(" ");
		
		if ((Level.Title == "M04: RURE PENTHE") || (Level.Title == "M20C: BLOOD OATH"))
		{
			bExitAllMenus = true;
			PlayerOwner.setpause( false);
			PlayerOwner.bShowMenu = false;
			PlayerOwner.MyHud.MainMenu.lifespan = 1.0; 
			PlayerOwner.MyHud.MainMenu = none;
			lifespan = 1.0;		// hack to delete object after save game is completed	
			ParentMenu.lifespan = 1.0;
			PlayerOwner.bDelayedCommand = false;
			PlayerOwner.ConsoleCommand("SaveGame "$(Selection - 1));
		}
		else
		{
			PlayerOwner.bDelayedCommand = true;
			PlayerOwner.DelayedCommand = "SaveGame "$(Selection - 1);
		}
	}

	OverWrite = false;

	return true;
}

function DrawMenu(canvas Canvas)
{

	if ( PlayerOwner.Health <= 0 )
	{
		MenuTitle = CantSave;
		DrawTitle(Canvas);
		return;
	}

	DrawBackGround(Canvas, false);

	if ( OverWrite == false )
		DrawSlots(Canvas, 320, 0);	
	else
		KDrawMsg( Canvas );
}


function KDrawMsg(canvas Canvas )
{
	local int StartX;
	local int StartY;
	local int DrawY;
	local int ClipX;
	local int ClipY;
	local int OldClipX;
	local int OldClipY;

	OldClipX = Canvas.ClipX;
	OldClipY = Canvas.ClipY;

	StartX = 120 * XRatio;
	StartY = 150 * YRatio;
	ClipY = 128 * YRatio;
	
	Canvas.bCenter = false;
	
	if ( Canvas.ClipX > 800 )
		ClipX = (Canvas.ClipX - (370 * XRatio)) * XRatio;
	else if ( Canvas.ClipX == 800 )
		ClipX = 532;
	else
		ClipX = (Canvas.ClipX - (200 * XRatio)) * XRatio;
		
	Canvas.SetOrigin( StartX, StartY );
	Canvas.SetClip(ClipX, ClipY);
	Canvas.SetPos(0,0);
	Canvas.Style = 1;
	SetFontBrightness(Canvas, true);	

	if ( OldClipY >= 400 )
		Canvas.Font = Font'hMRedFont';
	else
		Canvas.Font = Font'hSRedFont';

	Canvas.DrawText(Info1 $ " " $ bResponse, False);
	
	SetFontBrightness(Canvas, false);
	
	Canvas.ClipX = OldClipX;
	Canvas.ClipY = OldClipY;
}

defaultproperties
{
     Info1="overwrite save game ?"
     CantSave="YOU HAVE ENTERED STO VO KOR"
     YesSelString="YES"
     NoSelString="NO"
     MenuTitle="SAVE GAME"
}
