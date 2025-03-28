//=============================================================================
// KlingonMenu.
//=============================================================================
class KlingonMenu expands Menu;

#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01
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

var() sound 	MenuSnd[7];
var() texture 	MenuIcon[10];
var() texture	MenuSlider[8];

var string[64]  MenuValues[24];

var() texture	MenuBck1[4];
var() texture	MenuBck2[4];
var() texture	CredBck[4];

var   float     XRatio;
var	  float     YRatio;
var   bool      NeedScaling;


/*
#exec Texture Import File=Textures\dot.pcx Name=Dot MIPS=OFF
#exec OBJ LOAD FILE=textures\menugr.utx PACKAGE=UNREALI.MenuGfx
*/



function MenuProcessInput( byte KeyNum, byte ActionNum )
{
	if ( KeyNum == EInputKey.IK_Escape )
	{
		PlayerOwner.PlaySound(MenuSnd[1],,2.0);
		ExitMenu();
		return;
	}	

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
	else if ( KeyNum == EInputKey.IK_Enter )
	{
		bConfigChanged=true;
		if ( ProcessSelection() )
		PlayerOwner.PlaySound(MenuSnd[0],,2.0);
	}
	else if ( KeyNum == EInputKey.IK_Left )
	{
		bConfigChanged=true;
		if ( ProcessLeft() )
		PlayerOwner.PlaySound(MenuSnd[2],,2.0);
	}
	else if ( KeyNum == EInputKey.IK_Right )
	{
		bConfigChanged=true;
		if ( ProcessRight() )
		PlayerOwner.PlaySound(MenuSnd[2],,2.0);
	}
	else if ( KeyNum == EInputKey.IK_Y )
	{
		bConfigChanged=true;
		if ( ProcessYes() )
			PlayerOwner.PlaySound(MenuSnd[6],,2.0);
	}
	else if ( KeyNum == EInputKey.IK_N )
	{
		bConfigChanged=true;
		if ( ProcessNo() )
			PlayerOwner.PlaySound(MenuSnd[3],,2.0);
	}

	if ( bExitAllMenus )
		ExitAllMenus(); 	
}


function DrawCreditBackGround(canvas Canvas )
{	
	local int StartX;
	local int TU;
	local int TV;
		
	XRatio = Canvas.ClipX * 0.0015625;
	YRatio = Canvas.ClipY * 0.0020833333333;

	TU = 640 * XRatio;
	TV = 480 * YRatio;
		
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 1;
	
	TU = 320 * XRatio;
	TV = 330 * YRatio;
	Canvas.SetPos(0,0);
	Canvas.DrawTile( CredBck[0], TU, TV, 0, 0, CredBck[0].UClamp, CredBck[0].VClamp );
	Canvas.DrawTile( CredBck[1], TU, TV, 0, 0, CredBck[1].UClamp, CredBck[1].VClamp );

	Canvas.SetPos(0,TV);
	TU = 320 * XRatio;
	TV = 150 * YRatio;
	Canvas.DrawTile( CredBck[2], TU, TV, 0, 0, CredBck[2].UClamp, CredBck[2].VClamp/2 );
	Canvas.DrawTile( CredBck[3], TU, TV, 0, 0, CredBck[3].UClamp, CredBck[3].VClamp/2 );

	Canvas.bNoSmooth = True;	
	
	Canvas.Style = 1;
}



