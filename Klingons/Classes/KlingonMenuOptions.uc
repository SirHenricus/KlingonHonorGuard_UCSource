//=============================================================================
// KlingonMenuOptions.
//=============================================================================
class KlingonMenuOptions expands KlingonMenu
	localized;

var	  bool bJoystick;

function bool ProcessYes()
{
	if ( Selection == 1 )
		PlayerOwner.ChangeAutoAim(0.93);
	else if ( Selection == 3 )
		PlayerOwner.bInvertMouse = True;
	else if ( Selection == 4 )
		PlayerOwner.ChangeSnapView(True);
	else if ( Selection == 5 )
		PlayerOwner.ChangeAlwaysMouseLook(True);
	else if ( Selection == 6 )
		PlayerOwner.ChangeStairLook(True);
	else if ( Selection == 14 )
		KlingonHUD(PlayerOwner.myHUD).SetOverlay(True);
	else 
		return false;

	return true;
}

function bool ProcessNo()
{
	if ( Selection == 1 )
		PlayerOwner.ChangeAutoAim(1);
	else if ( Selection == 3 )
		PlayerOwner.bInvertMouse = False;
	else if ( Selection == 4 )
		PlayerOwner.ChangeSnapView(False);
	else if ( Selection == 5 )
		PlayerOwner.ChangeAlwaysMouseLook(False);
	else if ( Selection == 6 )
		PlayerOwner.ChangeStairLook(False);
	else if ( Selection == 14 )
		KlingonHUD(PlayerOwner.myHUD).SetOverlay(False);
	else 
		return false;

	return true;
}

function bool ProcessLeft()
{
	if ( Selection == 1 )
	{
		if ( PlayerOwner.MyAutoAim == 1 )
			PlayerOwner.ChangeAutoAim(0.93);
		else
			PlayerOwner.ChangeAutoAim(1);
	}
	else if ( Selection == 2 )
	{
		if ( PlayerOwner.MouseSensitivity <= 10 ) 
			PlayerOwner.UpdateSensitivity(FMax(1,PlayerOwner.MouseSensitivity - 1));
	}
	else if ( Selection == 3 )
		PlayerOwner.bInvertMouse = !PlayerOwner.bInvertMouse;
	else if ( Selection == 4 )
		PlayerOwner.ChangeSnapView(!PlayerOwner.bSnapToLevel);
	else if ( Selection == 5 )
		PlayerOwner.ChangeAlwaysMouseLook(!PlayerOwner.bAlwaysMouseLook);
	else if ( Selection == 6 )
		PlayerOwner.ChangeStairLook(!PlayerOwner.bLookUpStairs);
	else if ( Selection == 7 )
		PlayerOwner.ChangeCrossHair();
/*
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.Handedness == 1 )
			PlayerOwner.ChangeSetHand("Right");
		else if ( PlayerOwner.Handedness == 0 )
			PlayerOwner.ChangeSetHand("Left");
		else
			PlayerOwner.ChangeSetHand("Center");
	}
*/
//	else if ( Selection == 9 )
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.DodgeClickTime > 0 )
			PlayerOwner.ChangeDodgeClickTime(-1);
		else
			PlayerOwner.ChangeDodgeClickTime(0.25);
	}
//	else if ( Selection == 12 )
	else if ( Selection == 11 )
		PlayerOwner.myHUD.ChangeHUD(-1);
//	else if ( Selection == 13 )
	else if ( Selection == 12 )
		PlayerOwner.UpdateBob(PlayerOwner.Bob - 0.004);
	else if ( Selection == 14 )
		KlingonHUD(PlayerOwner.myHUD).SetOverlay(!KlingonHUD(PlayerOwner.myHUD).OverlayOn);
	else 
		return false;

	return true;
}

