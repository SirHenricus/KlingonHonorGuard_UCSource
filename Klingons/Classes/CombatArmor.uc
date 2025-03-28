//=============================================================================
// CombatArmor.
//=============================================================================
class CombatArmor expands VacSuit;

#call q:\Klingons\Art\Pickups\Armor\Combat\Final\ACArmorPU.mac

#exec MESH ORIGIN MESH=ArmorCombat X=0 Y=0 Z=0

defaultproperties
{
     PickupMessage="You got the Advanced Combat Armor"
     RespawnTime=60.000000
     PickupViewMesh=Mesh'Klingons.ArmorCombat'
     Charge=100
     ArmorAbsorption=100
     AbsorptionPriority=9
     Icon=Texture'KlingonHUD.InvIcons.I_advcbt'
     Mesh=Mesh'Klingons.ArmorCombat'
     Mass=35.000000
}
