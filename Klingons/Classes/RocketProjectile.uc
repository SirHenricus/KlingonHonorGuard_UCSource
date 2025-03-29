//=============================================================================
// RocketProjectile.
//=============================================================================
class RocketProjectile expands KlingonProjectiles;

#call q:\Klingons\Art\Projectiles\NewRocket\Final\NewRocket1.mac

#exec MESH ORIGIN MESH=ProjNewRocket X=0 Y=0 Z=0 YAW=64

var() name		MeshAnim;

auto state Flying
{
	simulated function Timer()
	{
		local actor		A;

		if (Physics == PHYS_None) {
			return;
		}
		if (TrailEffect != None && FRand() < TrailPercentage) {
			A=Spawn(TrailEffect);
			if (A != None) {
				A.Velocity=-(vector(Rotation)*speed)*FRand();
				A.SetPhysics(PHYS_Projectile);
			}
		}
	}
	simulated function Tick(float delta)
	{
		local actor		A;

		if (Physics == PHYS_None) {
			return;
		}
		if (TrailEffect != None && FRand() < TrailPercentage) {
			A=Spawn(TrailEffect);
			A.Velocity=-(vector(Rotation)*speed);
			A.SetPhysics(PHYS_Projectile);
		}
	}
	simulated function BeginState()
	{
		Super.BeginState();
		if (MeshAnim != '') {
			LoopAnim(MeshAnim,0.5);
		}
	}
}

defaultproperties
{
     MeshAnim=Static
     TrailEffect=Class'Klingons.RocketTrail'
     WaterEffect=Class'Klingons.BlackSmoke'
     TrailTimer=0.100000
     TrailPercentage=1.000000
     ExplosionEffect=Class'Klingons.AirExplosion'
     ExplosionRadius=300.000000
     HurtType=exploded
     ScorchEffect=Class'Klingons.Scorch01'
     ScorchScale=0.500000
     speed=750.000000
     MaxSpeed=1500.000000
     Damage=50.000000
     MomentumTransfer=80000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.ProjNewRocket'
     DrawScale=0.500000
     bUnlit=True
     SoundVolume=255
     AmbientSound=Sound'KlingonSFX01.Weapons.RocketLp'
     CollisionRadius=8.000000
     CollisionHeight=4.000000
     bProjTarget=True
     LightType=LT_Steady
     LightEffect=LE_FireWaver
     LightBrightness=255
     LightHue=16
     LightRadius=32
     LightPeriod=16
     LightPhase=16
     bFixedRotationDir=True
     Mass=50.000000
     RotationRate=(Roll=50000)
}
