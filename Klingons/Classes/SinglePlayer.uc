//=============================================================================
// SinglePlayer.
//
// default game info is normal single player
//
//=============================================================================
class SinglePlayer expands KlingonGameInfo
	config;

/*	LB
function Killed(pawn Killer,pawn Other,name DamageType)
{
	Super.Killed(Killer,Other,DamageType);
}	

function DiscardInventory(Pawn Other)
{
	if (Other.Weapon != None) {
		Other.Weapon.PickupViewScale*=0.7;
	}
	Super.DiscardInventory(Other);
}
*/

function PlayTeleportEffect(actor Incoming,bool bOut,bool bSound)
{
	local TeleportEffects	T;

	if (TeleportEffect != None) {
		T=Spawn(TeleportEffect,Incoming,,Incoming.Location,Incoming.Rotation);
		if (T != None) {
			T.DrawScale=Incoming.DrawScale;
			T.TeleportDelay=2.0;
		}
	}
	if (TeleportSound != None) {
		Incoming.PlaySound(TeleportSound);
	}
}

defaultproperties
{
}
