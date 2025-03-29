//=============================================================================
// RisingFlames.
//=============================================================================
class RisingFlames expands DamageEffects;

var() float			Speed;

var RisingFlames	RF;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (RisingFlames(K) == None) {
		RF=Self;
	}
	else {
		RF=RisingFlames(K);
	}
}

state SpecialEffect
{
	simulated function BeginState()
	{
		Super.BeginState();
		if (Speed != 0.0) {
			Velocity=(vector(Rotation)*RF.Speed)*(1.0+FRand());
			SetPhysics(PHYS_Falling);
		}
	}
}

defaultproperties
{
     speed=600.000000
     DamageAmount=5.000000
     DamagePercent=0.800000
     MomentumTransfer=1.000000
     HurtType=burned
     ScaleRate=-0.020000
     EffectTimer=0.100000
     Frames(0)=Texture'WeaponFX01.Explosions.grndx001'
     Frames(1)=Texture'WeaponFX01.Explosions.grndx002'
     Frames(2)=Texture'WeaponFX01.Explosions.grndx003'
     Frames(3)=Texture'WeaponFX01.Explosions.grndx004'
     Frames(4)=Texture'WeaponFX01.Explosions.grndx005'
     Frames(5)=Texture'WeaponFX01.Explosions.grndx004'
     Frames(6)=Texture'WeaponFX01.Explosions.grndx003'
     Frames(7)=Texture'WeaponFX01.Explosions.grndx002'
     Frames(8)=Texture'WeaponFX01.Explosions.grndx001'
     Frames(9)=Texture'WeaponFX01.Explosions.grndx002'
     Frames(10)=Texture'WeaponFX01.Explosions.grndx003'
     Frames(11)=Texture'WeaponFX01.Explosions.grndx004'
     Frames(12)=Texture'WeaponFX01.Explosions.grndx005'
     Frames(13)=Texture'WeaponFX01.Explosions.grndx004'
     Frames(14)=Texture'WeaponFX01.Explosions.grndx003'
     Frames(15)=Texture'WeaponFX01.Explosions.grndx002'
     Frames(16)=Texture'WeaponFX01.Explosions.grndx001'
     Frames(17)=Texture'WeaponFX01.Explosions.grndx002'
     Frames(18)=Texture'WeaponFX01.Explosions.grndx003'
     Frames(19)=Texture'WeaponFX01.Explosions.grndx002'
     Texture=Texture'WeaponFX01.Explosions.grndx001'
     DrawScale=0.500000
     LightType=LT_Steady
     LightEffect=LE_FireWaver
     LightBrightness=64
     LightHue=16
     LightRadius=16
     LightPeriod=16
     LightPhase=16
}
