//=============================================================================
// KlingonHUDIntroNull.
//=============================================================================
class KlingonHUDIntroNull expands KlingonHUD
	localized;
	
//#exec OBJ LOAD FILE=textures\menugr.utx PACKAGE=UNREALI.MenuGfx
#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD

var() localized string[64] ESCMessage;
var() texture FracBak;
var() texture KHGLogo[2];

simulated function BeginPlay()
{
	Super.BeginPlay();
	SetHUDMode(5);
	SetDMHUDMode(5);
}

simulated function PostRender( canvas Canvas )
{
	local float StartX;
	local int TU;
	local int TV;

	HUDSetup(canvas);
	
	if ( (PlayerPawn(Owner) != None) && PlayerPawn(Owner).bShowMenu  )
	{
		if ( MainMenu == None )
			CreateMenu();
		if ( MainMenu != None )
			MainMenu.DrawMenu(Canvas);
		return;
	}

	if (Level.LevelAction != LEVACT_None) {
		return;
	}

	Canvas.Font = Font'hMRedFont';
	Canvas.SetPos(Canvas.ClipX/2.0-90,4);	
	Canvas.DrawText(ESCMessage, False);	

	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	
	
	Canvas.Style = 2;
	
	TU = FracBak.UClamp * XRatio;
	TV = FracBak.VClamp * YRatio;
	Canvas.SetPos(104 * XRatio,432 * YRatio);
	Canvas.DrawTile( FracBak, TU, TV, 0, 0, FracBak.UClamp, FracBak.VClamp );
	Canvas.DrawTile( FracBak, TU, TV, 0, 0, FracBak.UClamp, FracBak.VClamp );
	Canvas.DrawTile( FracBak, TU, TV, 0, 0, FracBak.UClamp, FracBak.VClamp );

	TU = KHGLogo[0].UClamp * XRatio;
	TV = KHGLogo[0].VClamp * YRatio;
	Canvas.SetPos(64 * XRatio,416 * YRatio);
	Canvas.DrawTile( KHGLogo[0], TU, TV, 0, 0, KHGLogo[0].UClamp, KHGLogo[0].VClamp );
	Canvas.DrawTile( KHGLogo[1], TU, TV, 0, 0, KHGLogo[1].UClamp, KHGLogo[1].VClamp );

	Canvas.Style = 1;
	Super.PostRender(Canvas);
}

simulated function ChangeHud(int d)
{
}

defaultproperties
{
     ESCMessage="Press  ESC  to begin"
     FracBak=WetTexture'KlingonHUD.lavafrac'
     KHGLogo(0)=Texture'KlingonHUD.gamelogo.TitleTextP1'
     KHGLogo(1)=Texture'KlingonHUD.gamelogo.TitleTextP2'
     h_invbord(4)=None
     h_invbord(5)=None
     h_invbord(6)=None
     h_invbord(7)=None
     HudMode=5
}
