//=============================================================================
// ParticleExplosion.
//=============================================================================
class ParticleExplosion expands Explosions;

auto state SpecialEffect
{
	function Tick(float delta)
	{
		Super.Tick(delta);
		if (LightBrightness > 0) {
			LightBrightness=int(K.ScaleGlow*255.0);
		}
	}
}

defaultproperties
{
     ScaleRate=0.100000
     ScaleGlowRate=-0.020000
     EffectTimer=0.000000
     EffectSound=Sound'KlingonSFX01.Weapons.Exp5'
     ChildEffect=Class'Klingons.ParticleWave'
     Texture=Texture'WeaponFX01.Projectiles.dis3red'
     LightType=LT_Steady
     LightEffect=LE_FastWave
     LightBrightness=255
     LightRadius=128
     Mass=0.000000
}
