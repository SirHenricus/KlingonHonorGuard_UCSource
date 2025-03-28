//=============================================================================
// DamageArea.
//=============================================================================
class DamageArea expands DamageEffects;

var() float		DamageRadius;

var DamageArea	DA;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (DamageArea(K) == None) {
		DA=Self;
	}
	else {
		DA=DamageArea(K);
	}
}

state SpecialEffect
{
	simulated function BeginState()
	{
		local float		D;

		Super.BeginState();
		D=DE.DamageAmount*FClamp(FRand(),DE.DamagePercent,1.0);
		HurtRadius(D,DA.DamageRadius,DE.HurtType,DE.MomentumTransfer,Location);
		Destroy();
	}
}

defaultproperties
{
     DamageRadius=300.000000
     DamageAmount=100.000000
     MomentumTransfer=40000.000000
     Texture=Texture'Engine.S_Corpse'
}
