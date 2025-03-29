//=============================================================================
// PainActor.
//=============================================================================
class PainActor expands KlingonDecorations;

var() float		DamageAmount;
var() float		DamageFrequency;
var() name		DamageType;
var() bool		bTriggerOnceOnly;

var actor		A;
var bool		bActive;

function TimerFunction()
{
	local int	i;

	if (!bActive) {
		return;
	}
	foreach TouchingActors(class 'Actor',A) {
		A.TakeDamage(DamageAmount,None,Location,vect(0,0,0),DamageType);
	}
	if (bTriggerOnceOnly) {
		Destroy();
	}
}

auto state() PainDamage
{
	function Timer()
	{
		TimerFunction();
	}
	function BeginState()
	{
		SetTimer(DamageFrequency,True);
		bActive=True;
	}
}

state() TriggerDamage
{
	function Trigger(actor Other,pawn EventInstigator)
	{
		bActive=!bActive;
	}
	function Timer()
	{
		TimerFunction();
	}
	function BeginState()
	{
		SetTimer(DamageFrequency,True);
		bActive=False;
	}
}

defaultproperties
{
     bHidden=True
     Texture=Texture'Engine.S_Corpse'
     bCollideActors=True
}
