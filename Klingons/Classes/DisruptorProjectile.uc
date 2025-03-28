//=============================================================================
// DisruptorProjectile.
//=============================================================================
class DisruptorProjectile expands KlingonProjectiles;

auto state Flying
{
	simulated function Tick(float delta)
	{
		DrawScale=Default.DrawScale*FRand();
	}
}

defaultproperties
{
     ExplosionEffect=Class'Klingons.WhiteSmoke1'
     GlowEffect=Class'Klingons.WeaponGlow'
     HurtType=Zapped
     speed=2500.000000
     MaxSpeed=2500.000000
     Damage=25.000000
     MomentumTransfer=40000
     ImpactSound=Sound'KlingonSFX01.Weapons.Hit'
     Style=STY_Translucent
     Texture=Texture'WeaponFX01.Projectiles.dis3blu1'
     DrawScale=0.400000
     bUnlit=True
     bMeshCurvy=True
     SoundRadius=15
     SoundVolume=200
     AmbientSound=Sound'KlingonSFX01.Ambience.AmbBrig'
     LightType=LT_Steady
     LightEffect=LE_FastWave
     LightBrightness=64
     LightHue=140
     LightRadius=32
     LightPeriod=16
     LightPhase=16
     Mass=0.000000
}
