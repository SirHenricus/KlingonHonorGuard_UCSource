//=============================================================================
// GeneticKey.
//=============================================================================
class GeneticKey expands Keys;

#call q:\Klingons\Art\Pickups\Key\Genetic\Final\Genetic.mac

#exec MESH ORIGIN MESH=KeyGenetic X=50 Y=0 Z=0

defaultproperties
{
     bActivatable=True
     bDisplayableInv=True
     PickupMessage="You picked up a Genetic Key"
     PickupViewMesh=Mesh'Klingons.KeyGenetic'
     PickupViewScale=0.350000
     Icon=Texture'KlingonHUD.InvIcons.Genetic'
     Mesh=Mesh'Klingons.KeyGenetic'
     DrawScale=0.350000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
}
