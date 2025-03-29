//=============================================================================
// ParticleProjectile.
//=============================================================================
class ParticleProjectile expands KlingonProjectiles;

defaultproperties
{
     TrailEffect=Class'Klingons.ParticleTrail'
     TrailTimer=0.100000
     TrailPercentage=1.000000
     ExplosionEffect=Class'Klingons.ParticleExplosion'
     GlowEffect=Class'Klingons.WeaponGlow'
     ExplosionRadius=1000.000000
     HurtType=Disintegrated
     ScorchEffect=Class'Klingons.Scorch01'
     ScorchScale=1.000000
     speed=800.000000
     MaxSpeed=800.000000
     Damage=1000.000000
     MomentumTransfer=100000
     SpawnSound=Sound'KlingonSFX01.Weapons.BFGSpawn2'
     ImpactSound=Sound'KlingonSFX01.Weapons.BFGImpact'
     Style=STY_Translucent
     Texture=Texture'WeaponFX01.Projectiles.redpart001'
     bUnlit=True
     bMeshCurvy=True
     SoundRadius=64
     SoundVolume=255
     AmbientSound=Sound'KlingonSFX01.Weapons.BFGAmbLp'
     LightType=LT_Steady
     LightEffect=LE_Shock
     LightBrightness=255
     LightHue=16
     LightRadius=64
     LightPeriod=16
     LightPhase=16
}
