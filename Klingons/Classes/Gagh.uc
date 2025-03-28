//=============================================================================
// Gagh.
//=============================================================================
class Gagh expands KlingonPowerups;

#call q:\Klingons\Art\Pickups\Food\Gagh\Final\Gagh.mac

auto state Pickup
{
	simulated function BeginState()
	{
		Super.BeginState();
		LoopAnim('Static',1.0);
	}
}

defaultproperties
{
     PowerupAmount=100.000000
     bSuperPowerup=True
     PickupMessage="You've eaten a Bowl of Gagh"
     RespawnTime=120.000000
     PickupViewMesh=Mesh'Klingons.GaghPU'
     PickupViewScale=0.600000
     Mesh=Mesh'Klingons.GaghPU'
     DrawScale=0.600000
}