function bool ProcessRight()
{
	if ( Selection == 1 )
	{
		if ( PlayerOwner.MyAutoAim == 1 )
			PlayerOwner.ChangeAutoAim(0.93);
		else
			PlayerOwner.ChangeAutoAim(1);
	}
	else if ( Selection == 2)
	{
		if ( PlayerOwner.MouseSensitivity < 10 ) 
			PlayerOwner.UpdateSensitivity(PlayerOwner.MouseSensitivity + 1);
	}
	else if ( Selection == 3 )
		PlayerOwner.bInvertMouse = !PlayerOwner.bInvertMouse;
	else if ( Selection == 4 )
		PlayerOwner.ChangeSnapView(!PlayerOwner.bSnapToLevel);
	else if ( Selection == 5 )
		PlayerOwner.ChangeAlwaysMouseLook(!PlayerOwner.bAlwaysMouseLook);
	else if ( Selection == 6 )
		PlayerOwner.ChangeStairLook(!PlayerOwner.bLookUpStairs);
	else if ( Selection == 7 )
		PlayerOwner.MyHUD.ChangeCrossHair(-1);
/*
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.Handedness == -1 )
			PlayerOwner.ChangeSetHand("Left");
		else if ( PlayerOwner.Handedness == 0 )
			PlayerOwner.ChangeSetHand("Right");
		else
			PlayerOwner.ChangeSetHand("Center");
	}
*/
//	else if ( Selection == 9 )
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.DodgeClickTime > 0 )
			PlayerOwner.ChangeDodgeClickTime(-1);
		else
			PlayerOwner.ChangeDodgeClickTime(0.25);
	}
//	else if ( Selection == 12 )
	else if ( Selection == 11 )
		PlayerOwner.myHUD.ChangeHUD(1);
//	else if ( Selection == 13 )
	else if ( Selection == 12 )
		PlayerOwner.UpdateBob(PlayerOwner.Bob + 0.004);
	else if ( Selection == 14 )
		KlingonHUD(PlayerOwner.myHUD).SetOverlay(!KlingonHUD(PlayerOwner.myHUD).OverlayOn);
	else
		return false;

	return true;
}

function bool ProcessSelection()
{
	local Menu ChildMenu;

	if ( Selection == 1 )
	{
		if ( PlayerOwner.MyAutoAim == 1 )
			PlayerOwner.ChangeAutoAim(0.93);
		else
			PlayerOwner.ChangeAutoAim(1);
	}
	else if ( Selection == 3 )
		PlayerOwner.bInvertMouse = !PlayerOwner.bInvertMouse;
	else if ( Selection == 4 )
		PlayerOwner.ChangeSnapView(!PlayerOwner.bSnapToLevel);
	else if ( Selection == 5 )
		PlayerOwner.ChangeAlwaysMouseLook(!PlayerOwner.bAlwaysMouseLook);
	else if ( Selection == 6 )
		PlayerOwner.ChangeStairLook(!PlayerOwner.bLookUpStairs);
	else if ( Selection == 7 )
		PlayerOwner.ChangeCrossHair();
/*
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.Handedness == 1 )
			PlayerOwner.SetHand("Right");
		else if ( PlayerOwner.Handedness == 0 )
			PlayerOwner.SetHand("Left");
		else
			PlayerOwner.SetHand("Center");
	}
*/
//	else if ( Selection == 9 )
	else if ( Selection == 8 )
	{
		if ( PlayerOwner.DodgeClickTime > 0 )
			PlayerOwner.ChangeDodgeClickTime(-1);
		else
			PlayerOwner.ChangeDodgeClickTime(0.25);
	}
//	else if ( Selection == 10)
	else if ( Selection == 9)
		ChildMenu = spawn(class'KlingonMenuKeyboard', owner);
//	else if ( Selection == 11)
	else if ( Selection == 10)
		ChildMenu = spawn(class'KlingonMenuWeapon', owner);
//	else if ( Selection == 12)
	else if ( Selection == 11)
		PlayerOwner.myHUD.ChangeHUD(1);
//	else if ( Selection == 14)
	else if ( Selection == 13)
		PlayerOwner.ConsoleCommand("PREFERENCES");
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
	PlayerOwner.myHUD.SaveConfig();
	PlayerOwner.SaveConfig();
}


function ProcessMenuEscape()
{
	PlayerOwner.myHUD.SaveConfig();
	PlayerOwner.SaveConfig();
}


function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);
	
	MenuValues[1] = string( PlayerOwner.MyAutoAim < 1 );
	MenuValues[2] = string(int(PlayerOwner.MouseSensitivity));
	MenuValues[3] = string(PlayerOwner.bInvertMouse);
	MenuValues[4] = string(PlayerOwner.bSnapToLevel);
	MenuValues[5] = string(PlayerOwner.bAlwaysMouseLook);
	MenuValues[6] = string(PlayerOwner.bLookUpStairs);
