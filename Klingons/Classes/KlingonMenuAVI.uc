//=============================================================================
// KlingonMenuAVI.
//=============================================================================
class KlingonMenuAVI expands KlingonMenu
	localized;

var() localized string[30] AVIList[32];
var   bool bSetUp;
var   int CurPos;
var() texture Arrow[4];
var   bool	 HasProcessed;
var   int 	 ShowMsg;

var() localized string[64] Info1;
var() localized string[64] Info2;
var bool IsMPOk;


function SetUpMenu()
{
	bSetup = true;
	CurPos = 0;
	Selection = 1;
	if ( KlingonPlayer(PlayerOwner).LogBook != None )
		MenuLength = KlingonPlayer(PlayerOwner).LogBook.AVIIndex+2;
//	MenuLength = 30;
//	KlingonPlayer(PlayerOwner).LogBook.AVIIndex = 30;
	HasProcessed = false;
	ShowMsg = 0;
	IsMPOk = true;
	
	// Shut down the music
	PlayerOwner.ClientSetMusic( None, 0, 255, MTRAN_Instant );
	Log ("AVI Index: " $ MenuLength );
}


function Menu ExitMenu()
{
	PlayerOwner.ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );	
	Super.ExitMenu();
}


function MenuProcessInput( byte KeyNum, byte ActionNum )
{
	if ( KeyNum == EInputKey.IK_Up )
	{
		PlayerOwner.PlaySound(MenuSnd[5],,2.0);
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
		
	if ( Selection > 24 )
		CurPos = 24;
	else if ( Selection > 12 )
		CurPos = 12;
	else 
		CurPos = 0;
}


function bool ProcessSelection()
{
	local Menu ChildMenu;
	local string[32] prstrq;

	if ( HasProcessed == true ) 
		return true;
		
	ChildMenu = None;

	if ( IsMPOk == false )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay != "intro.avi N" ) && ( prstrq != "mpgameplay" ) )
		{
			IsMPOk = false;
			ShowMsg = 1;	
			return true;
		}
		else if ( ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay == "intro.avi N" ) && ( prstrq != "mpinstall" ) )
		{
			IsMPOk = false;
			ShowMsg = 2;	
			return true;
		}
	}
		
	if ( ( ( MenuLength <= 2 ) && ( Selection < 2 ) ) && ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay != "intro.avi N" ) )
	{
		if ( IsMPOk == false )
		{
			prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
				
			if ( prstrq == "mpgameplay" )
			{
				IsMPOk = true;
			}
			else 
			{
				IsMPOk = false;
				ShowMsg = 1;	
				return true;
			}
		}
	
		HasProcessed = true;
		PlayerOwner.ConsoleCommand( "playavi brief0102.avi Y None N None N None N None N" );
		if ( KlingonPlayer(Owner).LogBook != None )
		{
			KlingonPlayer(Owner).LogBook.ResetAVI();
			KlingonPlayer(Owner).LogBook.AVIIndex++;
			KlingonPlayer(Owner).LogBook.CurrentAVI = "brief0102.avi";
		}
		HasProcessed = false;
		return true;
	}

	if ( ( Selection == 1 ) && ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay != "intro.avi N" ) )
	{
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( prstrq == "mpgameplay" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			ShowMsg = 1;	
			return true;
		}
	
		HasProcessed = true;
		log ( "CurrentAVI: "$ KlingonPlayer(PlayerOwner).LogBook.CurrentAVI );
		if ( ( KlingonPlayer(PlayerOwner).LogBook.CurrentAVI != "None" ) 
			 && ( KlingonPlayer(PlayerOwner).LogBook.CurrentAVI != "" ) )
			PlayerOwner.ConsoleCommand( "playavi "$ KlingonPlayer(PlayerOwner).LogBook.CurrentAVI $" Y None N None N None N None N" );
		HasProcessed = false;
	}
	else if ( Selection == 2 )
	{
/*	
		prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
			
		if ( prstrq == "mpinstall" )
		{
			IsMPOk = true;
		}
		else 
		{
			IsMPOk = false;
			ShowMsg = 2;
			KlingonPlayer(PlayerOwner).LogBook.AVIToPlay = "intro.avi N";
			return true;
		}
	
		HasProcessed = true;
		log ( "CurrentAVI: "$ KlingonPlayer(PlayerOwner).LogBook.CurrentAVI );
			PlayerOwner.ConsoleCommand( "playavi intro.avi N None N None N None N None N" );
		HasProcessed = false;
*/
	}
	else 
	{
		if ( KlingonPlayer(PlayerOwner).LogBook != None )
		{
			KlingonPlayer(PlayerOwner).LogBook.SetAVIToPlay (Selection-1);
			if ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay != "None" )
			{		
				if ( KlingonPlayer(PlayerOwner).LogBook.AVIToPlay == "intro.avi N" )
				{
					prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
							
					if ( prstrq == "mpinstall" )
					{
						IsMPOk = true;
					}
					else 
					{
						IsMPOk = false;
						ShowMsg = 2;	
						return true;
					}
					
					HasProcessed = true;						
					PlayerOwner.ConsoleCommand( "playavi "$ KlingonPlayer(PlayerOwner).LogBook.AVIToPlay $" None N None N None N" );
				}
				else
				{
					prstrq = PlayerOwner.ConsoleCommandResult( "prsq" );
							
					if ( prstrq == "mpgameplay" )
					{
						IsMPOk = true;
					}
					else 
					{
						IsMPOk = false;
						ShowMsg = 1;	
						return true;
					}

					HasProcessed = true;
					PlayerOwner.ConsoleCommand( "playavi "$ KlingonPlayer(PlayerOwner).LogBook.AVIToPlay $" None N None N None N" );
				}
			}
		}
		HasProcessed = false;
	}

	if ( ChildMenu != None )
	{
		HUD(Owner).MainMenu = ChildMenu;
		ChildMenu.ParentMenu = self;
		ChildMenu.PlayerOwner = PlayerOwner;
	}
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
		
	for (i=0; i <= KlingonPlayer(PlayerOwner).LogBook.AVIIndex+1; i++ )
	{
		if ( ( i >= CurPos ) && ( i < (CurPos + 12) ) )
		{
			j = i - CurPos;
			SetFontBrightness(Canvas, (i == Selection - 1) );
			Canvas.SetPos(StartX  * XRatio, ( StartY  * YRatio ) + Spacing * j);
			Canvas.DrawText(AVIList[i], false);
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
	else if ( CurPos == 24 )
	{
	   	Canvas.SetPos(64 * XRatio, (315 * YRatio) );
	    Canvas.DrawTile(Arrow[1], TU, TV, 0, 0, Arrow[0].UClamp, Arrow[0].VClamp );
	   	Canvas.SetPos(64 * XRatio, (339 * YRatio) );
	    Canvas.DrawTile(Arrow[2], TU, TV, 0, 0, Arrow[3].UClamp, Arrow[3].VClamp );
	}
	else
	{
	   	Canvas.SetPos(64 * XRatio, (315 * YRatio) );
	    Canvas.DrawTile(Arrow[1], TU, TV, 0, 0, Arrow[0].UClamp, Arrow[0].VClamp );
	   	Canvas.SetPos(64 * XRatio, (339 * YRatio) );
	    Canvas.DrawTile(Arrow[2], TU, TV, 0, 0, Arrow[2].UClamp, Arrow[3].VClamp );
	}	
	
	Canvas.Style = 1;

	if ( ShowMsg == 0 )
		KDrawList( Canvas, 95, 0);
	else
		KDrawMsg ( Canvas, ShowMsg );
}



function KDrawMsg(canvas Canvas, int CurMsg )
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

	if ( CurMsg == 1 )
		Canvas.DrawText(Info1, False);
	else if ( CurMsg == 2 )
		Canvas.DrawText(Info2, False);

	SetFontBrightness(Canvas, false);
	
	Canvas.ClipX = OldClipX;
	Canvas.ClipY = OldClipY;
}

