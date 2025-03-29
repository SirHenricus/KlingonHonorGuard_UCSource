//=============================================================================
// MagBoots.
//=============================================================================
class MagBoots expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\MagBoots\Final\MagBoots.mac

#exec MESH ORIGIN MESH=EquipMagBoots X=75 Y=200 Z=-120

simulated function ItemActivated()
{
	if (KlingonPlayer(Owner) != None) {
		KlingonPlayer(Owner).GotoState('MagBootWalk');
	}
}

simulated function ItemDeActivated()
{
	if (KlingonPlayer(Owner) != None) {
		KlingonPlayer(Owner).GotoState('PlayerWalking');
	}
}

state Activated
{
	simulated function Timer()
	{
		if (Abs(Owner.Region.Zone.ZoneGravity.Z) > 100 && !Owner.Region.Zone.bGravityZone) {
			GotoState('DeActivated');
		}
	}
	simulated function BeginState()
	{
		Super.BeginState();
		SetTimer(1,False);
	}
}

state DeActivated
{
	simulated function Activate()
	{
		if (Abs(Owner.Region.Zone.ZoneGravity.Z) > 100 && !Owner.Region.Zone.bGravityZone) {
			return;
		}
		Super.Activate();
	}
}

defaultproperties
{
     bDisplayableInv=True
     bInstantRespawn=True
     PickupMessage="You picked up the Mag Boots."
     RespawnTime=60.000000
     PickupViewMesh=Mesh'Klingons.EquipMagBoots'
     PickupViewScale=0.400000
     DeActivateSound=Sound'KlingonSFX01.Inventory_Items.MagDeActi3'
     Icon=Texture'KlingonHUD.InvIcons.I_boots'
     bTravel=False
     Mesh=Mesh'Klingons.EquipMagBoots'
     DrawScale=0.400000
     CollisionHeight=11.000000
}
