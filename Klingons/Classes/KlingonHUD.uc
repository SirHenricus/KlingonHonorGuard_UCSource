//=============================================================================
// KlingonHUD.
//=============================================================================
class KlingonHUD expands HUD
config;

#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD

#exec Font Import File=Textures\Lhfnt-g1.pcx Name=hLGreenFont
#exec Font Import File=Textures\Lhfnt-o1.pcx Name=hLOrangeFont
#exec Font Import File=Textures\Lhfnt-r1.pcx Name=hLRedFont
#exec Font Import File=Textures\Lhfnt-w1.pcx Name=hLWhiteFont
#exec Font Import File=Textures\Lhfnt-y1.pcx Name=hLYellowFont
#exec Font Import File=Textures\Mhfnt-g1.pcx Name=hMGreenFont
#exec Font Import File=Textures\Mhfnt-o1.pcx Name=hMOrangeFont
#exec Font Import File=Textures\Mhfnt-r1.pcx Name=hMRedFont
#exec Font Import File=Textures\Mhfnt-w1.pcx Name=hMWhiteFont
#exec Font Import File=Textures\Mhfnt-y1.pcx Name=hMYellowFont
#exec Font Import File=Textures\Shfnt-g1.pcx Name=hSGreenFont
#exec Font Import File=Textures\Shfnt-o1.pcx Name=hSOrangeFont
#exec Font Import File=Textures\Shfnt-r1.pcx Name=hSRedFont
#exec Font Import File=Textures\Shfnt-w1.pcx Name=hSWhiteFont
#exec Font Import File=Textures\Shfnt-y1.pcx Name=hSYellowFont

var globalconfig int   DMHudMode;
var globalconfig bool  OverlayOn;
var globalconfig bool  MusicOn;
var int ShowKid;

// Texture Storage
var() texture hbr_bord[8];
var() texture hbl_bord[8];
var() texture htr_bord[8];
var() texture htl_bord[8];
var() texture h_dmt_bord[8];
var() texture h_dmb_bord[8];

var() texture hbl_genr[8];
var() texture hbr_genr[8];
var() texture htl_genr[8];
var() texture htr_genr[8];
var() texture h_dmt_genr[8];
var() texture h_dmb_genr[8];

var() texture hl_weap[8];
var() texture hr_weap[8];
var() texture h_weapicon[30];
var() texture h_invicon[3];
var() texture h_armback[6];
var() texture h_crosshair[10];

var() texture h_invbord[8];
var() texture h_combord[12];
var() texture h_timer[12];
var() texture h_dm_icon[2];
var() bool bAllowMenu;

var bool		bDrawSplash;
var bool 		bDrawLegal;
var bool 		bDrawBlack;

var() int 		SplashTime;
var() int		LegalTime;

var() texture	GameSplash[4];
var() texture	GameLegal[4];

// Screen Scaling
var   int    	XScr;
var   int    	YScr;
var   float  	XRatio;
var   float  	YRatio;
var   int 		bordTU;
var   int 		bordTV;
var   int 		genrTU;
var   int 		genrTV;
var   int  		weapoff[10]; 
var   int  		invoff[6];

// Inventory
var   inventory	SelectedItem;
var   inventory	LastSelected;
var   bool 		DrawInvBar;
var   int	    InvTime;

var   inventory ArmorOn;
var   bool 		CameraOn;
var   bool      GoggleOn;

// Hud Mode represent HUD state 0-disabled 1-displaystatic 2-BuildUp 3-BreakDown 4-Flash
var   int 		WeapMode;
var   int 		AmmoMode;
var	  int 		InvMode;
var   int 		HealthMode;
var   int 		ComMode;
var   int       TimerMode;
var   float		TimeLeft;
var   int		Count;
var   bool 	    ComBlink;

var   int		TimerStage;
var   int		ComStage;
var   int		InvStage;
var   int		HealthStage;
var   int		AmmoStage;
var   int		WeapStage;

var   int 		DMMode;
var   int		DMStage;
var   int 		DMNumPlayers;
var   int 		DMPlayerPos;
var   int 		DMFragLimit;

var() sound		MiniBuild;

var	  int		OldHUDMode;		// used in HideHUD() function - LB
var	  int		OldDMHUDMode;	// used in HideHUD() function - LB

var vector  PlayerTempLocation;
var rotator OldViewRotation;
var rotator OldRotation;
var bool	HudInitialized;

simulated function Rescale(canvas canvas)
{
	XScr = Canvas.ClipX;
	YScr = Canvas.ClipY;
	
	XRatio = XScr * 0.0015625;
	YRatio = YScr * 0.00208333333333333;
	
	weapoff[0] = 89 * XRatio;
	weapoff[1] = 145 * XRatio;
	weapoff[2] = 188 * XRatio;
	weapoff[3] = 230 * XRatio;
	weapoff[4] = 274 * XRatio;
	weapoff[5] = 317 * XRatio;
	weapoff[6] = 361 * XRatio;
	weapoff[7] = 412 * XRatio;
	weapoff[8] = 446 * XRatio;
	weapoff[9] = 488 * XRatio;

	invoff[0] = 59 * YRatio;
	invoff[1] = 99 * YRatio;
	invoff[2] = 141 * YRatio;

	bordTU = htl_bord[4].UClamp * XRatio;
	bordTV = htl_bord[4].VClamp * YRatio;
	genrTU = htl_genr[4].UClamp * XRatio;
	genrTV = htl_genr[4].VClamp * YRatio;
}


simulated function PostBeginPlay( )
{	
	if ( ( Level.Title == "KLINGON" ) && ( PlayerPawn(Owner).ConsoleCommandResult( "GetSplash" ) == "false" ) )
	{
		bAllowMenu = false;
		bDrawSplash = true;
		PlayerPawn(Owner).ConsoleCommandResult( "SetSplash" );
	}
	
}


simulated function BeginPlay()
{
	XScr = 0;
	YScr = 0;
	ComMode = 1;		// Initial startup is static -LB
	ComBlink = false;
	InvMode = 1;
	WeapMode = 1;
	AmmoMode = 1;
	HealthMode = 1;
	DMMode = 0;
	TimerMode = 0;
//	SetHUDMode (int(PlayerPawn(Owner).ConsoleCommandResult("get ini:Klingons.KlingonHUD HudMode ")));
//	SetDMHudMode(int(PlayerPawn(Owner).ConsoleCommandResult("get ini:Klingons.KlingonHUD DMHudMode ")));
	ArmorOn = None;
	CameraOn = false;
	GoggleOn = false;
//	SetOverlay(True);
	DrawInvBar = false;
	LastSelected = SelectedItem;
	SelectedItem = None;
	ShowKid = 0;
	SetTimer(0.1,True);
	bAllowMenu	= true;
}


simulated function Timer()
{
	if ( bDrawSplash == true )
	{
		SplashTime--;
		if ( SplashTime <= 0 )
		{
			bDrawSplash = false;
			bDrawLegal = true;
		}
	}
	else if ( bDrawLegal == true )
	{
		LegalTime--;
		if ( LegalTime <= 0 )
		{
			bDrawSplash = false;
			bDrawLegal = false;
			bAllowMenu = true;
		}
	}

	InvTime--;
	if ( InvTime == 0 )
	{
		DrawInvBar = false;
		LastSelected = None;
	}
	
	TimerStage++;
	if (TimerStage == 8 ) TimerStage = 0;

	ComStage++;
	if (ComStage == 8 ) ComStage = 0;

	InvStage++;
	if (InvStage == 8 ) InvStage = 0;

	HealthStage++;
	if (HealthStage == 8 ) HealthStage = 0;

	AmmoStage++;
	if (AmmoStage == 8 ) AmmoStage = 0;

	WeapStage++;
	if (WeapStage == 8 ) WeapStage = 0;

	DMStage++;
	if (DMStage == 8 ) DMStage = 0;
}


simulated function SetOverlay(bool state)
{
	OverlayOn = state;
}


simulated function BlackScreen(bool state)
{
	bDrawBlack = state;	
}


simulated function EnterSetupMenu ( )
{
	if (Level.NetMode == NM_StandAlone) 
	{
		OldRotation = PlayerPawn(Owner).Rotation;
		OldViewRotation = PlayerPawn(Owner).ViewRotation;
		PlayerTempLocation = PlayerPawn(Owner).Location;
		PlayerPawn(Owner).SetLocation( FindPlayerStart().Location );
	}
}


simulated function ExitSetupMenu ( )
{
	if (Level.NetMode == NM_StandAlone)
	{
		PlayerPawn(Owner).SetRotation (OldRotation); 
		PlayerPawn(Owner).ViewRotation = OldViewRotation;
		PlayerPawn(Owner).SetLocation (PlayerTempLocation);
	}
}


simulated function AllowMenu ( bool AM )
{
	bAllowMenu = AM;
}

simulated function ChangeHud(int d)
{
	local int TempMode;
		
	TempMode = HudMode + d;
	if ( TempMode>5 ) TempMode = 1;
	else if ( TempMode < 1 ) TempMode = 5;
	
	PlayerPawn(Owner).PlaySound(MiniBuild,,2.0);
	
	SetHUDMode(TempMode);
}

simulated function ChangeDMHud(int d)
{
	local int TempMode;
	
	TempMode = DMHudMode + d;
	if ( TempMode>5 ) TempMode = 1;
	else if ( TempMode < 1 ) TempMode = 5;
	
	SetDMHudMode(TempMode);
}

// added by Les for ingame cutscene HUD hiding
simulated function SetDMHUDMode(int d)
{
	DMHudMode=d;
	if (DMHudMode < 1 || DMHudMode > 5) {
		DMHudMode=1;
	}
}

simulated function SetHUDMode(int d)
{
	HudMode=d;
	if (HudMode < 1 || HudMode > 5) {
		HudMode=1;
	}
	switch ( HudMode )
	{
		case 1 :
				if ( ComMode    != 1 ) ComMode    = 2;
				if ( InvMode    != 1 ) InvMode    = 2;
				if ( WeapMode   != 1 ) WeapMode   = 2;
				if ( AmmoMode   != 1 ) AmmoMode   = 2;
				if ( HealthMode != 1 ) HealthMode = 2;
				break;
		case 2 :
				if ( ComMode    != 0 ) ComMode    = 3;
				if ( InvMode    != 0 ) InvMode    = 3;			
				if ( WeapMode   != 1 ) WeapMode   = 2;
				if ( AmmoMode   != 1 ) AmmoMode   = 2;
				if ( HealthMode != 1 ) HealthMode = 2;
				break;
		case 3 :
				if ( ComMode    != 0 ) ComMode    = 3;
				if ( InvMode    != 0 ) InvMode    = 3;			
				if ( WeapMode   != 0 ) WeapMode   = 3;
				if ( AmmoMode   != 1 ) AmmoMode   = 2;
				if ( HealthMode != 1 ) HealthMode = 2;
				break;
		case 4 :
				if ( ComMode    != 0 ) ComMode    = 3;
				if ( InvMode    != 0 ) InvMode    = 3;			
				if ( WeapMode   != 0 ) WeapMode   = 3;
				if ( AmmoMode   != 0 ) AmmoMode   = 3;
				if ( HealthMode != 1 ) HealthMode = 2;
				break;
		case 5 : 
				if ( ComMode    != 0 ) ComMode    = 3;
				if ( InvMode    != 0 ) InvMode    = 3;			
				if ( WeapMode   != 0 ) WeapMode   = 3;
				if ( AmmoMode   != 0 ) AmmoMode   = 3;
				if ( HealthMode != 0 ) HealthMode = 3;
				break;
	}
}