defaultproperties
{
     AVIList(0)="Replay last Briefing"
     AVIList(2)="M01: THE BATTLE OF TONG'VE"
     AVIList(3)="M02: THE ASSASSINS"
     AVIList(4)="JOURNEY TO RURE PENTHE"
     AVIList(5)="M03: RURE PENTHE"
     AVIList(6)="M05: THE PRISON"
     AVIList(7)="M06: THE WARDEN"
     AVIList(8)="M07A: QUALOR II"
     AVIList(9)="ORBITING QUALOR II"
     AVIList(10)="M08: THE SPACE STATION"
     AVIList(11)="BOARDING THE STATION"
     AVIList(12)="M09B: THRESS PARTII"
     AVIList(13)="M10: THE KOR-VAN"
     AVIList(14)="JOURNEY TO THE KOR-VAN"
     AVIList(15)="M11: RENDEZVOUS"
     AVIList(16)="BOARDING THE FEK'LHR"
     AVIList(17)="M12: THE FEK'LHR"
     AVIList(18)="FEK'LHR BOOM SEPERATION"
     AVIList(19)="M13: KRAX"
     AVIList(20)="APPROACHING PRAXIS"
     AVIList(21)="M14: PRAXIS"
     AVIList(22)="M15: THE CREW COMPLEX"
     AVIList(23)="M16: THE REACTOR"
     AVIList(24)="M17: THE WAREHOUSE"
     AVIList(25)="LURSA AND BE'TOR ARRIVE"
     AVIList(26)="M18A: THE SISTERS"
     AVIList(27)="BETRAYAL"
     AVIList(28)="M19: VENGEANCE"
     AVIList(29)="VICTORY"
     AVIList(30)=" "
     AVIList(31)=" "
     Arrow(0)=Texture'KlingonHUD.HUDBack.S-up1'
     Arrow(1)=Texture'KlingonHUD.HUDBack.S-up2'
     Arrow(2)=Texture'KlingonHUD.HUDBack.S-down1'
     Arrow(3)=Texture'KlingonHUD.HUDBack.S-down2'
     Info1="Insert the Gameplay CD-ROM and press ENTER"
     Info2="Insert the Install CD-ROM and press ENTER"
     MenuTitle="MOVIES"
}
