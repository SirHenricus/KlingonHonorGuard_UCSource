//=============================================================================
// BattleDress.
//=============================================================================
class BattleDress expands KlingonArmor;

#call q:\Klingons\Art\Pickups\Armor\BDress\Final\BDress.mac

#exec MESH ORIGIN MESH=ArmorBattleDress X=0 Y=0 Z=0

defaultproperties
{
     PickupMessage="You got the Battle Dress Armor"
     RespawnTime=30.000000
     PickupViewMesh=Mesh'Klingons.ArmorBattleDress'
     PickupViewScale=1.500000
     Charge=50
     ArmorAbsorption=50
     AbsorptionPriority=5
     Icon=Texture'KlingonHUD.InvIcons.I_batdrs'
     Mesh=Mesh'Klingons.ArmorBattleDress'
     DrawScale=1.500000
     CollisionHeight=20.000000
     bProjTarget=False
}
