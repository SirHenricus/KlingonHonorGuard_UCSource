//=============================================================================
// RetinalKey.
//=============================================================================
class RetinalKey expands Keys;

#call q:\Klingons\Art\Pickups\Key\Retinal\Final\Retinal.mac

#exec MESH ORIGIN MESH=KeyRetinalProjector X=50 Y=0 Z=100

defaultproperties
{
     bActivatable=True
     bDisplayableInv=True
     PickupMessage="You picked up a Holographic Retinal Projector"
     PickupViewMesh=Mesh'Klingons.KeyRetinalProjector'
     PickupViewScale=0.300000
     Icon=Texture'KlingonHUD.InvIcons.Retinal'
     Mesh=Mesh'Klingons.KeyRetinalProjector'
     DrawScale=0.300000
     CollisionHeight=10.000000
}
