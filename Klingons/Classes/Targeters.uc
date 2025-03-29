//=============================================================================
// Targeters.
//=============================================================================
class Targeters expands KlingonEffects;

var() texture	AcquiredSymbol;
var() texture	InSightSymbol;

var bool		bInSight;

simulated function EffectAnim(float delta)
{
	Super.EffectAnim(delta);
	if (bInSight) {
		Texture=InSightSymbol;
	}
	else {
		Texture=AcquiredSymbol;
	}
}

defaultproperties
{
     AcquiredSymbol=Texture'KlingonHUD.Crosshairs.Crhr_r07'
     InSightSymbol=Texture'KlingonHUD.Crosshairs.Crhr_r10'
     RemoteRole=ROLE_DumbProxy
     Texture=Texture'KlingonHUD.Crosshairs.Crhr_r07'
     DrawScale=2.000000
     bOnlyOwnerSee=True
}
