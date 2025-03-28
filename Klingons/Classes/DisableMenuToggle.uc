//=============================================================================
// DisableMenuToggle.
//=============================================================================
class DisableMenuToggle expands Triggers;

// When triggered.
function Trigger( actor Other, pawn EventInstigator )
{
	if (KlingonPlayer(EventInstigator) != none)
	{
		if (KlingonHud(KlingonPlayer(EventInstigator).MyHud).bAllowMenu)
			KlingonHud(KlingonPlayer(EventInstigator).MyHud).AllowMenu(false);
		else
			KlingonHud(KlingonPlayer(EventInstigator).MyHud).AllowMenu(true);
	}
}

defaultproperties
{
}
