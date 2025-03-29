//=============================================================================
// Tricorder.
//=============================================================================
class Tricorder expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\Tricorder\Final\Tricorder.mac

#exec MESH ORIGIN MESH=EquipTricorder X=0 Y=0 Z=100

var() float				TargetRange;
var() int				TargetCount;
var() class<Targeters>	TargeterType;

var Pawn				TargetLocated[5];

var Targeters			Targeter[5];

var int					TargetsFound;

function FindTargets()
{
	local int			i;
	local Pawn			Other;

	for (i=0 ; i < TargetCount ; i++) {
		TargetLocated[i]=None;
		if (Targeter[i] != None) {
			Targeter[i].bHidden=True;
			Targeter[i].bInSight=False;
		}
	}
	TargetsFound=0;
	foreach Owner.RadiusActors(class 'Pawn',Other,TargetRange) {
		if (TargetsFound < TargetCount) {
			if (Targeter[TargetsFound] == None) {
				Targeter[TargetsFound]=Spawn(TargeterType,Self);
				Targeter[TargetsFound].bHidden=True;
			}
			TargetLocated[TargetsFound]=Other;
			TargetsFound++;
		}
	}
}

function DisableTargetLocators()
{
	local int	i;

	for (i=0 ; i < TargetsFound ; i++) {
		Targeter[i].bHidden=True;
	}
}

function ShowTargetLocators()
{
	local int		i;
	local actor		HitAct;
	local vector	HitLoc,
					HitNor,
					EndLoc,
					StartLoc,
					Loc;

	FindTargets();
	for (i=0 ; i < TargetsFound ; i++) {
		StartLoc=Owner.Location;
		EndLoc=TargetLocated[i].Location;
		HitAct=Owner.Trace(HitLoc,HitNor,EndLoc,StartLoc,True);
		if (Targeter[i] != None) {
			if (HitAct != TargetLocated[i] || HitAct.bHidden) {
				Loc=HitLoc+(vect(0,0,0.5)*TargetLocated[i].CollisionHeight);
				Targeter[i].bHidden=False;
				Targeter[i].SetLocation(Loc);
			}
		}
	}
}

function Destroyed()
{
	local int	i;

	for (i=0 ; i < TargetCount ; i++) {
		if (Targeter[i] != None) {
			Targeter[i].Destroy();
		}
	}
	Super.Destroyed();
}

function ItemActivated()
{
	TargetCount=Clamp(TargetCount,0,5);
}

function ItemDeActivated()
{
	DisableTargetLocators();
}

state Activated
{
	function Tick(float delta)
	{
		ShowTargetLocators();
	}
}

defaultproperties
{
     TargetRange=2000.000000
     TargetCount=5
     TargeterType=Class'Klingons.Targeters'
     ConsumptionRate=1.000000
     PickupMessage="You picked up a Tricorder"
     RespawnTime=300.000000
     PickupViewMesh=Mesh'Klingons.EquipTricorder'
     PickupViewScale=0.350000
     Charge=60
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.CameraOpen'
     DeActivateSound=Sound'KlingonSFX01.Inventory_Items.CameraOpen'
     Icon=Texture'KlingonHUD.InvIcons.I_tricrd'
     Mesh=Mesh'Klingons.EquipTricorder'
     DrawScale=0.350000
     CollisionHeight=15.000000
}
