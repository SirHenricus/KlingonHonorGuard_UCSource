//=============================================================================
// KlingonMover.
//=============================================================================
class KlingonMover expands Mover;

var() float		MoveKeyTime[8];
var() bool		bEncroachPlayers;
var() bool		bEncroachPawns;

// Return true to abort, false to continue.
function bool EncroachingOn(actor Other)
{
	if (Other.IsA('Carcass') || Other.IsA('Decoration')) {
		Other.TakeDamage(10000,None,Other.Location,vect(0,0,0),'Crushed');
		return(false);
	}
	if (Other.IsA('Fragment') || Other.IsA('Shards')) {
		Other.Destroy();
		return(false);
	}
// Damage the encroached actor.
	if (EncroachDamage != 0) {
		if (Other.IsA('KlingonPawn')) {
			if (bEncroachPawns) {
				Other.TakeDamage(EncroachDamage,Instigator,Other.Location,vect(0,0,0),'Crushed');
			}
			else {
				Leader.MakeGroupReturn();
				return(true);
			}
		}
		if (Other.IsA('KlingonPlayer')) {
			if (bEncroachPlayers) {
				Other.TakeDamage(EncroachDamage,Instigator,Other.Location,vect(0,0,0),'Crushed');
			}
			else {
				Leader.MakeGroupReturn();
				return(true);
			}
		}
	}
// If we have a bump-player event, and Other is a pawn, do the bump thing.
	if (Pawn(Other) != None && Pawn(Other).bIsPlayer && PlayerBumpEvent != '') {
		Bump(Other);
	}
// Stop, return, or whatever.
	if (MoverEncroachType == ME_StopWhenEncroach) {
		Leader.MakeGroupStop();
		return(true);
	}
	else if (MoverEncroachType == ME_ReturnWhenEncroach) {
		Leader.MakeGroupReturn();
		if (Other.IsA('Pawn')) {
			if (Pawn(Other).bIsPlayer) {
				Pawn(Other).PlaySound(Pawn(Other).Land,SLOT_Talk);
			}
			else {
				Pawn(Other).PlaySound(Pawn(Other).HitSound1,SLOT_Talk);
			}
		}	
		return(true);
	}
	else if (MoverEncroachType == ME_CrushWhenEncroach) {
// Kill it.
		Other.KilledBy(Instigator);
		return(false);
	}
	else if (MoverEncroachType == ME_IgnoreWhenEncroach) {
// Ignore it.
		return(false);
	}
}

function InterpolateEnd(actor Other)
{
	local byte	OldKeyNum;

	OldKeyNum=PrevKeyNum;
	PrevKeyNum=KeyNum;
	PhysAlpha=0;
// If more than two keyframes, chain them.
	if (KeyNum > 0 && KeyNum < OldKeyNum) {
// Chain to previous.
		InterpolateTo(KeyNum-1,MoveKeyTime[KeyNum-1]);
	}
	else if (KeyNum < NumKeys-1 && KeyNum > OldKeyNum) {
// Chain to next.
		InterpolateTo(KeyNum+1,MoveKeyTime[KeyNum]);
	}
	else {
// Finished interpolating.
		AmbientSound=None;
	}
}

// Open the mover.
function DoOpen()
{
	bOpening=true;
	InterpolateTo(1,MoveKeyTime[0]);
	PlaySound(OpeningSound,SLOT_None);
	AmbientSound=MoveAmbientSound;
}

// Close the mover.
function DoClose()
{
	local actor	A;

	bOpening=false;
	InterpolateTo(Max(0,KeyNum-1),MoveKeyTime[Max(0,KeyNum-1)]);
	PlaySound(ClosingSound,SLOT_None);
	if (Event != '') {
		foreach AllActors(class 'Actor',A,Event) {
			A.UnTrigger(Self,Instigator);
		}
	}
	AmbientSound=MoveAmbientSound;
}

defaultproperties
{
}
