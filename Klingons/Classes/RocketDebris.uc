//=============================================================================
// RocketDebris.
//=============================================================================
class RocketDebris expands Explosions;

var() class<Effects>	DebrisEffect;
var() int				DebrisNum;
var() float				DebrisSpeed;

var actor				E;

simulated function EffectAnim(float delta)
{
	if (K.ScaleRate != 0.0) {
		E.DrawScale+=K.ScaleRate;
		if (E.DrawScale <= 0.0) {
			E.Destroy();
			Destroy();
		}
	}
	if (K.ScaleGlowRate != 0.0) {
		E.ScaleGlow+=K.ScaleGlowRate;
		if (E.ScaleGlow <= 0.0) {
			E.Destroy();
			Destroy();
		}
	}
}

auto state SpecialEffect
{
	simulated function BeginState()
	{
		local int			i;
		local float			AngInc;
		local rotator		R,
							StartRot;
		local RocketDebris	RO;

		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		Super.BeginState();
		if (RocketDebris(Owner) == None) {
			RO=Self;
		}
		else {
			RO=RocketDebris(Owner);
		}
		StartRot=Rotation;
		AngInc=65536/RO.DebrisNum;
		for (i=0 ; i < RO.DebrisNum ; i++) {
			R=StartRot;
			R.Yaw+=(AngInc*(FRand()+0.5))*i;
			E=Spawn(RO.DebrisEffect); //,,,,R);
			E.DrawScale=RO.DrawScale;
			E.Velocity=(vector(R)*RO.DebrisSpeed)*(1.0+FRand());
			E.Velocity.Z+=RO.DebrisSpeed*(1.0+FRand());
			E.SetPhysics(PHYS_Falling);
		}
	}
}

defaultproperties
{
     DebrisEffect=Class'Klingons.DebrisFlames'
     DebrisNum=8
     DebrisSpeed=200.000000
     EffectTimer=1.000000
     bHidden=True
     bDirectional=True
     RemoteRole=ROLE_None
     DrawScale=0.500000
     LightType=LT_None
     Mass=0.000000
}
