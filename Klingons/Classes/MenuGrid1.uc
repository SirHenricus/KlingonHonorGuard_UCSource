//=============================================================================
// MenuGrid1.
//=============================================================================
class MenuGrid1 expands KlingonHUD;

#call q:\Klingons\Art\interfac\Finalhud\hudback\Final\MenuGrid1.mac
#exec MESH ORIGIN MESH=MenuGrid1 X=-400 Y=0 Z=0

defaultproperties
{
     bHidden=False
     RemoteRole=ROLE_DumbProxy
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.MenuGrid1'
     bUnlit=True
     bNoSmooth=True
     bMeshCurvy=False
     CollisionRadius=1.000000
     CollisionHeight=1.000000
}
