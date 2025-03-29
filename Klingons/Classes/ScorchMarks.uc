//=============================================================================
// ScorchMarks.
//=============================================================================
class ScorchMarks expands KlingonEffects
	abstract;

#exec MESH IMPORT MESH=ScorchMesh ANIVFILE=..\Klingons\Models\BSplata.3D DATAFILE=..\Klingons\Models\BSplatd.3D X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=ScorchMesh X=0 Y=0 Z=0 YAW=64
#exec MESH SEQUENCE MESH=ScorchMesh SEQ=All STARTFRAME=0 NUMFRAMES=1
#exec MESH SEQUENCE MESH=ScorchMesh SEQ=Static STARTFRAME=1 NUMFRAMES=1
#exec MESHMAP NEW   MESHMAP=ScorchMesh MESH=BloodSplat
#exec MESHMAP SCALE MESHMAP=ScorchMesh X=0.25 Y=0.25 Z=0.5
#exec MESHMAP SETTEXTURE MESHMAP=ScorchMesh NUM=0 TEXTURE=Default

defaultproperties
{
     bOnlyWhenSeen=False
     RemoteRole=ROLE_DumbProxy
     LifeSpan=45.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.ScorchMesh'
     Mass=0.000000
}
