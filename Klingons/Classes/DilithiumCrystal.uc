//=============================================================================
// DilithiumCrystal.
//=============================================================================
class DilithiumCrystal expands Destructable;

#call q:\Klingons\Art\Effects\Dilithium\Final\DCrystal.mac

#exec MESH ORIGIN MESH=DilithiumCrystal X=0 Y=-125 Z=0

function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
{
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);
	AmbientGlow=Min(254,AccumulatedDamage*(255/Default.ObjectHealth));
	LightBrightness=Max(Default.LightBrightness,AmbientGlow);
}

defaultproperties
{
     ObjectHealth=30.000000
     ObjectDamagedEffect=None
     EffectWhenDestroyed=Class'Klingons.ElectricExplosion5'
     bPushable=False
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.DilithiumCrystal'
     DrawScale=0.500000
     LightType=LT_Steady
     LightEffect=LE_WateryShimmer
     LightBrightness=16
     LightHue=140
     LightRadius=32
     LightPeriod=16
     LightPhase=16
     Mass=0.000000
     Buoyancy=0.000000
}