simulated function SetNumPlayers(int NumP)
{
	DMNumPlayers=NumP;
}

simulated function SetPlayerPos(int PPos)
{
	DMPlayerPos=PPos;
}

simulated function SetTimeLimit(int TLimit)
{
	TimeLeft=TLimit;
}

simulated function SetFragLimit(int FLimit)
{
	DMFragLimit=FLimit;
}


simulated function HideHUD()
{
	OldHUDMode=HudMode;
	SetHUDMode(5);

	OldDMHUDMode=DMHudMode;
	SetDMHUDMode(5);
}

simulated function ShowHUD()
{
	if (OldHUDMode > 0 && OldHUDMode < 5) {
		SetHUDMode(OldHUDMode);
	}

	if (OldDMHUDMode > 0 && OldDMHUDMode < 5) {
		SetDMHUDMode(OldDMHUDMode);
	}
}


simulated function CameraLook(bool IsCameraLook)
{
	CameraOn = IsCameraLook;
}


simulated function GoggleLook(bool IsGoggleLook)
{
	GoggleOn = IsGoggleLook;
}


simulated function ChangeCrosshair(int d)
{
	Crosshair = Crosshair + d;
	if ( Crosshair>10 ) Crosshair=0;
	else if ( Crosshair < 0 ) Crosshair = 10;
}


simulated function CreateMenu()
{
	if ( PlayerPawn(Owner).bSpecialMenu && (PlayerPawn(Owner).SpecialMenu != None) )
	{
		MainMenu = Spawn(PlayerPawn(Owner).SpecialMenu, self);
		PlayerPawn(Owner).bSpecialMenu = false;
	}
	
	if ( MainMenu == None )
		MainMenu = Spawn(MainMenuType, self);
		
	if ( MainMenu == None )
	{
		PlayerPawn(Owner).bShowMenu = false;
		Level.bPlayersOnly = false;
		return;
	}
	else
	{
		MainMenu.PlayerOwner = PlayerPawn(Owner);
		MainMenu.PlayEnterSound();
	}
}

simulated function DrawBlack ( canvas Canvas )
{
	local int StartX;
	local int StartY;		
	local int TU;
	local int TV;
	local int i;
	
	Canvas.DrawColor.r = 0;
	Canvas.DrawColor.g = 0;
	Canvas.DrawColor.b = 0;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 1;
	
	Canvas.SetPos(0,0);
	Canvas.DrawTile( GameSplash[0], Canvas.ClipX, Canvas.ClipY, 0, 0, GameSplash[0].UClamp, GameSplash[0].VClamp );

	Canvas.bNoSmooth = True;	
	
	Canvas.Style = 1;
}



simulated function DrawSplash ( canvas Canvas )
{
	local int StartX;
	local int StartY;		
	local int TU;
	local int TV;
	local int i;
	
	XRatio = Canvas.ClipX * 0.0015625;
	YRatio = Canvas.ClipY * 0.0020833333333;
	
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 1;
	
	if ( bDrawSplash == true )	
	{
		TU = 320 * XRatio;
		TV = 330 * YRatio;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( GameSplash[0], TU, TV, 0, 0, GameSplash[0].UClamp, GameSplash[0].VClamp );
		Canvas.DrawTile( GameSplash[1], TU, TV, 0, 0, GameSplash[1].UClamp, GameSplash[1].VClamp );

		Canvas.SetPos(0,TV);
		TU = 320 * XRatio;
		TV = 150 * YRatio;
		Canvas.DrawTile( GameSplash[2], TU, TV, 0, 0, GameSplash[2].UClamp, GameSplash[2].VClamp/2 );
		Canvas.DrawTile( GameSplash[3], TU, TV, 0, 0, GameSplash[3].UClamp, GameSplash[3].VClamp/2 );
	}
	else if ( bDrawLegal == true )
	{
		TU = 320 * XRatio;
		TV = 330 * YRatio;
		Canvas.SetPos(0,0);
		Canvas.DrawTile( GameLegal[0], TU, TV, 0, 0, GameLegal[i].UClamp, GameLegal[0].VClamp );
		Canvas.DrawTile( GameLegal[1], TU, TV, 0, 0, GameLegal[i].UClamp, GameLegal[1].VClamp );
		Canvas.SetPos(0,TV);
		TU = 320 * XRatio;
		TV = 150 * YRatio;
		Canvas.DrawTile( GameLegal[2], TU, TV, 0, 0, GameLegal[i].UClamp, GameLegal[2].VClamp/2 );
		Canvas.DrawTile( GameLegal[3], TU, TV, 0, 0, GameLegal[i].UClamp, GameLegal[3].VClamp/2 );
	}

	Canvas.bNoSmooth = True;	
	
	Canvas.Style = 1;
}


simulated function HUDSetup(canvas canvas)
{
	// Setup the way we want to draw all HUD elements
	Canvas.Reset();
	Canvas.SpaceX=0;
	Canvas.bNoSmooth = False;	
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.Font = Font'hLRedFont';
	
	if ( ( XScr != Canvas.ClipX ) || ( YScr != Canvas.ClipY ) )
		Rescale(Canvas);

	if (HudInitialized == false)
	{
		PlayerPawn(Owner).ClientSetMusic(Level.Song,Level.SongSection,Level.CdTrack,MTRAN_Fade);
		HudInitialized = true;
	}

}


simulated function DrawCrossHair( canvas Canvas, int StartX, int StartY )
{
	local PlayerPawn P;

	if (Crosshair>9) Return;
	Canvas.SetPos(StartX, StartY );
	Canvas.Style = 2;
	P = PlayerPawn(Owner);	
	
	if ( (P.Weapon != None) && !P.bShowMenu && P.Weapon.bLockedOn && P.Weapon.bPointing) 
		Canvas.DrawIcon(h_crosshair[9], 1.0);
	else
		Canvas.DrawIcon(h_crosshair[Crosshair], 1.0);

	Canvas.Style = 1;	
}


simulated function PostRender( canvas Canvas )
{
	HUDSetup(canvas);
	
	if ( bDrawSplash == true || bDrawLegal == true )
	{
		DrawSplash ( Canvas );
		return;
	}

	if ( PlayerPawn(Owner) != None )
	{
		if ( ( PlayerPawn(Owner).bShowMenu ) && ( bAllowMenu == true ) )
		{
			if ( MainMenu == None )
				CreateMenu();
			if ( MainMenu != None )
				MainMenu.DrawMenu(Canvas);
			return;
		}

		if ( PlayerPawn(Owner).bShowScores )
		{
			if ( (PlayerPawn(Owner).Scoring == None) && (PlayerPawn(Owner).ScoringType != None) )
				PlayerPawn(Owner).Scoring = Spawn(PlayerPawn(Owner).ScoringType, PlayerPawn(Owner));
			if ( PlayerPawn(Owner).Scoring != None )
			{ 
				PlayerPawn(Owner).Scoring.ShowScores(Canvas);
				return;
			}
		}
		else if ( (PlayerPawn(Owner).Weapon != None) && (Level.LevelAction == LEVACT_None) )
			DrawCrossHair(Canvas, 0.5 * Canvas.ClipX - 8, 0.5 * Canvas.ClipY - 8);
	}

	if (Level.LevelAction != LEVACT_None) {
		return;
	}

	if ( ( LastSelected != None ) && ( Pawn(Owner).SelectedItem != LastSelected ) )
	{
		DrawInvBar = true;
		InvTime = 20;
	}

	SelectedItem = Pawn(Owner).SelectedItem;
	LastSelected = SelectedItem;
	
	if ( (ArmorOn != None) || ( CameraOn == true ) || ( GoggleOn == true ) )
		DrawHudBack (Canvas);

	// Draw Health & Armor
	if ((HudMode<5) || ( 0 != HealthMode) )
	{
		DrawHealth(Canvas);
		DrawArmor(Canvas);
	}
		
	// Draw Ammo
	if ((HudMode<4) || ( 0 != AmmoMode) )	  
		DrawAmmo(Canvas);
	
	//Draw Weapon Display
	if ((HudMode<3) || ( 0 != WeapMode) )	  
		DrawWeapDisp(Canvas);

	// Draw Communication Display
	if ( ( HudMode<2 ) || ( 0 != ComMode) )
		DrawCom(Canvas);
	
	// Draw Current Inventory
	if ( ( (HudMode<2) || ( 0 != InvMode) ) || ( DrawInvBar == true ) )
		DrawCurInv(Canvas);

	// Draw Inventory Buttons
	if (DrawInvBar)
	{
//		DrawInvButtons(Canvas);
		DrawInventory(Canvas, False);
	}
/*		
	// Draw deathmatch HUD
	if ( ( ( DMHudMode<5 ) || ( 0 != DMMode) ) && Level.NetMode != NM_Standalone ) 
		DrawDMHUD (Canvas);	
*/	
	// Draw Timer Countdown
	if ( 0 != TimerMode )  
		DrawTimer(Canvas);
}

/*
simulated function DrawDMHUD(Canvas Canvas)
{
	local int X1;
	local int X2;
	local int X3;
	local int X4;
	local int Y1;
	local int Y2;
	local int Y3;
	local int Y4;
	local int Y5;
	local int Y6;
	local int TU;
	local int TV;
	local int FGY;
	local int MFY;
	local int PLY;
	local int NPY;

	if ( (Level.NetMode != NM_Standalone) && !Level.Game.IsA('DeathMatchGame') )
		return;

	Canvas.Style = 2;
	X1 = 576 * XRatio;
	X2 = 608 * XRatio;
	X3 = 612 * XRatio;
	X4 = 615 * XRatio;

	switch ( DMHudMode )
	{
		case 1 :
					Y1 = 123 * YRatio; // a
					Y2 = 147 * YRatio; // b
					Y3 = 151 * YRatio; // e
					Y4 = 325 * YRatio; // d	
					Y5 = 240 * YRatio; // c
					Y6 = 245 * YRatio; // f
					break;
		case 2 :
					Y1 = 53 * YRatio;
					Y2 = 77 * YRatio;
					Y3 = 91 * YRatio;
					Y4 = 395 * YRatio;	
					Y5 = 310 * YRatio;
					Y6 = 315 * YRatio;
					break;
		case 3 :
					Y1 = 53 * YRatio;
					Y2 = 77 * YRatio;
					Y3 = 91 * YRatio;
					Y4 = 255 * YRatio; 	
					Y5 = 170 * YRatio; 
					Y6 = 175 * YRatio; 
					break;
		case 4 :
					Y1 = 193 * YRatio; 
					Y2 = 217 * YRatio; 
					Y3 = 221 * YRatio; 
					Y4 = 395 * YRatio; 	
					Y5 = 310 * YRatio; 
					Y6 = 315 * YRatio; 
					break;
	}
			
	TU = h_dmt_genr[4].UClamp * XRatio;
	TV = h_dmt_genr[4].VClamp * YRatio;
					
	Canvas.CurX = X1;
	Canvas.CurY = Y1;
			
	Canvas.DrawTile(h_dmt_genr[4], TU, TV, 0, 0, h_dmt_genr[4].UClamp, h_dmt_genr[4].VClamp);

	TU = h_dmt_bord[4].UClamp * XRatio;
	TV = h_dmt_bord[4].VClamp * YRatio;
	
	Canvas.CurX = X1;
	Canvas.CurY = Y2;
		
	Canvas.DrawTile(h_dmt_bord[4], TU, TV, 0, 0, h_dmt_bord[4].UClamp, h_dmt_bord[4].VClamp);

	TU = h_dm_icon[0].UClamp * XRatio;
	TV = h_dm_icon[0].VClamp * YRatio;

	Canvas.CurX = X2;
	Canvas.CurY = Y3;
	Canvas.DrawTile(h_dm_icon[0], TU, TV, 0, 0, h_dm_icon[0].UClamp, h_dm_icon[0].VClamp);

/*					
	TU = h_dmb_genr[4].UClamp * XRatio;
	TV = h_dmb_genr[4].VClamp * YRatio;
				
	Canvas.CurX = X1;
	Canvas.CurY = Y4;
			
	Canvas.DrawTile(h_dmb_genr[4], TU, TV, 0, 0, h_dmb_genr[4].UClamp, h_dmb_genr[4].VClamp);

	TU = h_dmb_bord[4].UClamp * XRatio;
	TV = h_dmb_bord[4].VClamp * YRatio;
		
	Canvas.CurX = X1;
	Canvas.CurY = Y5;		
	Canvas.DrawTile(h_dmb_bord[4], TU, TV, 0, 0, h_dmb_bord[4].UClamp, h_dmb_bord[4].VClamp);

	TU = h_dm_icon[1].UClamp * XRatio;
	TV = h_dm_icon[1].VClamp * YRatio;

	Canvas.CurX = X2;
	Canvas.CurY = Y6;
	Canvas.DrawTile(h_dm_icon[1], TU, TV, 0, 0, h_dm_icon[1].UClamp, h_dm_icon[1].VClamp);
*/

	FGY = ( Y3 + TV); // Score
