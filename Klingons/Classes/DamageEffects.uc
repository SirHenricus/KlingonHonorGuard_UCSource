//=============================================================================
// DamageEffects.
//=============================================================================
class DamageEffects expands KlingonEffects
	abstract;

var() float			DamageAmount;
var() float			DamagePercent;
var() float			MomentumTransfer;
var() name			HurtType;

var DamageEffects	DE;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (DamageEffects(K) == None) {
		DE=Self;
	}
	else {
		DE=DamageEffects(K);
	}
}

state SpecialEffect
{
	simulated function Touch(actor Other)
	{
		local float		Damage;
		local vector	Momentum;

		if (Effects(Other) == None) {
			DetermineOwner();
			Damage=DE.DamageAmount*FClamp(FRand(),DE.DamagePercent,1.0);
			Momentum=Velocity*MomentumTransfer;
			Other.TakeDamage(Damage,None,Other.Location,Momentum,DE.HurtType);
		}
	}
}

defaultproperties
{
     DamagePercent=1.000000
     MomentumTransfer=1000.000000
     RemoteRole=ROLE_SimulatedProxy
     CollisionRadius=16.000000
     CollisionHeight=16.000000
     bCollideActors=True
}
