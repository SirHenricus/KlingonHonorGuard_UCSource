//=============================================================================
// AssaultProjectile.
//=============================================================================
class AssaultProjectile expands KlingonProjectiles;

var() class<Projectile>	ProjClass;
var() int				NumProjectiles;
var() float				Dispersion;
var() float				DamageAmount;

auto state Flying
{
	simulated function Tick(float delta)
	{
		DrawScale=Default.DrawScale*FRand();
	}
	simulated function Expired()
	{
		local int			i;
		local rotator		NewRotation;
		local projectile	P;

		for (i=0 ; i < NumProjectiles ; i++) {
			NewRotation=Rotation;
			NewRotation.Yaw+=(Dispersion*(FRand()-0.5));
			NewRotation.Pitch+=(Dispersion*(FRand()-0.5));
			P=Spawn(ProjClass,Instigator,,Location,NewRotation);
			P.Damage=DamageAmount;
			if (KlingonProjectiles(P) != None) {
				KlingonProjectiles(P).HurtType=HurtType;
			}
		}
		Explode(Location,vect(0,0,0));
	}
}

defaultproperties
{
     ProjClass=Class'Klingons.DisruptorProjectile'
     NumProjectiles=3
     Dispersion=1500.000000
     DamageAmount=10.000000
     ExplosionEffect=Class'Klingons.AssaultExplosion'
     GlowEffect=Class'Klingons.WeaponGlow'
     HurtType=Blasted
     speed=1500.000000
     MaxSpeed=1500.000000
     Damage=20.000000
     MomentumTransfer=40000
     ImpactSound=Sound'KlingonSFX01.Weapons.Exp2'
     LifeSpan=0.250000
     Style=STY_Translucent
     Texture=Texture'WeaponFX01.Projectiles.dis3blu2'
     DrawScale=0.500000
     bUnlit=True
     bMeshCurvy=True
     LightType=LT_Steady
     LightEffect=LE_FastWave
     LightBrightness=128
     LightHue=140
     LightRadius=32
     LightPeriod=16
     LightPhase=16
     Mass=0.000000
}