//	MFY = (Y3 + (57 * YRatio)) * YRatio; // Max Score
//	PLY = (Y6 + (25 * YRatio)) * YRatio; // Place
//	NPY = (Y6 + (55 * YRatio)) * YRatio; // NumPlayers
	
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMWhiteFont';	
	else
		Canvas.Font = Font'hSWhiteFont';	

	Canvas.CurX = X3;
	Canvas.CurY = FGY;
	Canvas.DrawText(int(Pawn(Owner).Score),False);

/*
	if ( DMFragLimit != 0 )
	{
		Canvas.CurX = X4;
		Canvas.CurY = FGY+(14*YRatio);
		Canvas.DrawText("/",False);
		Canvas.CurX = X3;
		Canvas.CurY = MFY;
		Canvas.DrawText(DMFragLimit,False);
	}
*/

/*
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMWhiteFont';	
	else
		Canvas.Font = Font'hSWhiteFont';	

	Canvas.CurX = X3;
	Canvas.CurY = PLY;
	Canvas.DrawText(DMPlayerPos,False);
	Canvas.CurX = X4;
	Canvas.CurY = PLY+(14*YRatio);
	Canvas.DrawText("/",False);
	Canvas.CurX = X3;
	Canvas.CurY = NPY;
	Canvas.DrawText(DMNumPlayers,False);
*/

	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}
*/

simulated function DrawHUDBack(Canvas Canvas)
{
	local int TU;
	local int TV;
	local int X;
	local int Y;

	if ( PlayerPawn(Owner).bShowMenu || PlayerPawn(Owner).bBehindView )
	{
		return;
	}

	if (KlingonPlayer(Owner) != None)
	{
		if (KlingonPlayer(Owner).PlayerCamActor != None
			|| KlingonPlayer(Owner).OverheadCamActor != None
			|| KlingonPlayer(Owner).BehindCamActor != None)
		{
			return;
		}
	}

	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.CurY = 0;
	Canvas.CurX = 0;		

	Canvas.Style = 2;
	
	TV = 480 * YRatio;

	if ( CameraOn == true )
	{
		TU = 480 * XRatio;
		Canvas.DrawTile(h_armback[4], TU, TV, 0, 0, h_armback[4].UClamp, h_armback[4].VClamp);
		TU = 160 * XRatio;
		Canvas.DrawTile(h_armback[5], TU, TV, 0, 0, h_armback[5].UClamp/2.976744, h_armback[5].VClamp);
	}
	else if ( OverlayOn == true )
	{	
		if ( ( ArmorOn.IsA('CombatArmor') ) || ( GoggleOn == true ) )
		{
			TU = 480 * XRatio;
			Canvas.DrawTile(h_armback[0], TU, TV, 0, 0, h_armback[0].UClamp, h_armback[0].VClamp);
			TU = 160 * XRatio;
			Canvas.DrawTile(h_armback[1], TU, TV, 0, 0, h_armback[1].UClamp/2.976744, h_armback[1].VClamp);
		}
		else if (ArmorOn.IsA('VacSuit'))
		{
			TU = 480 * XRatio;
			Canvas.DrawTile(h_armback[2], TU, TV, 0, 0, h_armback[2].UClamp, h_armback[2].VClamp);
			TU = 160 * XRatio;
			Canvas.DrawTile(h_armback[3], TU, TV, 0, 0, h_armback[3].UClamp/2.976744, h_armback[3].VClamp);
		}
	}
	
	Canvas.Style = 1;
}


simulated function DrawInventory(Canvas Canvas, bool bDrawOne)
{
	local bool bGotNext, bGotPrev, bGotSelected;
	local inventory Inv,Prev, Next;

	if ( Owner.Inventory==None) Return;

	Canvas.Style = 2;

	bGotSelected = False;
	bGotNext = False;
	bGotPrev = False;
	Prev = None;
	Next = None;
	SelectedItem = Pawn(Owner).SelectedItem;

	for ( Inv=Owner.Inventory; Inv!=None; Inv=Inv.Inventory )
	{
		if ( !bDrawOne ) // if drawing more than one inventory, find next and previous items
		{
			if ( Inv == SelectedItem )
				bGotSelected = True;
			else if ( Inv.bActivatable )
			{
				if ( bGotSelected )
				{
					if ( !bGotNext )
					{
						Next = Inv;
						bGotNext = true;
					}
					else if ( !bGotPrev )
						Prev = Inv;
				}
				else
				{
					if ( Next == None )
						Next = Prev;
					Prev = Inv;
					bGotPrev = True;
				}
			}
		}
	}

	if ( SelectedItem != None ) 
	{	
		Count++;
		if (Count>20) Count=0;
				
//		if (Prev!=None) 
//		{
			DrawInvIcon(Canvas, 0, Prev);				
//		}
		if ( SelectedItem.Icon != None )	
		{
			if ( (Next==None) && (Prev==None) && !bDrawOne) 
				DrawInvIcon(Canvas, 2, SelectedItem);				
			else 
			{
				DrawInvIcon(Canvas, 1, SelectedItem);
			}
		}
//		if (Next!=None)
			DrawInvIcon(Canvas, 2, Next);				
	}
	
	Canvas.Style = 1;
}


simulated function DrawInvIcon(Canvas Canvas, int InvPos, Inventory Item)
{
	local int TU;
	local int TV;
	local int X;
	local int Y;

	Canvas.Style = 2;

	Y = invoff[InvPos];
	X = 529 * XRatio;		

	Canvas.CurY = Y;
	Canvas.CurX = X;		
	
	TU = h_invbord[1].UClamp * XRatio;
	TV = h_invbord[1].VClamp * YRatio;	

	if ( ( Item == SelectedItem ) && ( Item != None ) )
		Canvas.DrawTile(h_invbord[7], TU, TV, 0, 0, h_invbord[7].UClamp, h_invbord[7].VClamp);	
	else
		Canvas.DrawTile(h_invbord[4], TU, TV, 0, 0, h_invbord[4].UClamp, h_invbord[4].VClamp);
	
	if ( Item != None && Item.Icon != None )
	{
//		Canvas.CurY = Y + ( 5 * YRatio);
//		Canvas.CurX = X + ( 5 * XRatio);		
		Canvas.CurY = Y;
		Canvas.CurX = X;		
		TU = Item.Icon.UClamp * XRatio;
		TV = Item.Icon.VClamp * YRatio;
		Canvas.DrawTile(Item.Icon, TU, TV, 0, 0, Item.Icon.UClamp, Item.Icon.VClamp);
	}
	
	Canvas.Style = 1;
}


/*
simulated function DrawInvButtons(Canvas Canvas)
{
	local int X;
	local int Y;
	local int TU;
	local int TV;
	local int blinkval;
	
	Canvas.Style = 2;

	X = 529 * XRatio;

	switch ( InvMode )
	{
		case 1 :
				Canvas.CurX = X;
				Canvas.CurY = invoff[0];
				Canvas.DrawTile(h_invbord[4], TU, TV, 0, 0, h_invbord[4].UClamp, h_invbord[4].VClamp);

				Canvas.CurY = invoff[1];
				Canvas.DrawTile(h_invbord[4], TU, TV, 0, 0, h_invbord[4].UClamp, h_invbord[4].VClamp);

				Canvas.CurY = invoff[2];
				Canvas.DrawTile(h_invbord[4], TU, TV, 0, 0, h_invbord[4].UClamp, h_invbord[4].VClamp);
				break;
		case 2:
				if ( InvStage <= 3 )
				{
					Canvas.CurX = X;
					Canvas.CurY = invoff[0];
					Canvas.DrawTile(h_invbord[InvStage], TU, TV, 0, 0, h_invbord[InvStage].UClamp, h_invbord[InvStage].VClamp);

					Canvas.CurY = invoff[1];
					Canvas.DrawTile(h_invbord[InvStage], TU, TV, 0, 0, h_invbord[InvStage].UClamp, h_invbord[InvStage].VClamp);

					Canvas.CurY = invoff[2];
					Canvas.DrawTile(h_invbord[InvStage], TU, TV, 0, 0, h_invbord[InvStage].UClamp, h_invbord[InvStage].VClamp);
				}
				
				if ( InvStage == 3 )
					InvMode = 1;
				break;
		case 3:	
				if ( InvStage <= 3 )
				{
					Canvas.CurX = X;
					Canvas.CurY = invoff[0];
					Canvas.DrawTile(h_invbord[3-InvStage], TU, TV, 0, 0, h_invbord[3-InvStage].UClamp, h_invbord[3-InvStage].VClamp);

					Canvas.CurY = invoff[1];
					Canvas.DrawTile(h_invbord[3-InvStage], TU, TV, 0, 0, h_invbord[3-InvStage].UClamp, h_invbord[3-InvStage].VClamp);

					Canvas.CurY = invoff[2];
					Canvas.DrawTile(h_invbord[3-InvStage], TU, TV, 0, 0, h_invbord[3-InvStage].UClamp, h_invbord[3-InvStage].VClamp);
				}
				
				if ( InvStage == 3 )
					InvMode = 0;
				break;
		case 4: 		
				if ( InvStage <= 2 )
				{				
					TU = h_invbord[5+InvStage].UClamp * XRatio;
					TV = h_invbord[5+InvStage].VClamp * YRatio;	
				
					Canvas.CurX = X;
					Canvas.CurY = invoff[0];
					Canvas.DrawTile(h_invbord[5+InvStage], TU, TV, 0, 0, h_invbord[5+InvStage].UClamp, h_invbord[5+InvStage].VClamp);

					Canvas.CurY = invoff[1];
					Canvas.DrawTile(h_invbord[5+InvStage], TU, TV, 0, 0, h_invbord[5+InvStage].UClamp, h_invbord[5+InvStage].VClamp);

					Canvas.CurY = invoff[2];
					Canvas.DrawTile(h_invbord[5+InvStage], TU, TV, 0, 0, h_invbord[5+InvStage].UClamp, h_invbord[5+InvStage].VClamp);
				}
				else if ( InvStage > 2 )
				{
					switch ( InvStage )
					{
						case 3 :
								blinkval = 3;
								break;
						case 4 :
								blinkval = 1;
								break;
						case 5 :
								blinkval = -1;
								break;
					}

					TU = h_invbord[blinkval+InvStage].UClamp * XRatio;
					TV = h_invbord[blinkval+InvStage].VClamp * YRatio;	
				
					Canvas.CurX = X;
					Canvas.CurY = invoff[0];
					Canvas.DrawTile(h_invbord[blinkval+InvStage], TU, TV, 0, 0, h_invbord[blinkval+InvStage].UClamp, h_invbord[blinkval+InvStage].VClamp);

					Canvas.CurY = invoff[1];
					Canvas.DrawTile(h_invbord[blinkval+InvStage], TU, TV, 0, 0, h_invbord[blinkval+InvStage].UClamp, h_invbord[blinkval+InvStage].VClamp);

					Canvas.CurY = invoff[2];
					Canvas.DrawTile(h_invbord[blinkval+InvStage], TU, TV, 0, 0, h_invbord[blinkval+InvStage].UClamp, h_invbord[blinkval+InvStage].VClamp);
				}
				else
					InvStage = 0;
				break;
	}
	
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}
*/


