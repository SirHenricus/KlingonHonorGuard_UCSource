//=============================================================================
// PushActor.
//=============================================================================
class PushActor expands KlingonDecorations;

var() float		PushSpeed;
var() float		PushFrequency;
var() bool		bPushActorOn;

auto state Pushing
{
	function Timer()
	{
		local actor		Other;
		local vector	V;

		foreach VisibleCollidingActors(class 'Actor',Other,CollisionRadius) {
			if (Other.Mass != 0.0) {
				V=vector(Rotation)*PushSpeed;
				Other.Velocity+=V;
			}
		}
	}
	function Tick(float delta)
	{
		Timer();
	}
	function Trigger(actor Other,pawn EventInstigator)
	{
		if (bPushActorOn) {
			bPushActorOn=False;
			if (PushFrequency != 0.0) {
				SetTimer(0.0,False);
			}
			else {
				Disable('Tick');
			}
		}
		else {
			bPushActorOn=True;
			if (PushFrequency != 0.0) {
				SetTimer(PushFrequency,True);
			}
			else {
				Enable('Tick');
			}
		}
	}
Begin:
	Disable('Tick');
	if (bPushActorOn) {
		if (PushFrequency != 0.0) {
			Disable('Tick');
			SetTimer(PushFrequency,True);
		}
		else {
			Enable('Tick');
		}
	}
}

defaultproperties
{
     PushSpeed=100.000000
     bPushActorOn=True
     bHidden=True
     bDirectional=True
     bMovable=False
     bStasis=False
     Texture=Texture'Engine.S_Teleport'
     bCollideActors=True
}
