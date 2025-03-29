//=============================================================================
// Tremor.
//=============================================================================
class Tremor expands KlingonTrigger;

var(Trigger) float	TremorRadius;
var(Trigger) float	TremorMagnitude;
var(Trigger) float	TremorTime;
var(Trigger) sound	TremorSound;

function Trigger(actor Other,pawn Instigator)
{
	local PlayerPawn	P;

	foreach RadiusActors(class 'PlayerPawn',P,TremorRadius) {
		P.ShakeView(TremorTime,TremorMagnitude,0.0);
	}
	PlaySound(TremorSound);
}

function Touch(actor Other)
{
	if (IsRelevant(Other)) {
		Super.Touch(Other);
		Trigger(Other,Other.Instigator);
	}
}

defaultproperties
{
}
