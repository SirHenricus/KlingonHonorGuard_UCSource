//=============================================================================
// Locks.
//=============================================================================
class Locks expands KlingonTrigger;

var() class<Keys>	TriggerKey;
var() string[80]	AccessDeniedMsg;
var() sound			AccessDeniedSnd;
var() string[80]	AccessApprovedMsg;
var() sound			AccessApprovedSnd;

function Touch(actor Other)
{
	local actor A;

	if (IsRelevant(Other)) {
		if (HasKey(Other,TriggerKey)) {
			if (Other.Instigator != None) {
				if (AccessApprovedMsg != "" && PlayerPawn(Other.Instigator) != None) {
					PlayerPawn(Other.Instigator).ClientMessage(AccessApprovedMsg);
				}
				if (AccessApprovedSnd != None) {
					Other.Instigator.PlaySound(AccessDeniedSnd,SLOT_Misc,Other.Instigator.SoundDampening);
				}
			}
			if (Event != '') {
				foreach AllActors(class 'Actor',A,Event) {
					A.Trigger(Other,Other.Instigator);
				}
			}
			if (bTriggerOnceOnly) {
				SetCollision(False);
			}
		}
		else {
			if (Other.Instigator != None) {
				if (AccessDeniedMsg != "" && PlayerPawn(Other.Instigator) != None) {
					PlayerPawn(Other.Instigator).ClientMessage(AccessDeniedMsg);
				}
				if (AccessDeniedSnd != None) {
					Other.Instigator.PlaySound(AccessDeniedSnd,SLOT_Misc,Other.Instigator.SoundDampening);
				}
			}
		}
	}
}

//
// Item requires key so check Other's inventory
//
function bool HasKey(actor Other,class Key)
{
	local inventory	Inv;

	if (Key == None) {
		return(True);
	}
	for (Inv=Pawn(Other).Inventory ; Inv != None ; Inv=Inv.Inventory) {
		if (Inv.Class == Key) {
			return(True);
		}
	}
	return(False);
}

defaultproperties
{
     bHidden=False
     DrawType=DT_Mesh
     bMeshCurvy=False
}
