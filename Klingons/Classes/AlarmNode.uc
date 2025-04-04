//=============================================================================
// AlarmNode.
//=============================================================================
class AlarmNode expands NavigationPoint;


var() name NextAlarm; //next point to go to
var() float pausetime; //how long to pause here
var() float ducktime; //how long to pause after playing anim before starting attack while paused
var	 vector lookdir; //direction to look while stopped
var() name AlarmAnim;
var() bool bStrafeTo;
var() bool bAttackWhilePaused;
var() bool bNoFail;
var() bool bStopIfNoEnemy;
var() bool bKillMe;	// tells event triggered creatures to kill alarm triggerer, even if not normally
					// hate
var() bool bDestroyAlarmTriggerer;
var() name ShootTarget;
var() sound AlarmSound;
var	actor	NextAlarmObject;

function PreBeginPlay()
{
	if ( !bAttackWhilePaused && (pausetime > 0.0) )
		lookdir = 200 * vector(Rotation);

	foreach AllActors(class 'Actor', NextAlarmObject, NextAlarm)
		break; 
	
	super.PreBeginPlay();
}

defaultproperties
{
}
