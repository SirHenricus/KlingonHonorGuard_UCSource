//=============================================================================
// SmokeBreath.
//=============================================================================
class SmokeBreath expands Smokes;

var() float			BreathRate;
var() float			BreathTime;

var vector			BreathOffset;

var SmokeBreath		SB;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (SmokeBreath(K) == None) {
		SB=Self;
	}
	else {
		SB=SmokeBreath(K);
	}
}

state SpecialEffect
{
	simulated function Tick(float delta)
	{
		Super.Tick(delta);
		Velocity=(Velocity*0.5)+(((vect(0,0,2)*FRand())*SB.BreathRate)*delta);
	}
	simulated function Timer()
	{
		Super.Timer();
		Velocity=(Velocity*0.5)+(((vect(0,0,2)*FRand())*SB.BreathRate)*K.EffectTimer);
	}
	simulated function BeginState()
	{
		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		bHidden=False;
		Super.BeginState();
		Velocity=(vector(Rotation)*SB.BreathRate);
		SetPhysics(PHYS_Projectile);
	}
}

state() Breath
{
	simulated function Tick(float delta)
	{
		local SmokeBreath	E;

		SetLocation(Owner.Location+BreathOffset);
		SetRotation(Owner.Rotation);
		E=Spawn(Class,Owner);
		E.GotoState('SpecialEffect');
	}
	simulated function Timer()
	{
		Destroy();
	}
	simulated function BeginState()
	{
		Disable('Tick');
		bHidden=True;
		SetTimer(BreathTime,False);
		BreathOffset=Location-Owner.Location;
		Enable('Tick');		
	}
}

defaultproperties
{
     BreathRate=200.000000
     BreathTime=1.000000
     RisingRate=0.000000
     ScaleRate=0.020000
     EffectTimer=0.050000
     Frames(0)=Texture'WeaponFX01.Smokes.smokew001'
     Frames(1)=Texture'WeaponFX01.Smokes.smokew002'
     Frames(2)=Texture'WeaponFX01.Smokes.smokew003'
     Frames(3)=Texture'WeaponFX01.Smokes.smokew004'
     Frames(4)=Texture'WeaponFX01.Smokes.smokew005'
     Frames(5)=Texture'WeaponFX01.Smokes.smokew006'
     Frames(6)=Texture'WeaponFX01.Smokes.smokew007'
     Frames(7)=Texture'WeaponFX01.Smokes.smokew008'
     Frames(8)=Texture'WeaponFX01.Smokes.smokew009'
     bHidden=True
     InitialState=Breath
     bNet=False
     bNetSpecial=False
     DrawScale=0.400000
}
