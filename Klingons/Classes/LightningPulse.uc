//=============================================================================
// LightningPulse.
//=============================================================================
class LightningPulse expands KlingonEffects;

var int LLastFrame;

simulated function Tick(float delta)
{
	Super.Tick(delta);
	Skin = Frames[LLastFrame];
	
	LLastFrame++;
	if (LLastFrame > 17)
		LlastFrame = 0;
}

defaultproperties
{
     bOnlyWhenSeen=False
     Frames(0)=Texture'KlingonFX01.Sparks.LBolt01'
     Frames(1)=Texture'KlingonFX01.Sparks.LBolt02'
     Frames(2)=Texture'KlingonFX01.Sparks.LBolt03'
     Frames(3)=Texture'KlingonFX01.Sparks.LBolt04'
     Frames(4)=Texture'KlingonFX01.Sparks.LBolt05'
     Frames(5)=Texture'KlingonFX01.Sparks.LBolt06'
     Frames(6)=Texture'KlingonFX01.Sparks.LBolt01'
     Frames(7)=Texture'KlingonFX01.Sparks.LBolt02'
     Frames(8)=Texture'KlingonFX01.Sparks.LBolt03'
     Frames(9)=Texture'KlingonFX01.Sparks.LBolt04'
     Frames(10)=Texture'KlingonFX01.Sparks.LBolt05'
     Frames(11)=Texture'KlingonFX01.Sparks.LBolt06'
     Frames(12)=Texture'KlingonFX01.Sparks.LBolt01'
     Frames(13)=Texture'KlingonFX01.Sparks.LBolt02'
     Frames(14)=Texture'KlingonFX01.Sparks.LBolt03'
     Frames(15)=Texture'KlingonFX01.Sparks.LBolt04'
     Frames(16)=Texture'KlingonFX01.Sparks.LBolt05'
     Frames(17)=Texture'KlingonFX01.Sparks.LBolt06'
     Frames(18)=Texture'KlingonFX01.Sparks.LBolt01'
     Frames(19)=Texture'KlingonFX01.Sparks.LBolt02'
     bDirectional=True
     LifeSpan=0.700000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.BloodSplat'
     DrawScale=0.500000
     AmbientGlow=254
     LightType=LT_Flicker
     LightBrightness=153
     LightHue=153
     LightRadius=10
     bRotateToDesired=True
}
