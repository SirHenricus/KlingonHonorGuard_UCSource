//=============================================================================
// AntiGravBelt.
//=============================================================================
class AntiGravBelt expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\AntiGrav\Final\AntiGrav.mac

#exec MESH ORIGIN MESH=EquipAntiGrav X=0 Y=0 Z=0

simulated function ItemActivated()
{
	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).GotoState('AntiGravFly');
	}
}

simulated function ItemDeActivated()
{
	if (KlingonPlayer(MyOwner) != None) {
		if (KlingonPlayer(MyOwner).Region.Zone.bWaterZone)
			KlingonPlayer(MyOwner).GotoState('PlayerSwimming');
		else
			KlingonPlayer(MyOwner).GotoState('PlayerWalking');
	}
}

defaultproperties
{
     Warning1Sound=Sound'KlingonSFX01.Beeps.Bp08'
     Warning1Time=15
     Warning2Sound=Sound'KlingonSFX01.Beeps.Bp09'
     Warning2Time=5
     ConsumptionRate=1.000000
     PickupMessage="You got the Anti Grav Belt"
     RespawnTime=60.000000
     PickupViewMesh=Mesh'Klingons.EquipAntiGrav'
     PickupViewScale=0.300000
     Charge=60
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.StealthActi'
     DeActivateSound=Sound'KlingonSFX01.Inventory_Items.StealthDeActi'
     Icon=Texture'KlingonHUD.InvIcons.I_grav'
     bTravel=False
     Mesh=Mesh'Klingons.EquipAntiGrav'
     DrawScale=0.300000
     CollisionHeight=16.000000
}
