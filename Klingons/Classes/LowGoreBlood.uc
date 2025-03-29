//=============================================================================
// LowGoreBlood.
//=============================================================================
class LowGoreBlood expands Effects;

function PostBeginPlay()
{
	super.PostBeginPlay();
	if (Level.Game.bLowGore)
		bHidden = true;
	else
		bHidden = false;

}

defaultproperties
{
     DrawType=DT_Mesh
     Style=STY_Translucent
     Texture=Texture'KlingonFX01.blood00'
     Skin=Texture'KlingonFX01.blood00'
     Mesh=Mesh'Klingons.BloodSplat'
     DrawScale=0.080000
     bMeshCurvy=False
}
