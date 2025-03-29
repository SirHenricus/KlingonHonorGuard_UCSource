//=============================================================================
// TallBoxAlien.
//=============================================================================
class TallBoxAlien expands BigBoxAlien;

#call q:\Klingons\Art\Decor\Boxes\Tallbox\Final\TallBoxAlien.mac

#exec MESH ORIGIN MESH=BoxTallAlien X=0 Y=0 Z=0

defaultproperties
{
     Mesh=Mesh'Klingons.BoxTallAlien'
     CollisionRadius=12.000000
     Buoyancy=51.000000
}
