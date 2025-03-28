//=============================================================================
// AmbientSoundTrigger.
//=============================================================================
class AmbientSoundTrigger expands KlingonTrigger;

var sound	DefaultAmbientSound;

var bool	bPlaying;

simulated function BeginPlay()
{
	DefaultAmbientSound=AmbientSound;
	AmbientSound=None;
}

simulated function TriggerAmbientSound(actor Other)
{
	AmbientSound=DefaultAmbientSound;
	bPlaying=True;
}

simulated function UnTriggerAmbientSound(actor Other)
{
	AmbientSound=None;
	bPlaying=False;
}

function Touch(actor Other)
{
	if (IsRelevant(Other)) {
		TriggerAmbientSound(Other);
	}
	Super.Touch(Other);
}

function UnTouch(actor Other)
{
	if (IsRelevant(Other)) {
		UnTriggerAmbientSound(Other);
	}
	Super.UnTouch(Other);
}

state() NormalTrigger
{
	simulated function Trigger(actor Other,pawn InstigatedBy)
	{
		if (IsRelevant(InstigatedBy)) {
			if (bPlaying) {
				UnTrigger(Other,InstigatedBy);
			}
			else {
				TriggerAmbientSound(InstigatedBy);
			}
		}
	}
	simulated function UnTrigger(actor Other,pawn InstigatedBy)
	{
		if (IsRelevant(InstigatedBy)) {
			UnTriggerAmbientSound(InstigatedBy);
		}
	}
}

defaultproperties
{
}
