//=============================================================================
// SpaceCannon.
//=============================================================================
class SpaceCannon expands KlingonDecorations;

#call q:\Klingons\Art\Missn_08\Geometry\Pawns\Final\Cannon\Cannon.mac

#exec MESH ORIGIN MESH=Cannon X=25 Y=-125 Z=0 YAW=128

defaultproperties
{
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.Cannon'
}
