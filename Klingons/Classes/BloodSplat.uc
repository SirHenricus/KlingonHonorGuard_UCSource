//=============================================================================
// BloodSplat.
//=============================================================================
class BloodSplat expands Effects;

var() texture	BloodTextures[10];
var int			RandomTex;


#exec OBJ LOAD FILE=..\Textures\KlingonFX01.utx PACKAGE=KlingonFX01

#exec MESH IMPORT MESH=BloodSplat ANIVFILE=..\Klingons\Models\BSplata.3D DATAFILE=..\Klingons\Models\BSplatd.3D X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=BloodSplat X=0 Y=0 Z=0 YAW=64
#exec MESH SEQUENCE MESH=BloodSplat SEQ=All STARTFRAME=0 NUMFRAMES=1
#exec MESH SEQUENCE MESH=BloodSplat SEQ=Static STARTFRAME=1 NUMFRAMES=1
#exec MESHMAP NEW   MESHMAP=BloodSplat MESH=BloodSplat
#exec MESHMAP SCALE MESHMAP=BloodSplat X=0.25 Y=0.25 Z=0.5
#exec MESHMAP SETTEXTURE MESHMAP=BloodSplat NUM=0 TEXTURE=Blood00

var float time;

auto state Flying
{
	function HitWall(vector HitNor,actor HitActor)
	{
		if (Level.NetMode != NM_StandAlone) {
			Destroy();
			return;
		}
//		DrawScale *= 0.5;
		if (LevelInfo(HitActor) != none)
		{
			DrawType=DT_Mesh;
			SetRotation(rotator(HitNor));
			SetPhysics(PHYS_None);
		}
		else
			Destroy();
	}
	function Landed(vector HitNor)
	{
		HitWall(HitNor,None);
	}
/*	function Timer()
	{
		if (Physics != PHYS_None) {
			DrawScale=FClamp(DrawScale+0.1,0.1,0.2);
		}
		Time-=0.005;
		if (Time <= 0.0) {
			DrawScale -= 0.005;
			if (DrawScale < 0.005)
				Destroy();
		}
	}
*/	
	
	function Timer()
	{
		if (Level.NetMode == NM_Standalone)
		{

			if (Physics != PHYS_None) {
				DrawScale=FClamp(DrawScale+0.1,0.1,0.2);
			}
			Time-=0.005;
			if (Time <= 0.0) {
				if (ScaleGlow == 1.0)
					ScaleGlow = 0.8;
				style = STY_Translucent;
				ScaleGlow -= 0.004;
				if (ScaleGlow < 0.004)
					Destroy();
			}
		}
/* Multiplayer blood destroys upon contact with surface
		else
		{
			if (Physics != PHYS_None) {
				DrawScale=FClamp(DrawScale+0.1,0.1,0.2);
			}
			Time-=0.005;
			if (Time <= 0.0) {
				DrawScale -= 0.005;
				if (DrawScale < 0.005)
					Destroy();
			}
		}
*/
	}

Begin:
	Time = 1.0;
/*
	if (Level.NetMode != NM_Standalone)
	{
		Style = STY_Masked;
	}	
*/
	RandomTex=Rand(10);
	Skin=BloodTextures[RandomTex];
	Texture=BloodTextures[RandomTex];
	DrawType=DT_Sprite;
	DrawScale *= 4.0;
//	Velocity=Owner.Velocity;
	SetPhysics(PHYS_Falling);
	bBounce = true;
	SetTimer(0.1,True);
}

defaultproperties
{
     BloodTextures(0)=Texture'KlingonFX01.blood00'
     BloodTextures(1)=Texture'KlingonFX01.blood01'
     BloodTextures(2)=Texture'KlingonFX01.blood02'
     BloodTextures(3)=Texture'KlingonFX01.blood03'
     BloodTextures(4)=Texture'KlingonFX01.blood02'
     BloodTextures(5)=Texture'KlingonFX01.blood01'
     BloodTextures(6)=Texture'KlingonFX01.blood00'
     BloodTextures(7)=Texture'KlingonFX01.blood01'
     BloodTextures(8)=Texture'KlingonFX01.blood02'
     BloodTextures(9)=Texture'KlingonFX01.blood03'
     RemoteRole=ROLE_SimulatedProxy
     Tag=HitNormal
     DrawType=DT_Mesh
     Style=STY_Translucent
     Texture=Texture'KlingonFX01.blood00'
     Skin=Texture'KlingonFX01.blood00'
     Mesh=Mesh'Klingons.BloodSplat'
     DrawScale=0.050000
     bMeshCurvy=False
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bCollideWorld=True
}
