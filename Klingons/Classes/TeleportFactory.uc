//=============================================================================
// TeleportFactory.
//=============================================================================
class TeleportFactory expands CreatureFactory;

var() class<Effects>			TeleportEffect;
var() sound						TeleportSound;

var Effects						T;
var int							TeleportAttempts;

auto state TriggerWaiting
{
	function Trigger(actor Other,pawn EventInstigator)
	{
		if (T == None) {
			if (TeleportEffect != None) {
				T=Spawn(TeleportEffect);
				T.DrawScale=CreatureClass.Default.DrawScale;
				if (Level.NetMode != NM_DedicatedServer) {
					PlaySound(TeleportSound);
				}
			}
		}
		Super.Trigger(Other,EventInstigator);
		GotoState('TeleportIn');
	}
}

state TeleportIn
{
	function Timer()
	{
		NewCreature.ScaleGlow+=0.1;
		if (NewCreature.ScaleGlow >= 1.0) {
			NewCreature.ScaleGlow=NewCreature.Default.ScaleGlow;
			NewCreature.Style=NewCreature.Default.Style;
			GotoState('TriggerWaiting');
		}
	}
	function EndState()
	{
		T.GotoState('TeleportEnd');
	}
Begin:
	if (NewCreature != None) {
		if (pawn(NewCreature) != none)
			NewCreature.GotoState('Sleeping');
		NewCreature.ScaleGlow=0.0;
		NewCreature.Style=STY_Translucent;
		SetTimer(0.1,True);
	}
	else {
		GotoState('TriggerWaiting');
	}
}

defaultproperties
{
     TeleportEffect=Class'Klingons.TeleportParticles'
     TeleportSound=Sound'KlingonSFX01.Effects.Transporter'
     SpawnStartSound=Sound'KlingonSFX01.Effects.Transporter'
}
