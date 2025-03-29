//=============================================================================
// KlingonMenuVideo.
//=============================================================================
class KlingonMenuVideo expands KlingonMenu
	config
	localized;

var() localized string[32] LowQuality;
var() localized string[32] HighQuality;
var() localized string[32] CDMusicYes;
var() localized string[32] CDMusicNo;

var float brightness;
var string[32] CurrentRes;
var string[32] CheckRes;
var string[255] AvailableRes;
var string[32] Resolutions[16];
var int resNum;
var bool NewRes;
var int SoundVol, MusicVol;
var bool bLowTextureDetail, bLowSoundQuality;
var bool bSetup;


function SetUpMenu()
{
	bSetup = true;
	CheckRes = PlayerOwner.ConsoleCommandResult("GetCurrentRes");
}


function SaveConfigs()
{
	PlayerOwner.SaveConfig();
	PlayerOwner.myHUD.SaveConfig();	
}


function Menu ExitMenu()
{
	if ( CheckRes != MenuValues[3] )
	{	
		PlayerOwner.ConsoleCommand("SetRes "$MenuValues[3]);

		CurrentRes = PlayerOwner.ConsoleCommandResult("GetCurrentRes");
		GetAvailableRes();
	}
	Super.ExitMenu();
}



function bool ProcessLeft()
{
	if ( Selection == 1 )
	{
		Brightness = FMax(0.2, Brightness - 0.1);
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.ViewportManager Brightness "$Brightness);
		PlayerOwner.ConsoleCommand("FLUSH");
		return true;
	}
	else if ( Selection == 3 )
	{
		ResNum--;
		if ( ResNum < 0 )
		{
			ResNum = ArrayCount(Resolutions);
			While ( Resolutions[ResNum] == "" )
				ResNum--;
		}
		MenuValues[3] = Resolutions[ResNum];
		return true;
	}	
	else if ( Selection == 5 )
	{
		KlingonHUD(PlayerOwner.myHUD).MusicOn = !KlingonHUD(PlayerOwner.myHUD).MusicOn;
		
		if ( KlingonHUD(PlayerOwner.myHUD).MusicOn == true )
			PlayerOwner.ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );	
		else
			PlayerOwner.ClientSetMusic( None, 0, 255, MTRAN_Instant );

		return true;
	}
	else if ( Selection == 6 )
	{
		SoundVol = Max(0, SoundVol - 32);
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume "$SoundVol);
		return true;
	}	
	else if ( Selection == 4 )
	{
		bLowTextureDetail = !bLowTextureDetail;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.ViewportManager LowDetailTextures "$bLowTextureDetail);
		return true;
	}
	else if ( Selection == 7 )
	{
		bLowSoundQuality = !bLowSoundQuality;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.AudioDevice LowSoundQuality "$bLowSoundQuality);
		return true;
	}
	return false;
}

function bool ProcessRight()
{
	local string[255] ParseString;
	local string[32] FirstString;
	local int p;

	if ( Selection == 1 )
	{
		Brightness = FMin(1, Brightness + 0.1);
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.ViewportManager Brightness "$Brightness);
		PlayerOwner.ConsoleCommand("FLUSH");
		return true;
	}
	else if ( Selection == 3 )
	{
		ResNum++;
		if ( (ResNum >= ArrayCount(Resolutions)) || (Resolutions[ResNum] == "") )
			ResNum = 0;
		MenuValues[3] = Resolutions[ResNum];
		return true;
	}	
	else if ( Selection == 5 )
	{
		KlingonHUD(PlayerOwner.myHUD).MusicOn = !KlingonHUD(PlayerOwner.myHUD).MusicOn;
		
		if ( KlingonHUD(PlayerOwner.myHUD).MusicOn == true )
			PlayerOwner.ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );	
		else
			PlayerOwner.ClientSetMusic( None, 0, 255, MTRAN_Instant );

		return true;
	}
	else if ( Selection == 6 )
	{
		SoundVol = Min(255, SoundVol + 32);
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.AudioDevice SoundVolume "$SoundVol);
		return true;
	}
	else if ( Selection == 4 )
	{
		bLowTextureDetail = !bLowTextureDetail;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.ViewportManager LowDetailTextures "$bLowTextureDetail);
		return true;
	}
	else if ( Selection == 7 )
	{
		bLowSoundQuality = !bLowSoundQuality;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.AudioDevice LowSoundQuality "$bLowSoundQuality);
		return true;
	}
	return false;
}		


function bool ProcessSelection()
{
	if ( Selection == 2 )
	{
		PlayerOwner.ConsoleCommand("TOGGLEFULLSCREEN");
		CurrentRes = PlayerOwner.ConsoleCommandResult("GetCurrentRes");
		GetAvailableRes();
		return true;
	}
	else if ( Selection == 3 )
	{
		PlayerOwner.ConsoleCommand("SetRes "$MenuValues[3]);
		CheckRes = MenuValues[3];
		NewRes = True;

		CurrentRes = PlayerOwner.ConsoleCommandResult("GetCurrentRes");
		GetAvailableRes();
		return true;
	}
	else if ( Selection == 4 )
	{
		bLowTextureDetail = !bLowTextureDetail;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.ViewportManager LowDetailTextures "$bLowTextureDetail);
		return true;
	}
	else if ( Selection == 7 )
	{
		bLowSoundQuality = !bLowSoundQuality;
		PlayerOwner.ConsoleCommand("set ini:Engine.Engine.AudioDevice LowSoundQuality "$bLowSoundQuality);
		return true;
	}
		
	return false;
}


