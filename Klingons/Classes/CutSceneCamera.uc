//=============================================================================
// CutSceneCamera.
//=============================================================================
class CutSceneCamera expands Camera;

var() bool		bFixedCamera;

var actor		CamOwner;

var vector		CamLoc;
var bool		bCameraActive,
				bSpotCam;

function Spawned()
{
	if (bFixedCamera) {
		bSpotCam=True;
		SetOwner(None);
		CamLoc=Location;
		bCameraActive=False;
	}
	else {
		CamOwner=Owner;
		SetPlayerViews(None);
		bSpotCam=False;
		bCameraActive=True;
	}
}

function Destroyed()
{
	ResetPlayerViews();
}

function SetPlayerViews(pawn Other)
{
	local KlingonPlayer		K;

	if (bFixedCamera) {
		if (KlingonPlayer(Other) != None) {
			SetOwner(Other);
			KlingonPlayer(Other).ViewFrom(Self);
			KlingonPlayer(Other).HideHUD();
		}
	}
	else {
		foreach AllActors(class 'KlingonPlayer',K) {
			K.ViewFrom(Self);
			K.HideHUD();
			if (CamOwner != K) {
				K.GotoState('LockControls');
			}
		}
	}
}

function ResetPlayerViews()
{
	local KlingonPlayer		K;

	if (bFixedCamera) {
		if (KlingonPlayer(CamOwner) != None) {
			KlingonPlayer(CamOwner).ViewFrom(None);
			KlingonPlayer(CamOwner).HideHUD();
		}
		SetOwner(None);
		GotoState('TriggeredCamera');
	}
	else {
		foreach AllActors(class 'KlingonPlayer',K) {
			K.ViewFrom(None);
			K.ShowHUD();
			if (CamOwner != K) {
				K.GotoState('UnLockControls');
			}
		}
	}
}

auto state CameraPanning
{
	ignores TakeDamage;

	function Trigger(actor Other,pawn InstigatedBy)
	{
		if (bFixedCamera) {
			if (bCameraActive) {
				ResetPlayerViews();
				bCameraActive=False;
			}
			else {
				SetPlayerViews(InstigatedBy);
				bCameraActive=True;
			}
		}
	}
	function Tick(float delta)
	{
		local vector	HitNor,
						TraceEnd,
						TraceStart;
		local rotator	R;
		local actor		HitAct;

		if (!bCameraActive) {
			return;
		}
		if (!bSpotCam) {
			TraceStart=CamOwner.Location+(vect(0,0,2)*CamOwner.CollisionHeight);
			TraceEnd=TraceStart+(vector(CamOwner.Rotation)*250);
			HitAct=Trace(CamLoc,HitNor,TraceEnd,TraceStart,False);
			if (HitAct == None) {
				if (VSize(CamLoc) == 0.0) {
					CamLoc=TraceEnd;
				}
			}
			SetLocation(CamLoc);
			bSpotCam=True;
		}
		if (CamOwner != None) {
			if (LineOfSightTo(CamOwner)) {
				R=rotator(CamOwner.Location-CamLoc);
				ClientSetRotation(R);
			}
			else if (bFixedCamera) {
				ResetPlayerViews();
			}
			else {
				bSpotCam=False;
			}
		}
	}
}

defaultproperties
{
     GroundSpeed=0.000000
     WaterSpeed=0.000000
     AccelRate=0.000000
     JumpZ=0.000000
     MaxStepHeight=0.000000
     SightRadius=0.000000
     HearingThreshold=0.000000
     AttitudeToPlayer=ATTITUDE_Ignore
     Intelligence=BRAINS_NONE
     bHidden=True
     bCanTeleport=False
     bIsKillGoal=False
     bTravel=False
     AnimSequence=None
     Location=(X=0.000000,Y=0.000000,Z=0.000000)
     bMeshCurvy=False
     CollisionRadius=0.000000
     CollisionHeight=0.000000
     bCollideActors=False
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
     bProjTarget=False
     bRotateToDesired=False
     Mass=0.000000
     RotationRate=(Pitch=0,Yaw=0,Roll=0)
}
