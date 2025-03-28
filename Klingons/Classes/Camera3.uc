//=============================================================================
// Camera3.
//=============================================================================
class Camera3 expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\Camera3\InHand\Final\Camera3.mac
#call q:\Klingons\Art\Pickups\Equip\Camera3\Pickup\Final\Camera3pu.mac

#exec MESH ORIGIN MESH=EquipCamera3 X=-70 Y=0 Z=0 YAW=64
#exec MESH ORIGIN MESH=EquipCamera3Pickup X=-60 Y=-50 Z=25

var() mesh				OnWallMesh;
var() float				OnWallScale;
var() float				FireRate;
var() float				AltFireRate;
var() int				AmmoConsumption;
var() int				AltAmmoConsumption;
var() class<Projectile>	ProjType;
var() class<Projectile>	AltProjType;

var float				DestFOV,
						LastShotTime;

var rotator				StartRotation;

var bool				bOnWall,
						bViewing;


function Destroyed()
{
	if (KlingonPlayer(Owner) != none)
	{
		KlingonPlayer(Owner).CameraOverlay(False);
		KlingonPlayer(Owner).ShowHUD();
		
	}
	Super.Destroyed();
}

simulated function ItemActivated()
{
	local actor		HitAct;
	local vector	HitLoc,
					HitNor,
					EndLoc,
					StartLoc;

	if (bOnWall) {
		if (KlingonPlayer(Owner) != None) {
			KlingonPlayer(Owner).ViewFrom(Self);
			KlingonPlayer(Owner).HideHUD();
			KlingonPlayer(Owner).CameraOverlay(True);
			PlayAnim('Open',0.5);
			bViewing=True;
		}
	}
	else {
		StartLoc=Owner.Location;
		EndLoc=Owner.Location+(vector(Owner.Rotation)*150.0);
		HitAct=Trace(HitLoc,HitNor,EndLoc,StartLoc,False);
		if (HitAct == Level) {
			Mesh=OnWallMesh;
			DrawScale=OnWallScale;
			SetLocation(HitLoc+(HitNor*10.0));
			SetRotation(rotator(HitNor));
			StartRotation=Rotation;
			bHidden=False;
			bOnWall=True;
		}
		GotoState('DeActivated');
	}		
}

simulated function ItemDeActivated()
{
	if (bOnWall) {
		if (bViewing && KlingonPlayer(Owner) != None) {
			SetRotation(StartRotation);
			KlingonPlayer(Owner).SetDesiredFOV(KlingonPlayer(Owner).Default.FOVAngle);
			KlingonPlayer(Owner).ViewFrom(None);
			KlingonPlayer(Owner).ShowHUD();
			KlingonPlayer(Owner).CameraOverlay(False);
			PlayAnim('Closed',1.0,0.5);
		}
	}
}

simulated function Fire(optional float F)
{
}

simulated function AltFire(optional float F)
{
}

state Activated
{
	simulated function Fire(optional float F)
	{
		local projectile	P;

		if ((Level.TimeSeconds-LastShotTime) >= FireRate) {
			if (Charge >= AmmoConsumption) {
				LastShotTime=Level.TimeSeconds;
				P=Spawn(ProjType,Self);
				P.Instigator=Pawn(Owner);
				Charge-=AmmoConsumption;
			}
		}
	}
	simulated function AltFire(optional float F)
	{
		local projectile	P;

		if (AltProjType == None) {
			DestFOV=KlingonPlayer(Owner).Default.FOVAngle*0.8;
			KlingonPlayer(Owner).SetDesiredFOV(DestFOV);
			SetTimer(0.25,False);
		}
		else if ((Level.TimeSeconds-LastShotTime) >= AltFireRate) {
			if (Charge >= AltAmmoConsumption) {
				LastShotTime=Level.TimeSeconds;
				P=Spawn(AltProjType,Self);
				P.Instigator=Pawn(Owner);
				Charge-=AltAmmoConsumption;
			}
		}
	}
	simulated function Timer()
	{
		if (KlingonPlayer(Owner).bAltFire != 0) {
			DestFOV*=0.8;
			KlingonPlayer(Owner).SetDesiredFOV(DestFOV);
			SetTimer(0.25,False);
		}
	}
}

defaultproperties
{
     OnWallMesh=Mesh'Klingons.EquipCamera3'
     OnWallScale=0.500000
     FireRate=0.500000
     AltFireRate=1.000000
     AmmoConsumption=1
     AltAmmoConsumption=1
     ProjType=Class'Klingons.DisruptorGreen'
     PickupMessage="You picked up a Sniper Camera"
     RespawnTime=30.000000
     PlayerViewMesh=Mesh'Klingons.EquipCamera3'
     PickupViewMesh=Mesh'Klingons.EquipCamera3Pickup'
     PickupViewScale=0.250000
     Charge=50
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.CameraOpen'
     Icon=Texture'KlingonHUD.InvIcons.I_cam3'
     Mesh=Mesh'Klingons.EquipCamera3Pickup'
     DrawScale=0.250000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
}
