//=============================================================================
// AnyExplosion.
//=============================================================================
class AnyExplosion expands KlingonEffects;

var() class<Effects>	ExplosionList[10];

var AnyExplosion		AE;

function DetermineOwner()
{
	if (AnyExplosion(Owner) == None) {
		AE=Self;
	}
	else {
		AE=AnyExplosion(Owner);
	}
	Super.DetermineOwner();
}

state SpecialEffect
{
	function BeginState()
	{
		DetermineOwner();
		K.ChildEffect=AE.ExplosionList[Rand(10)];
		Super.BeginState();
		Destroy();
	}
}

defaultproperties
{
     ExplosionList(0)=Class'Klingons.AirExplosion1'
     ExplosionList(1)=Class'Klingons.AirExplosion2'
     ExplosionList(2)=Class'Klingons.AirExplosion3'
     ExplosionList(3)=Class'Klingons.AirExplosion2'
     ExplosionList(4)=Class'Klingons.AirExplosion1'
     ExplosionList(5)=Class'Klingons.GroundExplosion1'
     ExplosionList(6)=Class'Klingons.GroundExplosion2'
     ExplosionList(7)=Class'Klingons.GroundExplosion3'
     ExplosionList(8)=Class'Klingons.GroundExplosion2'
     ExplosionList(9)=Class'Klingons.GroundExplosion1'
     bHidden=True
     RemoteRole=ROLE_SimulatedProxy
     Texture=Texture'WeaponFX01.Explosions.test006'
}
