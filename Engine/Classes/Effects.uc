//=============================================================================
// Effects, the base class of all gratuitous special effects.
//=============================================================================
class Effects expands Actor;

var() sound 	EffectSound1;
var() sound 	EffectSound2;
var() bool bOnlyTriggerable;

defaultproperties
{
     DrawType=DT_None
     bAlwaysRelevant=True
     CollisionRadius=0.000000
     CollisionHeight=0.000000
}
