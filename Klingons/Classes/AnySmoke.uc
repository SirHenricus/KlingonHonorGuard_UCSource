//=============================================================================
// AnySmoke.
//=============================================================================
class AnySmoke expands KlingonEffects;

var() class<Effects>	SmokeList[10];

var AnySmoke			AS;

function DetermineOwner()
{
	if (AnySmoke(Owner) == None) {
		AS=Self;
	}
	else {
		AS=AnySmoke(Owner);
	}
	Super.DetermineOwner();
}

state SpecialEffect
{
	function BeginState()
	{
		DetermineOwner();
		K.ChildEffect=AS.SmokeList[Rand(10)];
		Super.BeginState();
		Destroy();
	}
}

defaultproperties
{
     SmokeList(0)=Class'Klingons.BlackSmoke1'
     SmokeList(1)=Class'Klingons.BlackSmoke2'
     SmokeList(2)=Class'Klingons.WhiteSmoke1'
     SmokeList(3)=Class'Klingons.BlackSmoke1'
     SmokeList(4)=Class'Klingons.BlackSmoke2'
     SmokeList(5)=Class'Klingons.WhiteSmoke1'
     SmokeList(6)=Class'Klingons.BlackSmoke1'
     SmokeList(7)=Class'Klingons.BlackSmoke2'
     SmokeList(8)=Class'Klingons.WhiteSmoke1'
     SmokeList(9)=Class'Klingons.WhiteSmoke1'
}
