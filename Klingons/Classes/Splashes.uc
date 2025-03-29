//=============================================================================
// Splashes.
//=============================================================================
class Splashes expands KlingonEffects;

#call q:\Klingons\Art\Effects\Splash\Final\Splash.mac
#call q:\Klingons\Art\Effects\Splash\Final\SplashB.mac
#call q:\Klingons\Art\Effects\Splash\Final\SplashM.mac

var() mesh		BigSplashMesh,
				MediumSplashMesh;

var() float		BigDrawScale,
				MediumDrawScale;

var() float		PlayAnimRate,
				BigAnimRate,
				MediumAnimRate;

state SpecialEffect
{
Begin:
	if (DrawScale > 0.8) {
		DrawScale=BigDrawScale;
		Mesh=BigSplashMesh;
		PlayAnimRate=BigAnimRate;
	}
	else if (DrawScale > 0.4) {
		DrawScale=MediumDrawScale;
		Mesh=MediumSplashMesh;
		PlayAnimRate=MediumAnimRate;
	}
	else {
		DrawScale=Default.DrawScale;
	}
	PlayAnim('Splash',PlayAnimRate);
	FinishAnim();
	Destroy();
}

defaultproperties
{
     BigSplashMesh=Mesh'Klingons.EffectSplashB'
     MediumSplashMesh=Mesh'Klingons.EffectSplashM'
     BigDrawScale=0.200000
     MediumDrawScale=0.150000
     PlayAnimRate=1.000000
     BigAnimRate=0.700000
     MediumAnimRate=0.850000
     RemoteRole=ROLE_SimulatedProxy
     bParticles=True
}
