//=============================================================================
// Ladders.
//=============================================================================
class Ladders expands KlingonDecorations;

var() class<Actor>	LadderLiftClass;

/*
singular function Touch(actor Other)
{
	local KlingonPlayer		K;

	if (Level.NetMode != NM_StandAlone) {
		K=KlingonPlayer(Other);
		if (K == None || K.IsInState('PlayerClimbing')) {
			return;
		}
		K.LadderActor=Self;
		K.GotoState('PlayerClimbing');
	}
}

singular function UnTouch(actor Other)
{
	local KlingonPlayer		K;

	if (Level.NetMode != NM_StandAlone) {
		K=KlingonPlayer(Other);
		if (K != None && K.IsInState('PlayerClimbing')) {
//			K.GotoState('PickupWeaponIdle');
			K.GotoState('PlayerWalking');
		}
	}
}
*/

function BeginPlay()
{
	local float			LadderHalfHeight;
	local vector		LadderBottom,
						LadderTop,
						RotV,
						TraceEnd,
						TraceHitNor;
	local actor			A;

	if (Level.NetMode == NM_StandAlone) {
		DrawType=DT_None;
		return;
	}
	
//	Replace all ladders in multiplayer games with lifts

	RotV=vector(Rotation)*35.0;
	LadderTop=Location-RotV+(vect(0,0,1)*CollisionHeight);
	TraceEnd=LadderTop-(vect(0,0,1)*1000000);
	Trace(LadderBottom,TraceHitNor,TraceEnd,LadderTop);
	if (VSize(LadderBottom) == 0) {
		LadderBottom=TraceEnd;
	}
	A=Spawn(LadderLiftClass,,,LadderBottom);
	if (A != None) {
		A.DrawScale=4;
		A.SetCollisionSize(45,5);
		A.SetCollision(True,True,True);
		if (LadderLifter(A) != None) {
			LadderLifter(A).LadderLiftTop=LadderTop;
			LadderLifter(A).LadderLiftBottom=LadderBottom;
			LadderLifter(A).LadderLiftSpeed=250.0;
		}
	}
	Destroy();
}

defaultproperties
{
     LadderLiftClass=Class'Klingons.LadderLifter'
     bDirectional=True
     bMovable=False
     bStasis=False
     Texture=Texture'Editor.B_PlyrOn'
     bCollideActors=True
}
