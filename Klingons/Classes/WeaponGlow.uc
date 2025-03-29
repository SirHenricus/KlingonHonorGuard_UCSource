//=============================================================================
// WeaponGlow.
//=============================================================================
class WeaponGlow expands Trails;

simulated function Spawned()
{
	if (KlingonProjectiles(Owner) != None) {
		LightHue=KlingonProjectiles(Owner).LightHue;
		LightSaturation=KlingonProjectiles(Owner).LightSaturation;
	}
}

simulated function EffectAnim(float delta)
{
	Super.EffectAnim(delta);
	LightBrightness--;
	if (LightBrightness <= 0) {
		Destroy();
		return;
	}
}

defaultproperties
{
     bOnlyWhenSeen=False
     EffectTimer=0.100000
     bHidden=True
     Style=STY_None
     LightType=LT_Steady
     LightBrightness=128
     LightHue=16
     LightRadius=4
     LightPeriod=16
     LightPhase=16
}
