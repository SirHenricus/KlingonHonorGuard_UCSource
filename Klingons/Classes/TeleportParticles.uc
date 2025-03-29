//=============================================================================
// TeleportParticles.
//=============================================================================
class TeleportParticles expands TeleportEffects;

state SpecialEffect
{
Begin:
	PlayAnim('Start',0.2);
	FinishAnim();
	Destroy();
}

defaultproperties
{
     ScaleRate=-0.010000
     ChildEffect=None
     Physics=PHYS_Rotating
     Style=STY_Translucent
     Texture=Texture'KlingonFX01.Flares.Flare12'
     Skin=None
     bParticles=True
     bProjTarget=False
     bFixedRotationDir=True
     RotationRate=(Yaw=32000)
}
