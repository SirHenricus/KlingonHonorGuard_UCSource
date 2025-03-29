//=============================================================================
// TallBoxKlingon.
//=============================================================================
class TallBoxKlingon expands BigBoxKlingon;

#call q:\Klingons\Art\Decor\Boxes\TallBox\Final\TallBoxKling.mac

#exec MESH ORIGIN MESH=BoxTallKlingon X=0 Y=0 Z=0

defaultproperties
{
     ObjectHealth=8.000000
     Mesh=Mesh'Klingons.BoxTallKlingon'
     CollisionRadius=12.000000
     Buoyancy=51.000000
}
