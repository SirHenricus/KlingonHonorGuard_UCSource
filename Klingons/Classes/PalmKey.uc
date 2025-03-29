//=============================================================================
// PalmKey.
//=============================================================================
class PalmKey expands Keys;

#call q:\Klingons\Art\Pickups\Key\Palm\Final\Palm.mac

#exec MESH ORIGIN MESH=KeyPalmImprint X=0 Y=200 Z=0

defaultproperties
{
     bActivatable=True
     bDisplayableInv=True
     PickupMessage="You picked up a Digital Palm Imprint"
     PickupViewMesh=Mesh'Klingons.KeyPalmImprint'
     PickupViewScale=0.250000
     Icon=Texture'KlingonHUD.InvIcons.Palm'
     Mesh=Mesh'Klingons.KeyPalmImprint'
     DrawScale=0.250000
     CollisionRadius=20.000000
     CollisionHeight=15.000000
}
