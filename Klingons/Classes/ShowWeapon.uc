//=============================================================================
// ShowWeapon.
//=============================================================================
class ShowWeapon expands KlingonTriggers;

var() bool		bShowHUD;
var() bool		bShowWeapon;

function Trigger(actor Other,pawn OtherInstigator)
{
	if (KlingonPlayer(OtherInstigator) != None) {
		if (bShowWeapon) {
			KlingonPlayer(OtherInstigator).ShowWeapon();
		}
		if (bShowHUD) {
			KlingonPlayer(OtherInstigator).ShowHUD();
		}
	}
}

defaultproperties
{
     bShowHUD=True
     bShowWeapon=True
     Texture=Texture'Engine.S_SpecialEvent'
}
