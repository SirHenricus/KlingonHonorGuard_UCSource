//=============================================================================
// Gibs.
//=============================================================================
class Gibs expands Carcass;

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

defaultproperties
{
     bMeshCurvy=False
}
