//=============================================================================
// Communicator.
//=============================================================================
class Communicator expands KlingonPickups;

simulated function ItemActivated()
{
	if (PlayerPawn(MyOwner) != none)
	{
		PlayerPawn(MyOwner).ConsoleCommand( "gilman" );	
		Destroy();
	}
}

simulated function ItemDeActivated()
{
}

defaultproperties
{
     bDisplayableInv=True
     PickupMessage="Found a communicator"
     PickupViewMesh=Mesh'Klingons.AmmoHERocketCase'
     PickupViewScale=0.300000
     ActivateSound=Sound'KlingonSFX01.Effects.Transporter'
     Icon=Texture'KlingonHUD.InvIcons.Comm'
     bNet=False
     bNetSpecial=False
     Texture=Texture'KlingonFX01.Items.KCom1'
     Skin=Texture'KlingonFX01.Items.KCom1'
     Mesh=Mesh'Klingons.AmmoHERocketCase'
     DrawScale=0.300000
     CollisionRadius=7.000000
     CollisionHeight=2.000000
}