function DrawMenu(canvas Canvas)
{
	local int i;
	local float XRatio;
	local float YRatio;	

	if ( !bSetup )
		SetupMenu();

	if ( NewRes == True )
	{
		XRatio = Canvas.ClipX * 0.0015625;
		YRatio = Canvas.ClipY * 0.0020833333333;
		NewRes = False;
	}

	DrawBackGround(Canvas, false);

	KDrawList( Canvas, 150, 0);

	// draw icons
	Brightness = float(PlayerOwner.ConsoleCommandResult("get ini:Engine.Engine.ViewportManager Brightness"));
	
	if ( Selection == 1 ) 
	{	
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;	
		Canvas.bNoSmooth = True;
	}
	else
		Canvas.DrawColor = Canvas.Default.DrawColor;

	DrawSlider(Canvas, 380, 0, (10 * Brightness - 2), 0, 1, 0);

	if ( CurrentRes == "" )
		GetAvailableRes();
	else if ( AvailableRes == "" )
		GetAvailableRes();
	
	if ( MenuValues[3] ~= CurrentRes )
		MenuValues[3] = "["$MenuValues[3]$"]";
	else
		MenuValues[3] = MenuValues[3];

	bLowTextureDetail = bool(PlayerOwner.ConsoleCommandResult("get ini:Engine.Engine.ViewportManager LowDetailTextures"));

	if ( bLowTextureDetail )
		MenuValues[4] = LowQuality;
	else
		MenuValues[4] = HighQuality;

	if ( KlingonHUD(PlayerOwner.myHUD).MusicOn == true )
		MenuValues[5] = CDMusicYes;
	else
		MenuValues[5] = CDMusicNo;
	
	if ( Selection == 5 ) 
	{	
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;	
		Canvas.bNoSmooth = True;
	}
	else
		Canvas.DrawColor = Canvas.Default.DrawColor;

//	DrawSlider(Canvas, 380, 0, MusicVol, 0, 32, 4);

	SoundVol = int(PlayerOwner.ConsoleCommandResult("get ini:Engine.Engine.AudioDevice SoundVolume"));

	if ( Selection == 6 ) 
	{	
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;	
		Canvas.bNoSmooth = True;
	}
	else
		Canvas.DrawColor = Canvas.Default.DrawColor;

	DrawSlider(Canvas, 380, 0, SoundVol, 0, 32, 5);

	bLowSoundQuality = bool(PlayerOwner.ConsoleCommandResult("get ini:Engine.Engine.AudioDevice LowSoundQuality"));
	if ( bLowSoundQuality )
		MenuValues[7] = LowQuality;
	else
		MenuValues[7] = HighQuality;

	KDrawChangeList(Canvas, 380, 0);	
	
	// Draw help panel
	KDrawHelpPanel(Canvas);
}

function GetAvailableRes()
{
	local int p,i;
	local string[255] ParseString;

	AvailableRes = PlayerOwner.ConsoleCommandResult("GetRes");
	resNum = 0;
	ParseString = AvailableRes;
	p = InStr(ParseString, " ");
	while ( (ResNum < ArrayCount(Resolutions)) && (p != -1) ) 
	{
		Resolutions[ResNum] = Left(ParseString, p);
		ParseString = Right(ParseString, Len(ParseString) - p - 1);
		p = InStr(ParseString, " ");
		ResNum++;
	}

	Resolutions[ResNum] = ParseString;
	for ( i=ResNum+1; i< ArrayCount(Resolutions); i++ )
		Resolutions[i] = "";

	CurrentRes = PlayerOwner.ConsoleCommandResult("GetCurrentRes");
	MenuValues[3] = CurrentRes;
	for ( i=0; i< ResNum+1; i++ )
		if ( MenuValues[3] ~= Resolutions[i] )
		{
			ResNum = i;
			return;
		}

	ResNum = 0;
	MenuValues[3] = Resolutions[0];
}

defaultproperties
{
     LowQuality="Low"
     HighQuality="High"
     CDMusicYes="Yes"
     CDMusicNo="No"
     MenuLength=7
     HelpMessage(1)="ADJUST DISPLAY BRIGHTNESS USING THE LEFT AND RIGHT ARROW KEYS."
     HelpMessage(2)="DISPLAY KHG IN A WINDOW. NOTE THAT GOING TO A SOFTWARE DISPLAY MODE MAY REMOVE HIGH DETAIL ACTORS THAT WERE VISIBLE WITH HARDWARE ACCELERATION."
     HelpMessage(3)="USE THE LEFT AND RIGHT ARROWS TO SELECT A RESOLUTION, AND PRESS ENTER TO SELECT THIS RESOLUTION."
     HelpMessage(4)="USE THE LOW TEXTURE DETAIL OPTION TO IMPROVE PERFORMANCE.  CHANGES TO THIS SETTING WILL TAKE EFFECT ON THE NEXT LEVEL CHANGE."
     HelpMessage(5)="TURN THE CD MUSIC ON OR OFF."
     HelpMessage(6)="ADJUST THE VOLUME OF SOUND EFFECTS USING THE LEFT AND RIGHT ARROW KEYS."
     HelpMessage(7)="USE THE LOW SOUND QUALITY OPTION TO IMPROVE PERFORMANCE ON MACHINES WITH >=32 MB RAM.  CHANGES TO THIS SETTING WILL TAKE EFFECT ON THE NEXT LEVEL CHANGE."
     MenuList(1)="BRIGHTNESS"
     MenuList(2)="TOGGLE FULLSCREEN"
     MenuList(3)="SELECT RESOLUTION"
     MenuList(4)="TEXTURE DETAIL"
     MenuList(5)="CD MUSIC"
     MenuList(6)="SOUND VOLUME"
     MenuList(7)="SOUND QUALITY"
     MenuTitle="AUDIO/VIDEO"
}
