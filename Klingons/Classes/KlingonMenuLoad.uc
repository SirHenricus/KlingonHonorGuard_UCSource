//=============================================================================
// KlingonMenuLoad.
//=============================================================================
class KlingonMenuLoad expands KlingonMenuSlot
	localized
	config;

var() localized string[32] RestartString;


function bool ProcessSelection()
{
	if ( ( Selection == 10 ) && ( Level.Title != "KLINGON" ) )
	{
		PlayerOwner.ReStartLevel(); 
		return true;
	}
	if ( SlotNames[Selection - 1] ~= EmptyString )
		return false;
	bExitAllMenus = true;
	PlayerOwner.ClientMessage("");
	if ( Left(SlotNames[Selection - 1], 4) == "Net:" )
		Level.ServerTravel( "?load=" $ (Selection - 2), false);
	else
		PlayerOwner.ClientTravel( "?load=" $ (Selection - 1), TRAVEL_Absolute, false);
	return true;
}


function DrawMenu(canvas Canvas)
{
	DrawBackGround(Canvas, false);
	
	if ( Level.Title != "KLINGON" )
		MenuValues[MenuLength] = RestartString$Level.Title;

	DrawSlots(Canvas, 320, 122);	
}

defaultproperties
{
     RestartString="Restart "
     MenuLength=10
     MenuTitle="LOAD GAME"
}