function DrawSetupBackGround(canvas Canvas )
{	
	local int StartX;
	local int TU;
	local int TV;
		
	XRatio = Canvas.ClipX * 0.0015625;
	YRatio = Canvas.ClipY * 0.0020833333333;

	TU = 640 * XRatio;
	TV = 480 * YRatio;
		
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 2;
	
	TU = 320 * XRatio;
	TV = 325 * YRatio;
	Canvas.SetPos(0,0);
	Canvas.DrawTile( MenuBck2[0], TU, TV, 0, 0, MenuBck2[0].UClamp, MenuBck2[0].VClamp );
	Canvas.DrawTile( MenuBck2[1], TU, TV, 0, 0, MenuBck2[1].UClamp, MenuBck2[1].VClamp );

	Canvas.SetPos(0,TV);
	TU = 320 * XRatio;
	TV = 155 * YRatio;
	Canvas.DrawTile( MenuBck2[2], TU, TV, 0, 0, MenuBck2[2].UClamp, MenuBck2[2].VClamp/2 );
	Canvas.DrawTile( MenuBck2[3], TU, TV, 0, 0, MenuBck2[3].UClamp, MenuBck2[3].VClamp/2 );

	if ( Canvas.ClipY >= 400 )
	{
		Canvas.Font = Font'hLGreenFont';
		Canvas.SetPos(Max(8, 0.5 * Canvas.ClipX - 100), 75 * YRatio);
	}
	else
	{
		Canvas.Font = Font'hMGreenFont';
		Canvas.SetPos(Max(8, 0.5 * Canvas.ClipX - 50), 75 * YRatio);
	}		

	DrawTitle(Canvas);	

	Canvas.bNoSmooth = True;	
	
	Canvas.Style = 1;
}


function DrawBackGround(canvas Canvas, bool bNoLogo)
{	
	local int StartX;
	local int TU;
	local int TV;
	
	
	XRatio = Canvas.ClipX * 0.0015625;
	YRatio = Canvas.ClipY * 0.0020833333333;

	TU = 640 * XRatio;
	TV = 480 * YRatio;
	
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 1;
	
	TU = 320 * XRatio;
	TV = 330 * YRatio;
	Canvas.SetPos(0,0);
	Canvas.DrawTile( MenuBck1[0], TU, TV, 0, 0, MenuBck1[0].UClamp, MenuBck1[0].VClamp );
	Canvas.DrawTile( MenuBck1[1], TU, TV, 0, 0, MenuBck1[1].UClamp, MenuBck1[1].VClamp );

	Canvas.SetPos(0,TV);
	TU = 320 * XRatio;
	TV = 150 * YRatio;
	Canvas.DrawTile( MenuBck1[2], TU, TV, 0, 0, MenuBck1[2].UClamp, MenuBck1[2].VClamp/2 );
	Canvas.DrawTile( MenuBck1[3], TU, TV, 0, 0, MenuBck1[3].UClamp, MenuBck1[3].VClamp/2 );

	DrawTitle(Canvas);	
	
/*	Put the bottom fractal and Unreal Logo
	if ( bNoLogo )
		Return;
	
	Canvas.Style = 3;	
	StartX = 0.5 * Canvas.ClipX - 128;	
	Canvas.SetPos(StartX,Canvas.ClipY-58);	
//	Canvas.DrawTile( Texture'MenuBarrier', 256, 64, 0, 0, 256, 64 );
	StartX = 0.5 * Canvas.ClipX - 128;
	Canvas.Style = 2;	
	Canvas.SetPos(StartX,Canvas.ClipY-52);
//	Canvas.DrawIcon(texture'Logo2', 1.0);	
*/

	Canvas.bNoSmooth = True;	
	Canvas.Style = 1;
}

function DrawSlider( canvas Canvas, int StartX, int StartY, int Value, int sMin, int StepSize, int MenuPos )
{
	local bool bFoundValue;
	local int i;
	local int Spacing;
	local int SliderIdx;

	Spacing = Clamp(0.04 * Canvas.ClipY, 11 * XRatio, 32  * YRatio);

	if ( StartX == 0 )
		StartX = 330;
			
	if ( Canvas.ClipY >= 400 )
	{
		SliderIdx = 0;
		if ( StartY == 0 )
			StartY = 110;		
	}
	else
	{
		SliderIdx = 4;
		if ( StartY == 0 )
			StartY = 115;		
	}

	Canvas.Style = 2;
	Canvas.SetPos(StartX * XRatio, ( StartY * YRatio ) + Spacing * MenuPos);

	Canvas.DrawIcon(MenuSlider[0 + SliderIdx],1.0);	
	bFoundValue = false;
	For ( i=1; i<8; i++ )
	{
		if ( !bFoundValue && ( StepSize * i + sMin > Value) )
		{
			bFoundValue = true; 
			Canvas.DrawIcon(MenuSlider[3 + SliderIdx],1.0);
		}
		else
			Canvas.DrawIcon(MenuSlider[1 + SliderIdx],1.0);
	}
	if ( bFoundValue )
		Canvas.DrawIcon(MenuSlider[1 + SliderIdx],1.0);
	else
		Canvas.DrawIcon(MenuSlider[3 + SliderIdx],1.0);

	Canvas.DrawIcon(MenuSlider[2 + SliderIdx],1.0);							
	Canvas.Style = 1;	
}


