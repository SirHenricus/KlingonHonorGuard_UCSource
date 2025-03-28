//=============================================================================
// Camera2.
//=============================================================================
class Camera2 expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\Camera2\InHand\Final\Camera2.mac
#call q:\Klingons\Art\Pickups\Equip\Camera2\Pickup\Final\Camera2pu.mac

#exec MESH ORIGIN MESH=EquipCamera2 X=-70 Y=0 Z=0 YAW=64
#exec MESH ORIGIN MESH=EquipCamera2Pickup X=-60 Y=-50 Z=25

var() mesh		OnWallMesh;
var() float		OnWallScale;

var rotator		StartRotation;

var bool		bOnWall,
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
			KlingonPlayer(Owner).ViewFrom(None);
			KlingonPlayer(Owner).ShowHUD();
			KlingonPlayer(Owner).CameraOverlay(False);
			PlayAnim('Closed',1.0,0.5);
		}
	}
}

defaultproperties
{
     OnWallMesh=Mesh'Klingons.EquipCamera2'
     OnWallScale=0.500000
     PickupMessage="You picked up a View Camera"
     RespawnTime=30.000000
     PlayerViewMesh=Mesh'Klingons.EquipCamera2'
     PickupViewMesh=Mesh'Klingons.EquipCamera2Pickup'
     PickupViewScale=0.250000
     Charge=120
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.CameraOpen'
     Icon=Texture'KlingonHUD.InvIcons.I_cam2'
     Mesh=Mesh'Klingons.EquipCamera2Pickup'
     DrawScale=0.250000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
}