simulated function DrawCom(Canvas Canvas)
{
	local int X;
	local int Y;
	local int TU;
	local int TV;
	local int blinkval;

	Canvas.Style = 2;
	Y = 0;
	X = 0;

	switch ( ComMode )
	{
		case 1 :		
				if ( ComBlink == true )
					ComMode = 4;

				Canvas.CurY = Y;
				Canvas.CurX = X;	
				Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);
			
				Canvas.CurY = Y;
				Canvas.CurX = X;
				Canvas.DrawTile(htl_bord[4], bordTU, bordTV, 0, 0, htl_bord[4].UClamp, htl_bord[4].VClamp);
			
				Canvas.CurY = 19 * YRatio;
				Canvas.CurX = 31 * XRatio;
				Canvas.DrawTile(h_combord[2], genrTU, genrTV, 0, 0, h_combord[2].UClamp, h_combord[2].VClamp);
				break;
		case 2:
				if ( ComStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[ComStage], genrTU, genrTV, 0, 0, htl_genr[ComStage].UClamp, htl_genr[ComStage].VClamp);
				}
				else
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);

					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[ComStage-4], bordTU, bordTV, 0, 0, htl_bord[ComStage-4].UClamp, htl_bord[ComStage-4].VClamp);
				}
												
				if ( ComStage == 7 )
					ComMode = 1;
				break;
		case 3:	
				if ( ComStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);

					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[3-ComStage], bordTU, bordTV, 0, 0, htl_bord[3-ComStage].UClamp, htl_bord[3-ComStage].VClamp);	
				}
				else
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[7-ComStage], genrTU, genrTV, 0, 0, htl_genr[7-ComStage].UClamp, htl_genr[7-ComStage].VClamp);
				}

				if ( ComStage == 7 )
					ComMode = 0;
				break;
		case 4: 												
				if ( ComBlink == false )
					ComMode = 1;

				Canvas.CurY = Y;
				Canvas.CurX = X;	
				Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);
			
				Canvas.CurY = Y;
				Canvas.CurX = X;
				Canvas.DrawTile(htl_bord[4], bordTU, bordTV, 0, 0, htl_bord[4].UClamp, htl_bord[4].VClamp);

				Canvas.CurY = Y;
				Canvas.CurX = X;
				Canvas.DrawTile(h_combord[3+ComStage], bordTU, bordTV, 0, 0, h_combord[3+ComStage].UClamp, h_combord[3+ComStage].VClamp);
				break;
	}

	if ( ShowKid == 1 )
	{
		KlingonPlayer(Owner).LogBook.AVIIndex = 30;
		if ( h_combord[11] != None )
		{
			Canvas.CurY = 100 * YRatio;
			Canvas.CurX = 100 * XRatio;
			Canvas.DrawTile(h_combord[11], bordTU, bordTV, 0, 0, h_combord[11].UClamp, h_combord[11].VClamp);
		}
	}
		
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


simulated function DrawCurInv(Canvas Canvas)
{
	local int X;
	local int Y;
	local int TU;
	local int TV;
	local int blinkval;

	Canvas.Style = 2;
	
	if ( ( ( ( SelectedItem != None ) && ( SelectedItem.bActive == True ) ) || (HudMode<2) ) 
			   || ( DrawInvBar == true ) )
	{
		if ( InvMode == 0 )
			InvMode = 2;
	}
	else
	{
		if ( InvMode == 1 )
			InvMode = 3;
	}

	Y = 0;
	SelectedItem = Pawn(Owner).SelectedItem;
	
	switch ( InvMode )
	{
		case 1 :
				if ( SelectedItem != None )
				{
					if ( (SelectedItem.Charge <= 20) && ( !SelectedItem.bDisplayableInv ) )
						InvMode = 4;
				}
		
				Canvas.CurY = Y;
				Canvas.CurX = Canvas.ClipX-genrTU;	
				Canvas.DrawTile(htr_genr[4], genrTU, genrTV, 0, 0, htr_genr[4].UClamp, htr_genr[4].VClamp);
			
				Canvas.CurY = Y;
				Canvas.CurX = Canvas.ClipX-bordTU;	
				Canvas.DrawTile(htr_bord[4], bordTU, bordTV, 0, 0, htr_bord[4].UClamp, htr_bord[4].VClamp);
			
				if ( SelectedItem != None && SelectedItem.Icon != None )	
				{
					TU = SelectedItem.Icon.UClamp * XRatio;
					TV = SelectedItem.Icon.VClamp * YRatio;	
					
					Canvas.CurY = 17 * YRatio;
					Canvas.CurX = 529 * XRatio;					
					Canvas.DrawTile(SelectedItem.Icon, TU, TV, 0, 0, SelectedItem.Icon.UClamp, SelectedItem.Icon.VClamp);
			
					if ( !SelectedItem.bDisplayableInv  )
					{
						if ( Canvas.ClipY >= 400 )
							Canvas.Font = Font'hMOrangeFont';
						else
							Canvas.Font = Font'hSOrangeFont';
						
						Canvas.CurY = 34 * YRatio;
						Canvas.CurX = 587 * XRatio;		
						Canvas.DrawText("<",False);
						Canvas.CurY = 34 * YRatio;
						Canvas.DrawText(SelectedItem.Charge,False);
					}
				}
				break;
		case 2:
				if ( InvStage <= 3 )
				{				
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-genrTU;	
					Canvas.DrawTile(htr_genr[InvStage], genrTU, genrTV, 0, 0, htr_genr[InvStage].UClamp, htr_genr[InvStage].VClamp);
				}
				else
				{				
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-genrTU;	
					Canvas.DrawTile(htr_genr[4], genrTU, genrTV, 0, 0, htr_genr[4].UClamp, htr_genr[4].VClamp);
				
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-bordTU;	
					Canvas.DrawTile(htr_bord[InvStage-4], bordTU, bordTV, 0, 0, htr_bord[InvStage-4].UClamp, htr_bord[InvStage-4].VClamp);
				}
												
				if ( InvStage == 7 )
					InvMode = 1;
				break;
		case 3:					
				if ( InvStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-genrTU;	
					Canvas.DrawTile(htr_genr[4], genrTU, genrTV, 0, 0, htr_genr[4].UClamp, htr_genr[4].VClamp);
				
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-bordTU;		
					Canvas.DrawTile(htr_bord[3-InvStage], bordTU, bordTV, 0, 0, htr_bord[3-InvStage].UClamp, htr_bord[3-InvStage].VClamp);				
				}
				else
				{
					Canvas.CurY = Y;
					Canvas.CurX = Canvas.ClipX-genrTU;	
					Canvas.DrawTile(htr_genr[7-InvStage], genrTU, genrTV, 0, 0, htr_genr[7-InvStage].UClamp, htr_genr[7-InvStage].VClamp);
				}

				if ( InvStage == 7 )
					InvMode = 0;
				break;				
		case 4: 
				if ( SelectedItem != None )
				{						
					if ( SelectedItem.Charge > 20 )
						InvMode = 1;

					if ( InvStage <= 2 )
					{				
						Canvas.CurY = Y;
						Canvas.CurX = Canvas.ClipX-genrTU;	
						Canvas.DrawTile(htr_genr[5+InvStage], genrTU, genrTV, 0, 0, htr_genr[5+InvStage].UClamp, htr_genr[5+InvStage].VClamp);
					
						Canvas.CurY = Y;
						Canvas.CurX = Canvas.ClipX-bordTU;
						Canvas.DrawTile(htr_bord[5+InvStage], bordTU, bordTV, 0, 0, htr_bord[5+InvStage].UClamp, htr_bord[5+InvStage].VClamp);
					}
					else if ( InvStage > 2 ) 
					{
						switch ( InvStage )
						{
							case 3 :
									blinkval = 3;
									break;
							case 4 :
									blinkval = 1;
									break;
							case 5 :
									blinkval = -1;
									break;
						}
	
						Canvas.CurY = Y;
						Canvas.CurX = Canvas.ClipX-genrTU;	
						Canvas.DrawTile(htr_genr[blinkval+InvStage], genrTU, genrTV, 0, 0, htr_genr[blinkval+InvStage].UClamp, htr_genr[blinkval+InvStage].VClamp);
					
						Canvas.CurY = Y;
						Canvas.CurX = Canvas.ClipX-bordTU;
						Canvas.DrawTile(htr_bord[blinkval+InvStage], bordTU, bordTV, 0, 0, htr_bord[blinkval+InvStage].UClamp, htr_bord[blinkval+InvStage].VClamp);
					}
									
					if ( SelectedItem != None && SelectedItem.Icon != None )	
					{
						TU = SelectedItem.Icon.UClamp * XRatio;
						TV = SelectedItem.Icon.VClamp * YRatio;	
						
						Canvas.CurY = 20 * YRatio;
						Canvas.CurX = 538 * XRatio;						
						Canvas.DrawTile(SelectedItem.Icon, TU, TV, 0, 0, SelectedItem.Icon.UClamp, SelectedItem.Icon.VClamp);
				
						if ( !SelectedItem.bDisplayableInv  )
						{
							if ( Canvas.ClipY >= 400 )
								Canvas.Font = Font'hMOrangeFont';
							else
								Canvas.Font = Font'hSOrangeFont';
							
							Canvas.CurY = 34 * YRatio;
							Canvas.CurX = 587 * XRatio;		
							Canvas.DrawText("<",False);
							Canvas.CurY = 34 * YRatio;
							Canvas.DrawText(SelectedItem.Charge,False);
						}
					}
				}
				break;
	}

	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}