function KDrawList( canvas Canvas, int StartX, int StartY)
{
	local int i;
	local int Spacing;
	local int L,XL,YL, NewX;

	Spacing = Clamp(0.04 * Canvas.ClipY, 11 * XRatio, 32  * YRatio);

	if ( StartX == 0 )
		StartX = 160;
	
	if ( StartY == 0 )
		StartY = 110;

	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMRedFont';
	else
	{
		StartY += 5;
		Canvas.Font = Font'hSRedFont';	
	}

	for (i=0; i< (MenuLength); i++ )
	{
		SetFontBrightness(Canvas, (i == Selection - 1) );

		if ( StartX == 320 )
		{
			L=Len(MenuList[i + 1]);
			Canvas.StrLen(MenuList[i + 1],L,0,XL,YL);
			NewX =(Canvas.ClipX*0.5)-(XL*0.5);
			Canvas.SetPos(NewX, ( StartY * YRatio ) + Spacing * i);
		}
		else
		{
			Canvas.SetPos(StartX  * XRatio, ( StartY * YRatio ) + Spacing * i);
		}
		Canvas.DrawText(MenuList[i + 1], false);
	}
	Canvas.DrawColor = Canvas.Default.DrawColor;
}


function KDrawChangeList(canvas Canvas, int StartX, int StartY)
{
	local int i;
	local int Spacing;
	local int L,XL,YL, NewX;

	Spacing = Clamp(0.04 * Canvas.ClipY, 11 * XRatio, 32 * YRatio);

	if ( StartX == 0 )
		StartX = 330;
			
	if ( StartY == 0 )
		StartY = 110;
			
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMGreenFont';
	else
		Canvas.Font = Font'hSGreenFont';

	for (i=0; i< (MenuLength); i++ )
	{
		SetFontBrightness(Canvas, (i == Selection - 1) );

		if ( StartX == 320 )
		{
			L=Len(MenuValues[i + 1]);
			Canvas.StrLen(MenuValues[i + 1],L,0,XL,YL);
			NewX =(Canvas.ClipX*0.5)-(XL*0.5);
			Canvas.SetPos(NewX, ( StartY * YRatio ) + Spacing * i);
		}
		else
		{
			Canvas.SetPos(StartX * XRatio, ( StartY * YRatio ) + Spacing * i);
		}
		Canvas.DrawText(MenuValues[i + 1], false);
	}
	Canvas.DrawColor = Canvas.Default.DrawColor;
}