/*
	if ( PlayerOwner.Handedness == 1 )
		MenuValues[8] = LeftString;
	else if ( PlayerOwner.Handedness == 0 )
		MenuValues[8] = CenterString;
	else
		MenuValues[8] = RightString;
*/
	if ( PlayerOwner.DodgeClickTime > 0 )
	{
//		MenuValues[9] = EnabledString;
		MenuValues[8] = EnabledString;
	}
	else
	{
//		MenuValues[9] = DisabledString;
		MenuValues[8] = DisabledString;
	}
	
//	MenuValues[12] = string(PlayerOwner.MyHUD.HudMode);
	MenuValues[11] = string(PlayerOwner.MyHUD.HudMode);

	PlayerOwner.MyHUD.DrawCrossHair(Canvas, 400 * XRatio, 225 * YRatio);

	// draw icons
//	if ( Selection == 13 ) 
	if ( Selection == 12 ) 
	{	
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;	
		Canvas.bNoSmooth = True;
	}
	else
		Canvas.DrawColor = Canvas.Default.DrawColor;

//	DrawSlider(Canvas, 400, 0, 1000 * PlayerOwner.Bob, 0, 4, 12);
	DrawSlider(Canvas, 400, 0, 1000 * PlayerOwner.Bob, 0, 4, 11);

	MenuValues[14] = string(KlingonHUD(PlayerOwner.myHUD).OverlayOn);
	
	KDrawList( Canvas, 0, 0);
	KDrawChangeList(Canvas, 400, 0);
	KDrawHelpPanel(Canvas);
}

defaultproperties
{
     MenuLength=14
     HelpMessage(1)="ENABLE OR DISABLE VERTICAL AIMING HELP."
     HelpMessage(2)="ADJUST THE MOUSE SENSITIVITY, OR HOW FAR YOU HAVE TO MOVE THE MOUSE TO PRODUCE A GIVEN MOTION IN THE GAME."
     HelpMessage(3)="INVERT THE MOUSE X AXIS.  WHEN TRUE, PUSHING THE MOUSE FORWARD CAUSES YOU TO LOOK DOWN RATHER THAN UP."
     HelpMessage(4)="IF TRUE, WHEN YOU LET GO OF THE MOUSELOOK KEY THE VIEW WILL AUTOMATICALLY CENTER ITSELF."
     HelpMessage(5)="IF TRUE, THE MOUSE IS ALWAYS USED FOR LOOKING UP AND DOWN, WITH NO NEED FOR A MOUSELOOK KEY."
     HelpMessage(6)="IF TRUE, WHEN NOT MOUSE-LOOKING YOUR VIEW WILL AUTOMATICALLY BE ADJUSTED TO LOOK UP AND DOWN SLOPES AND STAIRS."
     HelpMessage(7)="CHOOSE THE CROSSHAIR APPEARING AT THE CENTER OF YOUR SCREEN"
     HelpMessage(8)="IF ENABLED, DOUBLE-CLICKING ON THE MOVEMENT KEYS (FORWARD, BACK, STRAFE LEFT, AND STRAFE RIGHT) WILL CAUSE YOU TO DO A FAST DODGE MOVE."
     HelpMessage(9)="HIT ENTER TO CUSTOMIZE KEYBOARD, MOUSE, AND JOYSTICK CONFIGURATION."
     HelpMessage(10)="HIT ENTER TO PRIORITIZE WEAPON SWITCHING ORDER."
     HelpMessage(11)="USE THE LEFT AND RIGHT ARROW KEYS TO SELECT A HEADS UP DISPLAY CONFIGURATION."
     HelpMessage(12)="ADJUST THE AMOUNT OF BOBBING WHEN MOVING."
     HelpMessage(13)="OPEN ADVANCED PREFERENCES CONFIGURATION MENU."
     HelpMessage(14)="WHEN WEARING ARMOR OR GOGGLES SHOW THE OVERLAY"
     MenuList(1)="AUTO AIM"
     MenuList(2)="MOUSE SENSITIVITY"
     MenuList(3)="INVERT MOUSE"
     MenuList(4)="LOOKSPRING"
     MenuList(5)="ALWAYS MOUSE LOOK"
     MenuList(6)="AUTO SLOPE LOOK"
     MenuList(7)="CROSSHAIR"
     MenuList(8)="DODGING"
     MenuList(9)="CUSTOMIZE CONTROLS"
     MenuList(10)="PRIORITIZE WEAPONS"
     MenuList(11)="HUD CONFIGURATION"
     MenuList(12)="VIEW BOB"
     MenuList(13)="ADVANCED OPTIONS"
     MenuList(14)="ARMOR OVERLAY"
     MenuTitle="OPTIONS MENU"
}