simulated function DrawHealth(Canvas Canvas)
{
	local int X;
	local int Y;
	local int TU;
	local int TV;
	local int blinkval;

	Canvas.Style = 2;
	X = 0;		

	switch ( HealthMode )
	{
		case 1 :
				if ( ( Pawn(Owner).Health <= 20 ) )
					HealthMode = 4;
		
				Canvas.CurY = Canvas.ClipY-genrTV;
				Canvas.CurX = X;						
				Canvas.DrawTile(hbl_genr[4], genrTU, genrTV, 0, 0, hbl_genr[4].UClamp, hbl_genr[4].VClamp);
			
				Canvas.CurY = (Canvas.ClipY-bordTV)+1;
				Canvas.CurX = X;	
				Canvas.DrawTile(hbl_bord[4], bordTU, bordTV, 0, 0, hbl_bord[4].UClamp, hbl_bord[4].VClamp);
			
				TU = h_invicon[1].UClamp * XRatio;
				TV = h_invicon[1].VClamp * YRatio;
			
				Canvas.CurY = 420 * YRatio;
				Canvas.CurX = X;
				Canvas.DrawTile(h_invicon[1], TU, TV, 0, 0, h_invicon[1].UClamp, h_invicon[1].VClamp);
						
				if ( Canvas.ClipY >= 400 )
				{
					if ( Pawn(Owner).Health >= 65 )
						Canvas.Font = Font'hMGreenFont';
					else if ( Pawn(Owner).Health >= 40 )
						Canvas.Font = Font'hMYellowFont';
					else
						Canvas.Font = Font'hMRedFont';
				}
				else
				{
					if ( Pawn(Owner).Health >= 65 )
						Canvas.Font = Font'hSGreenFont';
					else if ( Pawn(Owner).Health >= 40 )
						Canvas.Font = Font'hSYellowFont';
					else
						Canvas.Font = Font'hSRedFont';
				}
			
				Canvas.CurY = 430 * YRatio;
				Canvas.CurX = 46 * XRatio;
				Canvas.DrawText("<",False);

				Canvas.CurY = 427 * YRatio;
				Canvas.DrawText(Max(0,Pawn(Owner).Health),False);
				break;
		case 2:
				if ( HealthStage <= 3 )
				{
					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[HealthStage], genrTU, genrTV, 0, 0, hbl_genr[HealthStage].UClamp, hbl_genr[HealthStage].VClamp);
				}
				else
				{
					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[4], genrTU, genrTV, 0, 0, hbl_genr[4].UClamp, hbl_genr[4].VClamp);

					Canvas.CurY = (Canvas.ClipY-bordTV)+1;
					Canvas.CurX = X;						
					Canvas.DrawTile(hbl_bord[HealthStage-4], bordTU, bordTV, 0, 0, hbl_bord[HealthStage-4].UClamp, hbl_bord[HealthStage-4].VClamp);
				}
												
				if ( HealthStage == 7 )
					HealthMode = 1;
				break;
		case 3:					
				if ( HealthStage <= 3 )
				{
					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[4], genrTU, genrTV, 0, 0, hbl_genr[4].UClamp, hbl_genr[4].VClamp);
				
					Canvas.CurY = (Canvas.ClipY-bordTV)+1;
					Canvas.CurX = X;						
					Canvas.DrawTile(hbl_bord[3-HealthStage], bordTU, bordTV, 0, 0, hbl_bord[3-HealthStage].UClamp, hbl_bord[3-HealthStage].VClamp);
				}
				else
				{
					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[7-HealthStage], genrTU, genrTV, 0, 0, hbl_genr[7-HealthStage].UClamp, hbl_genr[7-HealthStage].VClamp);
				}

				if ( HealthStage == 7 )
					HealthMode = 0;
				break;				
		case 4: 									
				if ( ( Pawn(Owner).Health > 20 ) )
					HealthMode = 1;

				if ( HealthStage <= 2 )
				{				
					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[5+HealthStage], genrTU, genrTV, 0, 0, hbl_genr[5+HealthStage].UClamp, hbl_genr[5+HealthStage].VClamp);
				
					Canvas.CurY = (Canvas.ClipY-bordTV)+1;
					Canvas.CurX = X;						
					Canvas.DrawTile(hbl_bord[5+HealthStage], bordTU, bordTV, 0, 0, hbl_bord[5+HealthStage].UClamp, hbl_bord[5+HealthStage].VClamp);
				}
				else if ( HealthStage > 2 )
				{
					switch ( HealthStage )
					{
						case 3 :
								blinkval = 3;
								break;
						case 4 :
								blinkval = 1;
								break;
						case 5 :
								blinkval = -1;
								break;
					}

					Canvas.CurY = Canvas.ClipY-genrTV;
					Canvas.CurX = X;							
					Canvas.DrawTile(hbl_genr[blinkval+HealthStage], genrTU, genrTV, 0, 0, hbl_genr[blinkval+HealthStage].UClamp, hbl_genr[blinkval+HealthStage].VClamp);
				
					Canvas.CurY = (Canvas.ClipY-bordTV)+1;
					Canvas.CurX = X;						
					Canvas.DrawTile(hbl_bord[blinkval+HealthStage], bordTU, bordTV, 0, 0, hbl_bord[blinkval+HealthStage].UClamp, hbl_bord[blinkval+HealthStage].VClamp);
				}

				TU = h_invicon[1].UClamp * XRatio;
				TV = h_invicon[1].VClamp * YRatio;
			
				Canvas.CurY = 420 * YRatio;
				Canvas.CurX = X;
				Canvas.DrawTile(h_invicon[1], TU, TV, 0, 0, h_invicon[1].UClamp, h_invicon[1].VClamp);
						
				if ( Canvas.ClipY >= 400 )
				{
					if ( Pawn(Owner).Health >= 65 )
						Canvas.Font = Font'hMGreenFont';
					else if ( Pawn(Owner).Health >= 40 )
						Canvas.Font = Font'hMYellowFont';
					else
						Canvas.Font = Font'hMRedFont';
				}
				else
				{
					if ( Pawn(Owner).Health >= 65 )
						Canvas.Font = Font'hSGreenFont';
					else if ( Pawn(Owner).Health >= 40 )
						Canvas.Font = Font'hSYellowFont';
					else
						Canvas.Font = Font'hSRedFont';
				}
			
				Canvas.CurY = 430 * YRatio;
				Canvas.CurX = 46 * XRatio;
				Canvas.DrawText("<",False);

				Canvas.CurY = 427 * YRatio;
				Canvas.DrawText(Max(0,Pawn(Owner).Health),False);
				break;
	}
		
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