function KDrawHelpPanel(canvas Canvas)
{
	local int StartX;
	local int StartY;
	local int DrawY;
	local int ClipX;
	local int ClipY;
	local int OldClipX;
	local int OldClipY;

	if ( Canvas.ClipY < 400 )
		return;

	OldClipX = Canvas.ClipX;
	OldClipY = Canvas.ClipY;

	StartX = 120 * XRatio;
	StartY = 380 * YRatio;
	ClipY = 128 * YRatio;
	
	Canvas.bCenter = false;
	
	if ( Canvas.ClipX > 900 )
	{
		ClipX = (Canvas.ClipX - (370 * XRatio)) * XRatio;
		Canvas.Font = Font'hMYellowFont';
	}
	else if ( ( Canvas.ClipX < 900 ) && ( Canvas.ClipX > 650 ) ) 
	{
		ClipX = 532;
		Canvas.Font = Font'hSYellowFont';
	}
	else
	{
		ClipX = (Canvas.ClipX - (200 * XRatio)) * XRatio;
		Canvas.Font = Font'hSYellowFont';
	}
	
	Canvas.SetOrigin( StartX, StartY );
	Canvas.SetClip(ClipX, ClipY);
	Canvas.SetPos(0,0);
	Canvas.Style = 1;
	SetFontBrightness(Canvas, true);	
	if ( Selection < 20 )
		Canvas.DrawText(HelpMessage[Selection], False);	
	SetFontBrightness(Canvas, false);
	
	Canvas.ClipX = OldClipX;
	Canvas.ClipY = OldClipY;
}


function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, False);
	KDrawList( Canvas, 0, 0);
	KDrawHelpPanel(Canvas);
}

function DrawTitle(canvas Canvas)
{
	local int	X,Y;
	local int	L,XL,YL;

	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hLRedFont';
	else
		Canvas.Font = Font'hMRedFont';

	L=Len(MenuTitle);
	Canvas.StrLen(MenuTitle,L,0,XL,YL);
	X=(Canvas.ClipX*0.5)-(XL*0.5);
		
	Canvas.SetPos( X, 70 * YRatio);
	Canvas.DrawText(MenuTitle, False);
}

defaultproperties
{
     MenuSnd(0)=Sound'KlingonSFX01.Beeps.EnterBee'
     MenuSnd(1)=Sound'KlingonSFX01.Beeps.EscBeep'
     MenuSnd(2)=Sound'KlingonSFX01.Beeps.LRBeep'
     MenuSnd(3)=Sound'KlingonSFX01.Beeps.NoBeep'
     MenuSnd(4)=Sound'KlingonSFX01.Beeps.TypeBeep'
     MenuSnd(5)=Sound'KlingonSFX01.Beeps.UpDnBeep'
     MenuSnd(6)=Sound'KlingonSFX01.Beeps.YesBeep'
     MenuSlider(0)=Texture'KlingonHUD.HUDBack.Slide1'
     MenuSlider(1)=Texture'KlingonHUD.HUDBack.Slide2'
     MenuSlider(2)=Texture'KlingonHUD.HUDBack.Slide3'
     MenuSlider(3)=Texture'KlingonHUD.HUDBack.Slide4'
     MenuSlider(4)=Texture'KlingonHUD.HUDBack.SSlide1'
     MenuSlider(5)=Texture'KlingonHUD.HUDBack.SSlide2'
     MenuSlider(6)=Texture'KlingonHUD.HUDBack.SSlide3'
     MenuSlider(7)=Texture'KlingonHUD.HUDBack.SSlide4'
     MenuBck1(0)=Texture'KlingonHUD.HUDBack.menubackP1'
     MenuBck1(1)=Texture'KlingonHUD.HUDBack.menubackP2'
     MenuBck1(2)=Texture'KlingonHUD.HUDBack.menubackP3'
     MenuBck1(3)=Texture'KlingonHUD.HUDBack.menubackP4'
     MenuBck2(0)=Texture'KlingonHUD.HUDBack.skinpikP1'
     MenuBck2(1)=Texture'KlingonHUD.HUDBack.skinpikP2'
     MenuBck2(2)=Texture'KlingonHUD.HUDBack.skinpikP3'
     MenuBck2(3)=Texture'KlingonHUD.HUDBack.skinpikP4'
     CredBck(0)=Texture'KlingonHUD.HUDBack.creditbackP1'
     CredBck(1)=Texture'KlingonHUD.HUDBack.creditbackP2'
     CredBck(2)=Texture'KlingonHUD.HUDBack.creditbackP3'
     CredBck(3)=Texture'KlingonHUD.HUDBack.creditbackP4'
     MenuList(1)="NOT YET IMPLEMENTED"
}
