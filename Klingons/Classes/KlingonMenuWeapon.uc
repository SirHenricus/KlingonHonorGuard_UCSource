//=============================================================================
// KlingonMenuWeapon.
//=============================================================================
class KlingonMenuWeapon expands KlingonMenu
	localized;

var int Slot[21];
var bool bInitLength;

function bool ProcessLeft()
{
	local name temp;

	if ( Selection > 1 )
	{
		temp = PlayerOwner.WeaponPriority[Slot[Selection]];
		PlayerOwner.WeaponPriority[Slot[Selection]] = PlayerOwner.WeaponPriority[Slot[Selection - 1]];
		PlayerOwner.WeaponPriority[Slot[Selection - 1]] = temp;
		Selection--;
	}
	else 
		return false;

	return true;
}

function bool ProcessRight()
{
	local name temp;

	if ( Selection < MenuLength )
	{
		temp = PlayerOwner.WeaponPriority[Slot[Selection]];
		PlayerOwner.WeaponPriority[Slot[Selection]] = PlayerOwner.WeaponPriority[Slot[Selection + 1]];
		PlayerOwner.WeaponPriority[Slot[Selection + 1]] = temp;
		Selection++;
	}
	else
		return false;

	return true;
}

function SaveConfigs()
{
	PlayerOwner.SaveConfig();
	PlayerOwner.ServerUpdateWeapons();
}

function DrawMenu(canvas Canvas)
{
	local int i, j;

	DrawBackGround(Canvas, false);
			
	j = 1;
	MenuLength = 0;
	for ( i=19; i>=0; i-- )
	{
		if ( PlayerOwner.WeaponPriority[i] != '' )
		{
			MenuLength++;
			Slot[j] = i;
			MenuValues[j] = String(PlayerOwner.WeaponPriority[i]);
			j++;
		}
	}
	
	KDrawChangeList(Canvas, 320, 0);		
}

defaultproperties
{
     MenuTitle="WEAPON PRIORITY"
}
