//=============================================================================
// KlingonEvents.
//=============================================================================
class KlingonEvents expands KlingonTrigger;

var() bool			bOnlyWhenSeen,
					bRandomDelay;
var() float			Delay,
					EventLifeSpan;
var() class<Actor>	EventClass;

function bool IsNetRelevant(class<Actor> AClass)
{
	if (Level.NetMode != NM_StandAlone) {
		if (!AClass.Default.bNet) {
			return(False);
		}
	}
	return(True);
}

function SpawnEvent()
{
	local actor		A;

	if (Event != '') {
		foreach AllActors(class 'Actor',A,Event) {
			A.Trigger(Self,Instigator);
		}
	}
	if (EventClass != None) {
		if (IsNetRelevant(EventClass)) {
			A=Spawn(EventClass,Self);
			A.SetRotation(Rotation);
			A.LifeSpan=EventLifeSpan;
			A.DrawScale=DrawScale;
		}
	}
}

state() TriggerTouch
{
	function Touch(actor Other)
	{
		Super.Trigger(Other,Pawn(Other));
		SpawnEvent();
	}
}

state() TriggerTimed
{
	function Touch(actor Other)
	{
	}
	function Timer()
	{
		SpawnEvent();
		if (bRandomDelay) {
			SetTimer(FRand()*Delay,False);
		}
		else {
			SetTimer(Delay,False);
		}
	}
	function BeginState()
	{
		if (bRandomDelay) {
			SetTimer(FRand()*Delay,False);
		}
		else {
			SetTimer(Delay,False);
		}
	}
}

state() TriggerSequence
{
	function Touch(actor Other)
	{
	}
	function Timer()
	{
		SpawnEvent();
	}
	function Trigger(actor Other,pawn TouchedBy)
	{
		Super.Trigger(Other,TouchedBy);
		if (Delay == 0.0) {
			Timer();
		}
		else {
			if (bRandomDelay) {
				SetTimer(FRand()*Delay,False);
			}
			else {
				SetTimer(Delay,False);
			}
		}
	}
}

defaultproperties
{
     bDirectional=True
     InitialState=TriggerTimed
}
