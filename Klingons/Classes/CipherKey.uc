//=============================================================================
// CipherKey.
//=============================================================================
class CipherKey expands Keys;

#call q:\Klingons\Art\Pickups\Key\Cipher\Final\Cipher.mac

#exec MESH ORIGIN MESH=KeyCipher X=0 Y=0 Z=0

defaultproperties
{
     bActivatable=True
     bDisplayableInv=True
     PickupMessage="You picked up a Cipher Decoding Module"
     PickupViewMesh=Mesh'Klingons.KeyCipher'
     PickupViewScale=0.300000
     Icon=Texture'KlingonHUD.InvIcons.Cipher'
     Texture=Texture'Klingons.CipherKeyNewTex1'
     Skin=Texture'Klingons.CipherKeyNewTex1'
     Mesh=Mesh'Klingons.KeyCipher'
     DrawScale=0.300000
}
