//=============================================================================
// BehindCamera.
//=============================================================================
class BehindCamera expands CutSceneCamera;



simulated function SetPlayerViews(pawn Other)
{
	if (KlingonPlayer(CamOwner) != None) {
		SetOwner(CamOwner);
		KlingonPlayer(CamOwner).ViewFrom(Self);
		KlingonPlayer(CamOwner).HideHUD();
	}
}

simulated function ResetPlayerViews()
{

	if (KlingonPlayer(CamOwner) != None) {
		KlingonPlayer(CamOwner).ViewFrom(None);
		KlingonPlayer(CamOwner).HideHUD();
	}
}

auto state CameraPanning
{
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
						TraceStart,
						TempVect;
		local rotator	R;
		local actor		HitAct;

		if (!bCameraActive) {
			return;
		}
		balwaysmouselook = false;
		if (!bSpotCam) {
			TraceStart=CamOwner.Location+(vect(0,0,1)*(CamOwner.CollisionHeight/2));
			TempVect = (-vector(CamOwner.rotation))*120;
			TempVect.Z += 20;
			TraceEnd=TraceStart+TempVect;
			HitAct=Trace(CamLoc,HitNor,TraceEnd,TraceStart,False);
//			CamLoc = TraceStart + (CamLoc - TraceStart)*0.99;
//			camLoc = CamOwner.Location + vect(0,0,700);
			if (HitAct == None) {
				if (VSize(CamLoc) == 0.0) {
					CamLoc=TraceEnd;
				}
			}
			SetLocation(CamLoc);
			bSpotCam=false;
		}
		if (CamOwner != None) {
//			if (LineOfSightTo(CamOwner)) {
				R=rotator(CamOwner.Location-CamLoc);
				ClientSetRotation(R);
//			}
//			else if (bFixedCamera) {
//				ResetPlayerViews();
//			}
//			else {
//				bSpotCam=False;
//			}
		}
	}
}

defaultproperties
{
}
