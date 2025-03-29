//=============================================================================
// PasscardKey.
//=============================================================================
class PasscardKey expands Keys;

#call q:\Klingons\Art\Pickups\Key\Passcard\Final\Passcard.mac

#exec MESH ORIGIN MESH=KeyPasscard X=75 Y=0 Z=0

defaultproperties
{
     bActivatable=True
     bDisplayableInv=True
     PickupMessage="You picked up a Passcard Key"
     PickupViewMesh=Mesh'Klingons.KeyPassCard'
     PickupViewScale=0.400000
     Icon=Texture'KlingonHUD.InvIcons.Passcard'
     Mesh=Mesh'Klingons.KeyPassCard'
     DrawScale=0.400000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
}