simulated function DrawArmor(Canvas Canvas)
{
	Local int ArmorAmount,CurAbs;
	Local inventory Inv,BestArmor;
	local int X;
	local int Y;

	local int TU;
	local int TV;

	Canvas.Style = 2;

	if ( ( HealthMode == 1 ) || (HealthMode == 4 ) )
	{
		ArmorAmount = 0;
		CurAbs=0;
		BestArmor=None;
		for( Inv=Owner.Inventory; Inv!=None; Inv=Inv.Inventory ) 
		{
			if (Inv.bIsAnArmor) 
			{
				ArmorAmount += Inv.Charge;				
				if (Inv.Charge>0 && Inv.Icon!=None) 
				{
					if (Inv.ArmorAbsorption>CurAbs) 
					{
						CurAbs = Inv.ArmorAbsorption;
						BestArmor = Inv;
					}
				}
			}
		}
		
		if ( BestArmor != None && BestArmor.Icon != None ) 
		{					
			if ( Canvas.ClipY >= 400 )
				Canvas.Font = Font'hMRedFont';
			else
				Canvas.Font = Font'hSRedFont';
	
			Canvas.CurY = 441 * YRatio;
			Canvas.CurX = 54 * XRatio;
			Canvas.DrawText(BestArmor.Charge,False);

			Canvas.CurY = 441 * YRatio;
			Canvas.CurX += 2;
			Canvas.DrawText("<",False);		
	
			TU = BestArmor.Icon.UClamp * XRatio;
			TV = BestArmor.Icon.VClamp * YRatio;
			
			Canvas.CurY = 420 * YRatio;
			Canvas.CurX = 81 * XRatio;
			Canvas.DrawTile(BestArmor.Icon, TU, TV, 0, 0, BestArmor.Icon.UClamp, BestArmor.Icon.VClamp);
		}	
	
		if ( BestArmor != None )
			ArmorOn = BestArmor;
		else
			ArmorOn = None;
	}
	
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


simulated function DrawWeapDisp(Canvas Canvas)
{
	local int X;
	local int Y;
	local int TU;
	local int TV;
	local int TUi;
	local int TVi;
	local inventory Inv;
	local int blinkval;
	
	Canvas.Style = 2;
	TU = hl_weap[4].UClamp * XRatio;
	TV = hl_weap[4].VClamp * YRatio;
	TUi = h_weapicon[0].UClamp * XRatio;
	TVi = h_weapicon[0].VClamp * YRatio;
	Y = Canvas.ClipY-TV;
	X = Canvas.ClipX / 10;
	
	switch ( WeapMode )
	{
		case 1 :			
				Canvas.CurX = X;
				Canvas.CurY = Y;				
				Canvas.DrawTile(hl_weap[4], TU+1, TV, 0, 0, hl_weap[4].UClamp, hl_weap[4].VClamp);
				Canvas.CurX = Canvas.CurX - 1;
				Canvas.DrawTile(hr_weap[4], TU, TV, 0, 0, hr_weap[4].UClamp, hr_weap[4].VClamp);
						
				for ( Inv=Owner.Inventory; Inv!=None; Inv=Inv.Inventory )
				{			
					if ( (Inv.InventoryGroup>0) && (Weapon(Inv)!=None) ) 
					{
						Canvas.CurY = Y;
						Canvas.CurX = weapoff[Inv.InventoryGroup-1];
						
						if (Pawn(Owner).Weapon == Inv) 
							Canvas.DrawTile(h_weapicon[(Inv.InventoryGroup * 3)-1], TUi, TVi, 0, 0, h_weapicon[0].UClamp, h_weapicon[0].VClamp);		
						else
							Canvas.DrawTile(h_weapicon[(Inv.InventoryGroup * 3)-2], TUi, TVi, 0, 0, h_weapicon[0].UClamp, h_weapicon[0].VClamp);				
					}
				}
				break;
		case 2:
				if ( WeapStage <= 3 )
				{				
					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(hl_weap[WeapStage], TU, TV, 0, 0, hl_weap[WeapStage].UClamp, hl_weap[WeapStage].VClamp);
					Canvas.DrawTile(hr_weap[WeapStage], TU, TV, 0, 0, hr_weap[WeapStage].UClamp, hr_weap[WeapStage].VClamp);
				}
				
				if ( WeapStage >= 3 )
					WeapMode = 1;
				break;
		case 3:	
				if ( WeapStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;					
					Canvas.DrawTile(hl_weap[3-WeapStage], TU, TV, 0, 0, hl_weap[3-WeapStage].UClamp, hl_weap[3-WeapStage].VClamp);
					Canvas.DrawTile(hr_weap[3-WeapStage], TU, TV, 0, 0, hr_weap[3-WeapStage].UClamp, hr_weap[3-WeapStage].VClamp);
				}
				
				if ( WeapStage >= 3 )
					WeapMode = 0;
				break;
		case 4: 		
				if ( WeapStage <= 2 )
				{				
					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(hl_weap[5+WeapStage], TU, TV, 0, 0, hl_weap[5+WeapStage].UClamp, hl_weap[5+WeapStage].VClamp);
					Canvas.DrawTile(hr_weap[5+WeapStage], TU, TV, 0, 0, hr_weap[5+WeapStage].UClamp, hr_weap[5+WeapStage].VClamp);
				}
				else if ( WeapStage > 2 )
				{
					switch ( WeapStage )
					{
						case 3 :
								blinkval = 3;
								break;
						case 4 :
								blinkval = 1;
								break;
						case 5 :
								blinkval = -1;
								break;
					}

					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(hl_weap[blinkval+WeapStage], TU, TV, 0, 0, hl_weap[blinkval+WeapStage].UClamp, hl_weap[blinkval+WeapStage].VClamp);
					Canvas.DrawTile(hr_weap[blinkval+WeapStage], TU, TV, 0, 0, hr_weap[blinkval+WeapStage].UClamp, hr_weap[blinkval+WeapStage].VClamp);
				}

				for ( Inv=Owner.Inventory; Inv!=None; Inv=Inv.Inventory )
				{
					if ( (Inv.InventoryGroup>0) && (Weapon(Inv)!=None) ) 
					{
						Canvas.CurY = Y;
						Canvas.CurX = weapoff[Inv.InventoryGroup-1];
						
						if (Pawn(Owner).Weapon == Inv) 
							Canvas.DrawTile(h_weapicon[(Inv.InventoryGroup * 3)-1], TUi, TVi, 0, 0, h_weapicon[0].UClamp, h_weapicon[0].VClamp);		
						else
							Canvas.DrawTile(h_weapicon[(Inv.InventoryGroup * 3)-2], TUi, TVi, 0, 0, h_weapicon[0].UClamp, h_weapicon[0].VClamp);				
					}
				}
				break;
	}
		
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


simulated function DrawAmmo(Canvas Canvas)
{
	local int Xg;
	local int Yg;
	local int Xb;
	local int Yb;
	local int TU;
	local int TV;
	local int Mask;
	local weapon w;
	local int blinkval;
	
	Canvas.Style = 2;
	
	w = Pawn(Owner).Weapon;

	if ( w == None ) return;

	Yg = Canvas.ClipY-genrTV;
	Xg = Canvas.ClipX-genrTU;			
	Yb = Canvas.ClipY-bordTV;
	Xb = Canvas.ClipX-bordTU;			

	switch ( AmmoMode )
	{
		case 1 :
				if ( w.ReloadCount == 0 )
				{
					if ( w.AmmoType.AmmoAmount == 0 )
						AmmoMode = 4;
				}
				else
				{		
					if ( ( w.IsInState('NormalFire')) && ( w.ReloadCount < ( KlingonWeapons(w).AmmoConsumption * 2 ) ) )
						AmmoMode = 4;				
					else if ( ( w.IsInState('AltFiring')) && ( w.ReloadCount < ( KlingonWeapons(w).AltAmmoConsumption * 2) ) )
						AmmoMode = 4;
				}
					
				Canvas.CurY = Yg;
				Canvas.CurX = Xg;				
				Canvas.DrawTile(hbr_genr[4], genrTU, genrTV, 0, 0, hbr_genr[4].UClamp, hbr_genr[4].VClamp);
			
				Canvas.CurY = Yb;
				Canvas.CurX = Xb;
				Canvas.DrawTile(hbr_bord[4], bordTU, bordTV, 0, 0, hbr_bord[4].UClamp, hbr_bord[4].VClamp);
			
				if ( w != None )
				{
					if ( w.AmmoType.Icon != None )
					{
						TU = w.AmmoType.Icon.UClamp * XRatio;
						TV = w.AmmoType.Icon.VClamp * YRatio;
																				
/*
						if ( w.AmmoType.IsA('ChargeCell') ) 
						{
							if ( w.AmmoType.AmmoAmount <= 100 )
								Mask = ((( 100 - w.AmmoType.AmmoAmount) * 0.2) + 14) * YRatio;
							Canvas.CurY = 416 * YRatio;
							Canvas.CurX = 584 * XRatio;		
							Canvas.DrawTile(w.AmmoType.Icon, TU, TV, 0, Mask, w.AmmoType.Icon.UClamp, w.AmmoType.Icon.VClamp);
						}
						else
						{
*/
							Canvas.CurY = 416 * YRatio;
							Canvas.CurX = 584 * XRatio;		
							Canvas.DrawTile(w.AmmoType.Icon, TU, TV, 0, 0, w.AmmoType.Icon.UClamp, w.AmmoType.Icon.VClamp);
//						}
					}
				
				//	if (w.AmmoType.AmmoAmount>=100) Canvas.CurX -= 16;
				//	if (w.AmmoType.AmmoAmount>=10) Canvas.CurX -= 16;
					
					if ( Canvas.ClipY >= 400 )
						Canvas.Font = Font'hMYellowFont';
					else
						Canvas.Font = Font'hSYellowFont';
			
					if ( ( w.Default.ReloadCount != 0 ) && ( w.Default.ReloadCount < w.AmmoType.AmmoAmount ) )
					{
						Canvas.CurY = 430 * YRatio;
						Canvas.CurX = 506 * XRatio;
						Canvas.DrawText(w.ReloadCount,False);
						
						if ( Canvas.ClipY >= 400 )
							Canvas.Font = Font'hMRedFont';
						else
							Canvas.Font = Font'hSRedFont';
			
						Canvas.CurY = 430 * YRatio;
						Canvas.DrawText("/",False);
					}
									
					if ( Canvas.ClipY >= 400 )
						Canvas.Font = Font'hMYellowFont';
					else
						Canvas.Font = Font'hSYellowFont';
				
					Canvas.CurY = 430 * YRatio;
					Canvas.CurX = 552 * XRatio;
					Canvas.DrawText(w.AmmoType.AmmoAmount,False);

					Canvas.CurY = 430 * YRatio;
					Canvas.DrawText("<",False);
				}
				break;
		case 2:
				if ( AmmoStage <= 3 )
				{
					Canvas.CurY = Yg;
					Canvas.CurX = Xg;					
					Canvas.DrawTile(hbr_genr[AmmoStage], genrTU, genrTV, 0, 0, hbr_genr[AmmoStage].UClamp, hbr_genr[AmmoStage].VClamp);
				}
				else
				{
					Canvas.CurY = Yg;
					Canvas.CurX = Xg;					
					Canvas.DrawTile(hbr_genr[4], genrTU, genrTV, 0, 0, hbr_genr[4].UClamp, hbr_genr[4].VClamp);
					
					Canvas.CurY = Yb;
					Canvas.CurX = Xb;
					Canvas.DrawTile(hbr_bord[AmmoStage-4], bordTU, bordTV, 0, 0, hbr_bord[AmmoStage-4].UClamp, hbr_bord[AmmoStage-4].VClamp);				
				}
												
				if ( AmmoStage == 7 )
					AmmoMode = 1;
				break;
		case 3:	
				if ( AmmoStage <= 3 )
				{
					Canvas.CurY = Yg;
					Canvas.CurX = Xg;					
					Canvas.DrawTile(hbr_genr[4], genrTU, genrTV, 0, 0, hbr_genr[4].UClamp, hbr_genr[4].VClamp);

					Canvas.CurY = Yb;
					Canvas.CurX = Xb;				
					Canvas.DrawTile(hbr_bord[3-AmmoStage], bordTU, bordTV, 0, 0, hbr_bord[3-AmmoStage].UClamp, hbr_bord[3-AmmoStage].VClamp);				
				}
				else
				{
					Canvas.CurY = Yg;
					Canvas.CurX = Xg;				
					Canvas.DrawTile(hbr_genr[7-AmmoStage], genrTU, genrTV, 0, 0, hbr_genr[7-AmmoStage].UClamp, hbr_genr[7-AmmoStage].VClamp);
				}

				if ( AmmoStage == 7 )
					AmmoMode = 0;
				break;
		case 4: 							
				if ( ( w.ReloadCount == 0 ) && ( w.AmmoType.AmmoAmount > 0 ) )
					AmmoMode = 1;				
				else if ( ( w.ReloadCount != 0 ) && ( w.AmmoType.AmmoAmount == w.ReloadCount ) )
					AmmoMode = 1;
				else if ( ( w.IsInState('NormalFire')) && ( w.ReloadCount >= ( KlingonWeapons(w).AmmoConsumption * 2 ) ) )
					AmmoMode = 1;				
				else if ( ( w.IsInState('AltFiring')) && ( w.ReloadCount >= ( KlingonWeapons(w).AltAmmoConsumption * 2) ) )
					AmmoMode = 1;

				if ( AmmoStage <= 2 )
				{				
					Canvas.CurY = Yg;
					Canvas.CurX = Xg;
					Canvas.DrawTile(hbr_genr[5+AmmoStage], genrTU, genrTV, 0, 0, hbr_genr[5+AmmoStage].UClamp, hbr_genr[5+AmmoStage].VClamp);
				
					Canvas.CurY = Yb;
					Canvas.CurX = Xb;			
					Canvas.DrawTile(hbr_bord[5+AmmoStage], bordTU, bordTV, 0, 0, hbr_bord[5+AmmoStage].UClamp, hbr_bord[5+AmmoStage].VClamp);
				}
				else if ( AmmoStage > 2 )
				{
					switch ( AmmoStage )
					{
						case 3 :
								blinkval = 3;
								break;
						case 4 :
								blinkval = 1;
								break;
						case 5 :
								blinkval = -1;
								break;
					}

					Canvas.CurY = Yg;
					Canvas.CurX = Xg;
					Canvas.DrawTile(hbr_genr[blinkval+AmmoStage], genrTU, genrTV, 0, 0, hbr_genr[blinkval+AmmoStage].UClamp, hbr_genr[blinkval+AmmoStage].VClamp);
				
					Canvas.CurY = Yb;
					Canvas.CurX = Xb;			
					Canvas.DrawTile(hbr_bord[blinkval+AmmoStage], bordTU, bordTV, 0, 0, hbr_bord[blinkval+AmmoStage].UClamp, hbr_bord[blinkval+AmmoStage].VClamp);
				}

				if ( w != None )
				{
					if ( w.AmmoType.Icon != None )
					{
						TU = w.AmmoType.Icon.UClamp * XRatio;
						TV = w.AmmoType.Icon.VClamp * YRatio;
																				
/*
						if ( w.AmmoType.IsA('ChargeCell') ) 
						{
							if ( w.AmmoType.AmmoAmount <= 100 )
								Mask = ((( 100 - w.AmmoType.AmmoAmount) * 0.2) + 14) * YRatio;
							Canvas.CurY = (416 + Mask) * YRatio;
							Canvas.CurX = 584 * XRatio;		
							Canvas.DrawTile(w.AmmoType.Icon, TU, TV, 0, Mask, w.AmmoType.Icon.UClamp, w.AmmoType.Icon.VClamp);
						}
						else
						{
*/
							Canvas.CurY = 416 * YRatio;
							Canvas.CurX = 584 * XRatio;		
							Canvas.DrawTile(w.AmmoType.Icon, TU, TV, 0, 0, w.AmmoType.Icon.UClamp, w.AmmoType.Icon.VClamp);
//						}
					}
												
					if ( ( w.Default.ReloadCount != 0 ) && ( w.Default.ReloadCount < w.AmmoType.AmmoAmount ) )
					{
						if ( Canvas.ClipY >= 400 )
							Canvas.Font = Font'hMYellowFont';
						else
							Canvas.Font = Font'hSYellowFont';

						Canvas.CurY = 430 * YRatio;
						Canvas.CurX = 506 * XRatio;			
						Canvas.DrawText(w.ReloadCount,False);
						
						if ( Canvas.ClipY >= 400 )
							Canvas.Font = Font'hMRedFont';
						else
							Canvas.Font = Font'hSRedFont';
			
						Canvas.CurY = 430 * YRatio;
						Canvas.DrawText("/",False);
					}
									
					if ( Canvas.ClipY >= 400 )
						Canvas.Font = Font'hMYellowFont';
					else
						Canvas.Font = Font'hSYellowFont';
				
					Canvas.CurY = 430 * YRatio;
					Canvas.CurX = 552 * XRatio;
					Canvas.DrawText(w.AmmoType.AmmoAmount,False);
					Canvas.CurY = 430 * YRatio;
					Canvas.DrawText("<",False);
				}
				break;
	}
			
	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


simulated function DrawTimer (Canvas Canvas )
{
	local int X;
	local int Y;
	local int TU;
	local int TV;

	local int Min;
	local int Secs;
	local int blinkval;	
	
	Canvas.Style = 2;	
	Y = 0;
	X = 0;
	
	switch ( TimerMode )
	{
		case 1 :
				Canvas.CurY = Y;
				Canvas.CurX = X;	
				Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);
			
				Canvas.CurY = Y;
				Canvas.CurX = X;
				Canvas.DrawTile(htl_bord[4], bordTU, bordTV, 0, 0, htl_bord[4].UClamp, htl_bord[4].VClamp);
			
				Canvas.CurY = Y;
				Canvas.CurX = X;	
				Canvas.DrawTile(h_timer[TimerStage+2], bordTU, bordTV, 0, 0, h_timer[TimerStage+2].UClamp, h_timer[TimerStage+2].VClamp);
				
				Min = TimeLeft / 60;
				Secs = TimeLeft - (Min * 60);

				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMRedFont';
				else
					Canvas.Font = Font'hSRedFont';
								
				Canvas.CurY = 32 * YRatio;
				Canvas.CurX = 47 * XRatio;		
				if (Min>=10) 
					Canvas.DrawText(Min,False);
				else
					Canvas.DrawText("0"$Min,False);
					
				Canvas.CurY = 30 * YRatio;
				Canvas.CurX = 71 * XRatio;		
				Canvas.DrawText(":",False);
			
				Canvas.CurY = 32 * YRatio;
				Canvas.CurX = 78 * XRatio;		
				if (Secs>=10) 
					Canvas.DrawText(Secs,False);
				else
					Canvas.DrawText("0"$Secs,False);
				break;
		case 2:
				if ( ComStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[ComStage], genrTU, genrTV, 0, 0, htl_genr[ComStage].UClamp, htl_genr[ComStage].VClamp);
				}
				else
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);

					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[ComStage-4], bordTU, bordTV, 0, 0, htl_bord[ComStage-4].UClamp, htl_bord[ComStage-4].VClamp);					
				}
												
				if ( ComStage == 7 )
					TimerMode = 1;
				break;
		case 3:											
				if ( ComStage <= 3 )
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[4], genrTU, genrTV, 0, 0, htl_genr[4].UClamp, htl_genr[4].VClamp);
				
					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[3-ComStage], bordTU, bordTV, 0, 0, htl_bord[3-ComStage].UClamp, htl_bord[3-ComStage].VClamp);
				}
				else
				{
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[7-ComStage], genrTU, genrTV, 0, 0, htl_genr[7-ComStage].UClamp, htl_genr[7-ComStage].VClamp);
				}

				if ( ComStage == 7 )
					TimerMode = 0;
				break;				
		case 4: 		
				if ( ComStage <= 2 )
				{				
					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[5+ComStage], genrTU, genrTV, 0, 0, htl_genr[5+ComStage].UClamp, htl_genr[5+ComStage].VClamp);
				
					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[5+ComStage], bordTU, bordTV, 0, 0, htl_bord[5+ComStage].UClamp, htl_bord[5+ComStage].VClamp);
				}
				else if ( ComStage > 2 )
				{
					switch ( ComStage )
					{
						case 3 :
								blinkval = 3;
								break;
						case 4 :
								blinkval = 1;
								break;
						case 5 :
								blinkval = -1;
								break;
					}

					Canvas.CurY = Y;
					Canvas.CurX = X;	
					Canvas.DrawTile(htl_genr[blinkval+ComStage], genrTU, genrTV, 0, 0, htl_genr[blinkval+ComStage].UClamp, htl_genr[blinkval+ComStage].VClamp);
				
					Canvas.CurY = Y;
					Canvas.CurX = X;
					Canvas.DrawTile(htl_bord[blinkval+ComStage], bordTU, bordTV, 0, 0, htl_bord[blinkval+ComStage].UClamp, htl_bord[blinkval+ComStage].VClamp);
				}
						
				Canvas.CurY = Y;
				Canvas.CurX = X;	
				Canvas.DrawTile(h_timer[TimerStage+2], bordTU, bordTV, 0, 0, h_timer[TimerStage+2].UClamp, h_timer[TimerStage+2].VClamp);
				
				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMRedFont';
				else
					Canvas.Font = Font'hSRedFont';
				
				Min = TimeLeft / 60;
				Secs = TimeLeft - (Min * 60);
				
				Canvas.CurY = 32 * YRatio;
				Canvas.CurX = 47 * XRatio;		
				if (Min>=10) 
					Canvas.DrawText(Min,False);
				else
					Canvas.DrawText("0"$Min,False);
					
				Canvas.CurY = 30 * YRatio;
				Canvas.CurX = 71 * XRatio;		
				Canvas.DrawText(":",False);
			
				Canvas.CurY = 32 * YRatio;
				Canvas.CurX = 78 * XRatio;		
				if (Secs>=10) 
					Canvas.DrawText(Secs,False);
				else
					Canvas.DrawText("0"$Secs,False);
	}

	Canvas.Font = Font'hLRedFont';
	Canvas.Style = 1;
}


