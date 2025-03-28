//=============================================================================
// KillumKillumAll.
//=============================================================================
class KillumKillumAll expands KlingonTrigger;

var() int DamageAmount;
var() sound ExplosionSound;

function Touch(actor Other)
{
	local KlingonPlayer A;
	foreach AllActors(class 'KlingonPlayer',A)
	{
		if (A != none)
		{
			A.PlaySound(ExplosionSound,SLOT_Interact,1.0,,1000);	
			A.spawn(class'BlindPlayers');
			A.TakeDamage( DamageAmount, A, A.location, vect(0,0,0), 'burned');
		}
	}
}

function Trigger(actor Other,pawn EventInstigator)
{
	Touch(EventInstigator);
}

defaultproperties
{
     DamageAmount=1000
     ExplosionSound=Sound'KlingonSFX01.Weapons.Exp3'
     bTriggerOnceOnly=True
}
