//=============================================================================
// TimerTrigger.
//=============================================================================
class TimerTrigger expands KlingonTrigger;

var() bool		bTimerEnabled;
var() float		TimerSetting;
var() float		TimerExpiration;
var() float		TimerResolution;

var bool TimerWasTriggered;

simulated function PlayerTimersOn()
{
	local PlayerPawn	P;
	local KlingonHUD	K;

	foreach AllActors(class 'PlayerPawn',P) {
		K=KlingonHUD(P.myHUD);
		if (K != None) {
			K.TimerStart();
		}
	}
	bTimerEnabled=True;
	SetTimer(TimerResolution,True);
	PlayerTimersSet(TimerSetting);
}

simulated function PlayerTimersOff()
{
	local PlayerPawn	P;
	local KlingonHUD	K;

	foreach AllActors(class 'PlayerPawn',P) {
		K=KlingonHUD(P.myHUD);
		if (K != None) {
			K.TimerStop();
		}
	}
	bTimerEnabled=False;
	SetTimer(0,False);
}

simulated function PlayerTimersSet(float NewTime)
{
	local PlayerPawn	P;
	local KlingonHUD	K;

	foreach AllActors(class 'PlayerPawn',P) {
		K=KlingonHUD(P.myHUD);
		if (K != None) {
			K.TimerSet(NewTime);
		}
	}
}

simulated function TriggerTimerEvent()
{
	local actor			A;

	if (Event != '') {
		foreach AllActors(class 'Actor',A,Event) {
			A.Trigger(Self,Instigator);
		}
	}
	PlayerTimersOff();
}

simulated function TriggerFunction()
{
	if (bTimerEnabled) {
		PlayerTimersOff();
	}
	else {
		PlayerTimersOn();
	}
}


function Touch(actor Other)
{	
	if (bTriggerOnceOnly)
	{
		if (TimerWasTriggered == false)
		{
			TimerWasTriggered = true;
			TriggerFunction();	
		}
	}
	else
		TriggerFunction();	
	
}

state() TimerCountDown
{
	simulated function Trigger(actor Other,pawn InstigatedBy)
	{
		TriggerFunction();
		Instigator=InstigatedBy;
	}
	simulated function Timer()
	{
		if (TimerSetting > 0) {
			TimerSetting-=TimerResolution;
		}
		if (TimerSetting <= TimerExpiration) {
			TriggerTimerEvent();
		}
		PlayerTimersSet(TimerSetting);
	}
Begin:
	if (bTimerEnabled) {
		PlayerTimersSet(TimerSetting);
		PlayerTimersOn();
	}
}

state() TimerCountUp
{
	simulated function Trigger(actor Other,pawn InstigatedBy)
	{
		TriggerFunction();
		Instigator=InstigatedBy;
	}
	simulated function Timer()
	{
		if (TimerSetting > 0) {
			TimerSetting+=TimerResolution;
		}
		if (TimerSetting >= TimerExpiration) {
			TriggerTimerEvent();
		}
		PlayerTimersSet(TimerSetting);
	}
Begin:
	if (bTimerEnabled) {
		PlayerTimersSet(TimerSetting);
		PlayerTimersOn();
	}
}

defaultproperties
{
     TimerResolution=1.000000
     InitialState=TimerCountDown
     bCollideActors=False
}