//*********  Animation routines ****************
simulated function AnimateComStart()
{
	if ( ComMode != 1 )
	{
		ComBlink = True;
		ComMode = 2;
	}
}


simulated function AnimateComStop()
{	
	if ( ComMode != 0 )
	{	
		ComBlink = false;
		ComMode = 3;
	}
}

simulated function TimerStart ()
{
	if ( ComMode != 0 )
	{	
		ComBlink = false;
		ComMode = 3;
	}

	if ( TimerMode != 1 )
	{
		TimerMode = 2;
		TimerStage = 0;
	}
}

simulated function TimerSet (float NumSeconds )
{	
	TimeLeft = NumSeconds;
	
	if ( TimeLeft <= 0 )
		TimerStop();
}

simulated function TimerStop ()
{
	if ( TimerMode != 0 )
		TimerMode = 3;
}


//
// Return the 'best' player start for this player to start from.
// Re-implement for each game type.
//
function NavigationPoint FindPlayerStart( optional byte Team, optional string[32] incomingName )
{
	local PlayerStart Dest;

	foreach AllActors( class 'PlayerStart', Dest )
		if( Dest.bSinglePlayerStart )
			return Dest;
	log( "No single player start found" );
	return None;
}

defaultproperties
{
     DMHudMode=5
     OverlayOn=True
     MusicOn=True
     hbr_bord(0)=Texture'KlingonHUD.infobord.H_h01'
     hbr_bord(1)=Texture'KlingonHUD.infobord.H_h02'
     hbr_bord(2)=Texture'KlingonHUD.infobord.H_h03'
     hbr_bord(3)=Texture'KlingonHUD.infobord.H_h04'
     hbr_bord(4)=Texture'KlingonHUD.infobord.H_h05'
     hbr_bord(5)=Texture'KlingonHUD.infobord.H_h06'
     hbr_bord(6)=Texture'KlingonHUD.infobord.H_h07'
     hbr_bord(7)=Texture'KlingonHUD.infobord.H_h08'
     hbl_bord(0)=Texture'KlingonHUD.infobord.H_g01'
     hbl_bord(1)=Texture'KlingonHUD.infobord.H_g02'
     hbl_bord(2)=Texture'KlingonHUD.infobord.H_g03'
     hbl_bord(3)=Texture'KlingonHUD.infobord.H_g04'
     hbl_bord(4)=Texture'KlingonHUD.infobord.H_g05'
     hbl_bord(5)=Texture'KlingonHUD.infobord.H_g06'
     hbl_bord(6)=Texture'KlingonHUD.infobord.H_g07'
     hbl_bord(7)=Texture'KlingonHUD.infobord.H_g08'
     htr_bord(0)=Texture'KlingonHUD.infobord.H_f01'
     htr_bord(1)=Texture'KlingonHUD.infobord.H_f02'
     htr_bord(2)=Texture'KlingonHUD.infobord.H_f03'
     htr_bord(3)=Texture'KlingonHUD.infobord.H_f04'
     htr_bord(4)=Texture'KlingonHUD.infobord.H_f05'
     htr_bord(5)=Texture'KlingonHUD.infobord.H_f06'
     htr_bord(6)=Texture'KlingonHUD.infobord.H_f07'
     htr_bord(7)=Texture'KlingonHUD.infobord.H_f08'
     htl_bord(0)=Texture'KlingonHUD.infobord.H_e01'
     htl_bord(1)=Texture'KlingonHUD.infobord.H_e02'
     htl_bord(2)=Texture'KlingonHUD.infobord.H_e03'
     htl_bord(3)=Texture'KlingonHUD.infobord.H_e04'
     htl_bord(4)=Texture'KlingonHUD.infobord.H_e05'
     htl_bord(5)=Texture'KlingonHUD.infobord.H_e06'
     htl_bord(6)=Texture'KlingonHUD.infobord.H_e07'
     htl_bord(7)=Texture'KlingonHUD.infobord.H_e08'
     h_dmt_bord(0)=Texture'KlingonHUD.DM.Dmh_b01'
     h_dmt_bord(1)=Texture'KlingonHUD.DM.Dmh_b02'
     h_dmt_bord(2)=Texture'KlingonHUD.DM.Dmh_b03'
     h_dmt_bord(3)=Texture'KlingonHUD.DM.Dmh_b04'
     h_dmt_bord(4)=Texture'KlingonHUD.DM.Dmh_b05'
     h_dmt_bord(5)=Texture'KlingonHUD.DM.Dmh_b06'
     h_dmt_bord(6)=Texture'KlingonHUD.DM.Dmh_b07'
     h_dmt_bord(7)=Texture'KlingonHUD.DM.Dmh_b08'
     h_dmb_bord(0)=Texture'KlingonHUD.DM.Dmh_c01'
     h_dmb_bord(1)=Texture'KlingonHUD.DM.Dmh_c02'
     h_dmb_bord(2)=Texture'KlingonHUD.DM.Dmh_c03'
     h_dmb_bord(3)=Texture'KlingonHUD.DM.Dmh_c04'
     h_dmb_bord(4)=Texture'KlingonHUD.DM.Dmh_c05'
     h_dmb_bord(5)=Texture'KlingonHUD.DM.Dmh_c06'
     h_dmb_bord(6)=Texture'KlingonHUD.DM.Dmh_c07'
     h_dmb_bord(7)=Texture'KlingonHUD.DM.Dmh_c08'
     hbl_genr(0)=Texture'KlingonHUD.genrbord.H_c01'
     hbl_genr(1)=Texture'KlingonHUD.genrbord.H_c02'
     hbl_genr(2)=Texture'KlingonHUD.genrbord.H_c03'
     hbl_genr(3)=Texture'KlingonHUD.genrbord.H_c04'
     hbl_genr(4)=Texture'KlingonHUD.genrbord.H_c05'
     hbl_genr(5)=Texture'KlingonHUD.genrbord.H_c06'
     hbl_genr(6)=Texture'KlingonHUD.genrbord.H_c07'
     hbl_genr(7)=Texture'KlingonHUD.genrbord.H_c08'
     hbr_genr(0)=Texture'KlingonHUD.genrbord.H_d01'
     hbr_genr(1)=Texture'KlingonHUD.genrbord.H_d02'
     hbr_genr(2)=Texture'KlingonHUD.genrbord.H_d03'
     hbr_genr(3)=Texture'KlingonHUD.genrbord.H_d04'
     hbr_genr(4)=Texture'KlingonHUD.genrbord.H_d05'
     hbr_genr(5)=Texture'KlingonHUD.genrbord.H_d06'
     hbr_genr(6)=Texture'KlingonHUD.genrbord.H_d07'
     hbr_genr(7)=Texture'KlingonHUD.genrbord.H_d08'
     htl_genr(0)=Texture'KlingonHUD.genrbord.H_a01'
     htl_genr(1)=Texture'KlingonHUD.genrbord.H_a02'
     htl_genr(2)=Texture'KlingonHUD.genrbord.H_a03'
     htl_genr(3)=Texture'KlingonHUD.genrbord.H_a04'
     htl_genr(4)=Texture'KlingonHUD.genrbord.H_a05'
     htl_genr(5)=Texture'KlingonHUD.genrbord.H_a06'
     htl_genr(6)=Texture'KlingonHUD.genrbord.H_a07'
     htl_genr(7)=Texture'KlingonHUD.genrbord.H_a08'
     htr_genr(0)=Texture'KlingonHUD.genrbord.H_b01'
     htr_genr(1)=Texture'KlingonHUD.genrbord.H_b02'
     htr_genr(2)=Texture'KlingonHUD.genrbord.H_b03'
     htr_genr(3)=Texture'KlingonHUD.genrbord.H_b04'
     htr_genr(4)=Texture'KlingonHUD.genrbord.H_b05'
     htr_genr(5)=Texture'KlingonHUD.genrbord.H_b06'
     htr_genr(6)=Texture'KlingonHUD.genrbord.H_b07'
     htr_genr(7)=Texture'KlingonHUD.genrbord.H_b08'
     h_dmt_genr(0)=Texture'KlingonHUD.DM.Dmh_a01'
     h_dmt_genr(1)=Texture'KlingonHUD.DM.Dmh_a02'
     h_dmt_genr(2)=Texture'KlingonHUD.DM.Dmh_a03'
     h_dmt_genr(3)=Texture'KlingonHUD.DM.Dmh_a04'
     h_dmt_genr(4)=Texture'KlingonHUD.DM.Dmh_a05'
     h_dmt_genr(5)=Texture'KlingonHUD.DM.Dmh_a06'
     h_dmt_genr(6)=Texture'KlingonHUD.DM.Dmh_a07'
     h_dmt_genr(7)=Texture'KlingonHUD.DM.Dmh_a08'
     h_dmb_genr(0)=Texture'KlingonHUD.DM.Dmh_d01'
     h_dmb_genr(1)=Texture'KlingonHUD.DM.Dmh_d02'
     h_dmb_genr(2)=Texture'KlingonHUD.DM.Dmh_d03'
     h_dmb_genr(3)=Texture'KlingonHUD.DM.Dmh_d04'
     h_dmb_genr(4)=Texture'KlingonHUD.DM.Dmh_d05'
     h_dmb_genr(5)=Texture'KlingonHUD.DM.Dmh_d06'
     h_dmb_genr(6)=Texture'KlingonHUD.DM.Dmh_d07'
     h_dmb_genr(7)=Texture'KlingonHUD.DM.Dmh_d08'
     hl_weap(0)=Texture'KlingonHUD.weapbord.H_i01'
     hl_weap(1)=Texture'KlingonHUD.weapbord.H_i02'
     hl_weap(2)=Texture'KlingonHUD.weapbord.H_i03'
     hl_weap(3)=Texture'KlingonHUD.weapbord.H_i04'
     hl_weap(4)=Texture'KlingonHUD.weapbord.H_i05'
     hl_weap(5)=Texture'KlingonHUD.weapbord.H_i06'
     hl_weap(6)=Texture'KlingonHUD.weapbord.H_i07'
     hl_weap(7)=Texture'KlingonHUD.weapbord.H_i08'
     hr_weap(0)=Texture'KlingonHUD.weapbord.H_j01'
     hr_weap(1)=Texture'KlingonHUD.weapbord.H_j02'
     hr_weap(2)=Texture'KlingonHUD.weapbord.H_j03'
     hr_weap(3)=Texture'KlingonHUD.weapbord.H_j04'
     hr_weap(4)=Texture'KlingonHUD.weapbord.H_j05'
     hr_weap(5)=Texture'KlingonHUD.weapbord.H_j06'
     hr_weap(6)=Texture'KlingonHUD.weapbord.H_j07'
     hr_weap(7)=Texture'KlingonHUD.weapbord.H_j08'
     h_weapicon(0)=Texture'KlingonHUD.weapicon.W_1_01'
     h_weapicon(1)=Texture'KlingonHUD.weapicon.W_1_02'
     h_weapicon(2)=Texture'KlingonHUD.weapicon.W_1_03'
     h_weapicon(3)=Texture'KlingonHUD.weapicon.W_2_01'
     h_weapicon(4)=Texture'KlingonHUD.weapicon.W_2_02'
     h_weapicon(5)=Texture'KlingonHUD.weapicon.W_2_03'
     h_weapicon(6)=Texture'KlingonHUD.weapicon.W_3_01'
     h_weapicon(7)=Texture'KlingonHUD.weapicon.W_3_02'
     h_weapicon(8)=Texture'KlingonHUD.weapicon.W_3_03'
     h_weapicon(9)=Texture'KlingonHUD.weapicon.W_4_01'
     h_weapicon(10)=Texture'KlingonHUD.weapicon.W_4_02'
     h_weapicon(11)=Texture'KlingonHUD.weapicon.W_4_03'
     h_weapicon(12)=Texture'KlingonHUD.weapicon.W_5_01'
     h_weapicon(13)=Texture'KlingonHUD.weapicon.W_5_02'
     h_weapicon(14)=Texture'KlingonHUD.weapicon.W_5_03'
     h_weapicon(15)=Texture'KlingonHUD.weapicon.W_6_01'
     h_weapicon(16)=Texture'KlingonHUD.weapicon.W_6_02'
     h_weapicon(17)=Texture'KlingonHUD.weapicon.W_6_03'
     h_weapicon(18)=Texture'KlingonHUD.weapicon.W_7_01'
     h_weapicon(19)=Texture'KlingonHUD.weapicon.W_7_02'
     h_weapicon(20)=Texture'KlingonHUD.weapicon.W_7_03'
     h_weapicon(21)=Texture'KlingonHUD.weapicon.W_8_01'
     h_weapicon(22)=Texture'KlingonHUD.weapicon.W_8_02'
     h_weapicon(23)=Texture'KlingonHUD.weapicon.W_8_03'
     h_weapicon(24)=Texture'KlingonHUD.weapicon.W_9_01'
     h_weapicon(25)=Texture'KlingonHUD.weapicon.W_9_02'
     h_weapicon(26)=Texture'KlingonHUD.weapicon.W_9_03'
     h_weapicon(27)=Texture'KlingonHUD.weapicon.W_0_01'
     h_weapicon(28)=Texture'KlingonHUD.weapicon.W_0_02'
     h_weapicon(29)=Texture'KlingonHUD.weapicon.W_0_03'
     h_invicon(1)=Texture'KlingonHUD.InvIcons.I_medkit'
     h_invicon(2)=Texture'KlingonHUD.InvIcons.line'
     h_armback(0)=Texture'KlingonHUD.HUDBack.achudP1'
     h_armback(1)=Texture'KlingonHUD.HUDBack.achudP2'
     h_armback(2)=Texture'KlingonHUD.HUDBack.vachudP1'
     h_armback(3)=Texture'KlingonHUD.HUDBack.vachudP2'
     h_armback(4)=Texture'KlingonHUD.HUDBack.CamhudP1'
     h_armback(5)=Texture'KlingonHUD.HUDBack.CamhudP2'
     h_crosshair(0)=Texture'KlingonHUD.Crosshairs.Crhr_r01'
     h_crosshair(1)=Texture'KlingonHUD.Crosshairs.Crhr_r02'
     h_crosshair(2)=Texture'KlingonHUD.Crosshairs.Crhr_r03'
     h_crosshair(3)=Texture'KlingonHUD.Crosshairs.Crhr_r04'
     h_crosshair(4)=Texture'KlingonHUD.Crosshairs.Crhr_r05'
     h_crosshair(5)=Texture'KlingonHUD.Crosshairs.Crhr_r06'
     h_crosshair(6)=Texture'KlingonHUD.Crosshairs.Crhr_r07'
     h_crosshair(7)=Texture'KlingonHUD.Crosshairs.Crhr_r08'
     h_crosshair(8)=Texture'KlingonHUD.Crosshairs.Crhr_r09'
     h_crosshair(9)=Texture'KlingonHUD.Crosshairs.Crhr_r10'
     h_invbord(0)=Texture'KlingonHUD.invbord.H_m01'
     h_invbord(1)=Texture'KlingonHUD.invbord.H_m02'
     h_invbord(2)=Texture'KlingonHUD.invbord.H_m03'
     h_invbord(3)=Texture'KlingonHUD.invbord.H_m04'
     h_invbord(4)=Texture'KlingonHUD.invbord.H_m05'
     h_invbord(5)=Texture'KlingonHUD.invbord.H_m06'
     h_invbord(6)=Texture'KlingonHUD.invbord.H_m07'
     h_invbord(7)=Texture'KlingonHUD.invbord.H_m08'
     h_combord(0)=Texture'KlingonHUD.Com.C_01'
     h_combord(1)=Texture'KlingonHUD.Com.C_02'
     h_combord(2)=Texture'KlingonHUD.Com.C_03'
     h_combord(3)=Texture'KlingonHUD.Com.C_04'
     h_combord(4)=Texture'KlingonHUD.Com.C_05'
     h_combord(5)=Texture'KlingonHUD.Com.C_06'
     h_combord(6)=Texture'KlingonHUD.Com.C_07'
     h_combord(7)=Texture'KlingonHUD.Com.C_08'
     h_combord(8)=Texture'KlingonHUD.Com.C_09'
     h_combord(9)=Texture'KlingonHUD.Com.C_10'
     h_combord(10)=Texture'KlingonHUD.Com.C_11'
     h_timer(0)=Texture'KlingonHUD.Timer.T_01'
     h_timer(1)=Texture'KlingonHUD.Timer.T_02'
     h_timer(2)=Texture'KlingonHUD.Timer.T_03'
     h_timer(3)=Texture'KlingonHUD.Timer.T_04'
     h_timer(4)=Texture'KlingonHUD.Timer.T_05'
     h_timer(5)=Texture'KlingonHUD.Timer.T_06'
     h_timer(6)=Texture'KlingonHUD.Timer.T_07'
     h_timer(7)=Texture'KlingonHUD.Timer.T_08'
     h_timer(8)=Texture'KlingonHUD.Timer.T_09'
     h_timer(9)=Texture'KlingonHUD.Timer.T_10'
     h_timer(10)=Texture'KlingonHUD.Timer.T_11'
     h_dm_icon(0)=Texture'KlingonHUD.DM.Dmh_e01'
     h_dm_icon(1)=Texture'KlingonHUD.DM.Dmh_f01'
     bAllowMenu=True
     SplashTime=50
     LegalTime=40
     GameSplash(0)=Texture'KlingonHUD.Legal.KHGTitleP1'
     GameSplash(1)=Texture'KlingonHUD.Legal.KHGTitleP2'
     GameSplash(2)=Texture'KlingonHUD.Legal.KHGTitleP3'
     GameSplash(3)=Texture'KlingonHUD.Legal.KHGTitleP4'
     GameLegal(0)=Texture'KlingonHUD.Legal.KHGLegalP1'
     GameLegal(1)=Texture'KlingonHUD.Legal.KHGLegalP2'
     GameLegal(2)=Texture'KlingonHUD.Legal.KHGLegalP3'
     GameLegal(3)=Texture'KlingonHUD.Legal.KHGLegalP4'
     MiniBuild=Sound'KlingonSFX01.Effects.screenreconfig'
     HudMode=1
     Crosshair=1
     MainMenuType=Class'Klingons.KlingonMenuMain'
     Tag=Other
}
