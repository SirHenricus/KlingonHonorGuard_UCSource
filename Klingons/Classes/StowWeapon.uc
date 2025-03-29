//=============================================================================
// StowWeapon.
//=============================================================================
class StowWeapon expands KlingonTriggers;

var() bool		bHideHUD;
var() bool		bStowWeapon;

auto state TriggerWaiting
{
	function Trigger(actor Other,pawn OtherInstigator)
	{
		if (KlingonPlayer(OtherInstigator) != None) {
			if (bStowWeapon) {
				KlingonPlayer(OtherInstigator).StowWeapon();
			}
			if (bHideHUD) {
				KlingonPlayer(OtherInstigator).HideHUD();
			}
		}
	}
}

defaultproperties
{
     bHideHUD=True
     bStowWeapon=True
     Texture=Texture'Engine.S_SpecialEvent'
}
