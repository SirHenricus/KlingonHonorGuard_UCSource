//=============================================================================
// VacSuit.
//=============================================================================
class VacSuit expands KlingonArmor;

#call q:\Klingons\Art\Pickups\Armor\VacSuit\Final\VacSuitPU.mac

#exec MESH ORIGIN MESH=ArmorVacSuit X=0 Y=0 Z=0

var() float	SpaceDamageFreq;
var() float	SpaceDamageThreshold;

var float	SpaceDamageTimer;

simulated function PickupFunction(pawn Other)
{
	if (KlingonPlayer(Other) != None) {
		KlingonPlayer(Other).bHasVacSuit=True;
	}
	SetTimer(SpaceDamageFreq,True);
	Super.PickupFunction(Other);
}

simulated function Destroyed()
{
	if (KlingonPlayer(Owner) != None) {
		KlingonPlayer(Owner).bHasVacSuit=False;
	}
	Super.Destroyed();
}

simulated function bool IsSpaceZone(actor A)
{
	if (A.Region.Zone.ZoneGravity.Z >= -100 || A.Region.Zone.bGravityZone) {
		if (A.Region.Zone.bPainZone && A.Region.Zone.DamageType == 'suffocated') {
			return(True);
		}
	}
	return(False);
}

simulated function Timer()
{
	local KlingonPlayer		K;

	K=KlingonPlayer(MyOwner);
	if (K != None) {
		if (IsSpaceZone(K)) {
			if (K.bMagBootsAttached) {
				SpaceDamageTimer=0;
			}
			else {
				SpaceDamageTimer+=SpaceDamageFreq;
				if (SpaceDamageTimer >= SpaceDamageThreshold) {
					K.TakeDamage(K.Region.Zone.DamagePerSec,
								K,Location,vect(0,0,0),'exploded');
				}
			}
		}
	}
}

defaultproperties
{
     SpaceDamageFreq=5.000000
     SpaceDamageThreshold=45.000000
     PlayerMesh=Mesh'Klingons.DMVacSuit'
     PickupMessage="You got the Vac Suit"
     RespawnTime=240.000000
     PickupViewMesh=Mesh'Klingons.ArmorVacSuit'
     PickupViewScale=1.500000
     ProtectionType1=drowned
     ProtectionType2=Suffocated
     Charge=75
     ArmorAbsorption=75
     AbsorptionPriority=7
     Icon=Texture'KlingonHUD.InvIcons.I_vacst'
     Mesh=Mesh'Klingons.ArmorVacSuit'
     DrawScale=1.500000
     CollisionHeight=50.000000
     bProjTarget=False
     Mass=40.000000
}
