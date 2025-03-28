//=============================================================================
// BloodWine.
//=============================================================================
class BloodWine expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Food\Goblet\Final\Goblet.mac

#exec MESH ORIGIN MESH=PowerUpGoblet X=0 Y=0 Z=25

var() byte			PawnLightBrightness;
var() byte			PawnLightHue;
var() ELightType	PawnLightType;
var() byte			PawnLightPeriod;
var() byte			PawnLightPhase;
var() byte			PawnVolumeBrightness;
var() byte			PawnVolumeRadius;
var() float			WeaponDamageScale;

function ItemActivated()
{
	local Pawn	P;

	P=Pawn(Owner);
	if (P != None) {
		if (KlingonPlayer(P) != None) {
			KlingonPlayer(P).WeaponDamageScale=WeaponDamageScale;
		}
		else if (Bots(P) != None) {
			Bots(P).WeaponDamageScale=WeaponDamageScale;
		}
		P.LightType=PawnLightType;
		P.LightBrightness=PawnLightBrightness;
		P.LightHue=PawnLightHue;
		P.LightPeriod=PawnLightPeriod;
		P.LightPhase=PawnLightPhase;
		P.VolumeBrightness=PawnVolumeBrightness;
		P.VolumeRadius=PawnVolumeRadius;
		P.LightRadius=1;
		P.VolumeFog=1;
	}
}

function ItemDeActivated()
{
	local Pawn	P;

	P=Pawn(Owner);
	if (P != None) {
		if (KlingonPlayer(P) != None) {
			KlingonPlayer(P).WeaponDamageScale=KlingonPlayer(P).Default.WeaponDamageScale;
		}
		else if (Bots(P) != None) {
			Bots(P).WeaponDamageScale=Bots(P).Default.WeaponDamageScale;
		}
		P.LightType=P.Default.LightType;
		P.LightBrightness=P.Default.LightBrightness;
		P.LightHue=P.Default.LightHue;
		P.LightPeriod=P.Default.LightPeriod;
		P.LightPhase=P.Default.LightPhase;
		P.VolumeBrightness=P.Default.VolumeBrightness;
		P.VolumeRadius=P.Default.VolumeRadius;
		P.LightRadius=P.Default.LightRadius;
		P.VolumeFog=P.Default.VolumeFog;
	}
}

function PickupFunction(pawn Other)
{
	Super.PickupFunction(Other);
	if (!ItemCopy.IsInState('Activated') && Pickup(ItemCopy).bAutoActivate) {
		ItemCopy.Activate();
	}
}

function Destroyed()
{
	if (!IsInState('DeActivated')) {
		ItemDeActivated();
	}
	Super.Destroyed();
}

state Activated
{
	function Timer()
	{
		local Pawn	P;

		Super.Timer();
		P=Pawn(Owner);
		if (Charge < (Default.Charge*0.1) && P != None && P.LightType != LT_Pulse) {
			P.LightType=LT_Pulse;
		}
	}
	function Activate()
	{
	}
}

defaultproperties
{
     PawnLightBrightness=64
     PawnLightHue=180
     PawnLightType=LT_Steady
     PawnLightPeriod=16
     PawnLightPhase=16
     PawnVolumeBrightness=128
     PawnVolumeRadius=3
     WeaponDamageScale=4.000000
     Warning1Sound=Sound'KlingonSFX01.Pickups.Health1'
     Warning1Time=5
     Warning2Sound=Sound'KlingonSFX01.Pickups.Health1'
     Warning2Time=10
     ConsumptionRate=1.000000
     bAutoActivate=True
     PickupMessage="You drank a flask of Blood Wine"
     RespawnTime=90.000000
     PickupViewMesh=Mesh'Klingons.PowerUpGoblet'
     Charge=30
     PickupSound=Sound'KlingonSFX01.Pickups.Health1'
     Mesh=Mesh'Klingons.PowerUpGoblet'
     CollisionRadius=15.000000
     CollisionHeight=15.000000
}
