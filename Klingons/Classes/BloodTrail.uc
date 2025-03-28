//=============================================================================
// BloodTrail.
//=============================================================================
class BloodTrail expands Effects;

simulated function PreBeginPlay()
{
	Super.PreBeginPlay();
	LoopAnim('Spray');
}

auto state Trail
{
}

defaultproperties
{
     Physics=PHYS_Trailer
     LifeSpan=5.000000
     AnimSequence=Spray
     DrawType=DT_Mesh
     DrawScale=3.000000
     AmbientGlow=72
     bMeshCurvy=False
}
