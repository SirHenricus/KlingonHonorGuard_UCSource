//=============================================================================
// SecretAreaTrigger.
//=============================================================================
class SecretAreaTrigger expands KlingonTrigger;

function Touch(actor Other)
{
	if (IsRelevant(Other)) {
		if (bIsSecretGoal && Pawn(Other) != None) {
			Pawn(Other).SecretCount++;
			if (Level.Game != None) {
				if (KlingonGameInfo(Level.Game) != None) {
					KlingonGameInfo(Level.Game).SecretCount++;
				}
			}
		}
	}
	Super.Touch(Other);
}

defaultproperties
{
     Message="You found a secret area"
     bTriggerOnceOnly=True
     bIsSecretGoal=True
}
