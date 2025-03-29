//=============================================================================
// RandomFlames.
//=============================================================================
class RandomFlames expands DamageEffects;

var() class<Effects>	FlameList[5];

var RandomFlames		RF;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (RandomFlames(K) == None) {
		RF=Self;
	}
	else {
		RF=RandomFlames(K);
	}
}

state SpecialEffect
{
	simulated function BeginState()
	{
		local int	i;

		Super.BeginState();
		i=Rand(5);
		if (RF.FlameList[i] != None) {
			Spawn(RF.FlameList[i]);
		}
		Destroy();
	}
}

defaultproperties
{
     HurtType=burned
}
