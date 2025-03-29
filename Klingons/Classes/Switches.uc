//=============================================================================
// Switches.
//=============================================================================
class Switches expands KlingonTrigger
	abstract;

var() texture	SwitchOnTex;
var() sound		SwitchOnSound;
var() sound		SwitchOffSound;

var actor	Activator;

replication
{
	reliable if (Role == ROLE_Authority)
		Activator;
}

simulated function SwitchOnFunction()
{
	if (Skin == SwitchOnTex) {
		Skin=None;
		if (SwitchOffSound != None) {
			PlaySound(SwitchOffSound);
		}
	}
	else {
		Skin=SwitchOnTex;
		if (SwitchOnSound != None) {
			PlaySound(SwitchOnSound);
		}
	}
}

defaultproperties
{
     bHidden=False
     bMeshCurvy=False
}
