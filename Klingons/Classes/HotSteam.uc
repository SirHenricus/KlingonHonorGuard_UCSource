//=============================================================================
// HotSteam.
//=============================================================================
class HotSteam expands DamageEffects;

var() float		SteamRate;
var() float		SteamTime;

var HotSteam	HS;

state SpecialEffect
{
	simulated event PreBeginPlay()
	{
		if (DrawScale != Default.Drawscale) {
			SetCollisionSize(CollisionRadius*DrawScale/Default.DrawScale,CollisionHeight*DrawScale/Default.DrawScale);
		}
	}
	simulated function Tick(float delta)
	{
		local float		ZoneZ;

		Super.Tick(delta);
		ZoneZ=Abs(Region.Zone.ZoneGravity.Z);
		Velocity=(Velocity*0.75)+((((vect(0,0,0.001)*ZoneZ)*FRand())*HS.SteamRate)*delta);
	}
	simulated function Timer()
	{
		local float		ZoneZ;

		Super.Timer();
		ZoneZ=Abs(Region.Zone.ZoneGravity.Z);
		Velocity=(Velocity*0.75)+((((vect(0,0,0.001)*ZoneZ)*FRand())*HS.SteamRate)*K.EffectTimer);
	}
	simulated function BeginState()
	{
		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		bHidden=False;
		Super.BeginState();
		if (HotSteam(K) == None) {
			HS=Self;
		}
		else {
			HS=HotSteam(K);
		}
		Velocity=(vector(Rotation)*HS.SteamRate);
		SetPhysics(PHYS_Projectile);
		DrawScale=K.DrawScale;
		SteamRate=HS.SteamRate;
	}
}

state() TriggerTimedSteam
{
	simulated function Tick(float delta)
	{
		local HotSteam	E;

		if (PlayerCanSeeMe())
		{
			E=Spawn(Class,K);
			E.GotoState('SpecialEffect');
		}
	}
	simulated function Timer()
	{
		Disable('Tick');
	}
	simulated function Trigger(actor Other,pawn EventInstigator)
	{
		Enable('Tick');
		SetTimer(SteamTime,False);
	}
	simulated function BeginState()
	{
		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		DetermineOwner();
		bHidden=True;
		Disable('Tick');
		if (bOnlyWhenSeen) {
			bStasis=True;
		}
	}
}

state() ContinuousSteamOn
{
	simulated function Tick(float delta)
	{
		local HotSteam	E;
		if (PlayerCanSeeMe())
		{
			E=Spawn(Class,K);
			E.GotoState('SpecialEffect');
		}
	}
	simulated function Timer()
	{
		GotoState('ContinuousSteamOff');
	}
	simulated function BeginState()
	{
		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		DetermineOwner();
		bHidden=True;
		SetTimer(SteamTime,False);
		if (bOnlyWhenSeen) {
			bStasis=True;
		}
	}
}
		
state() ContinuousSteamOff
{
	simulated function Timer()
	{
		GotoState('ContinuousSteamOn');
	}
	simulated function BeginState()
	{
		DetermineOwner();
		bHidden=True;
		SetTimer(SteamTime,False);
		if (bOnlyWhenSeen) {
			bStasis=True;
		}
	}
}

defaultproperties
{
     SteamRate=200.000000
     DamageAmount=1.000000
     DamagePercent=0.500000
     MomentumTransfer=5.000000
     HurtType=burned
     ScaleRate=0.025000
     EffectTimer=0.100000
     Frames(0)=Texture'WeaponFX01.Smokes.smokew001'
     Frames(1)=Texture'WeaponFX01.Smokes.smokew002'
     Frames(2)=Texture'WeaponFX01.Smokes.smokew003'
     Frames(3)=Texture'WeaponFX01.Smokes.smokew004'
     Frames(4)=Texture'WeaponFX01.Smokes.smokew005'
     Frames(5)=Texture'WeaponFX01.Smokes.smokew006'
     Frames(6)=Texture'WeaponFX01.Smokes.smokew007'
     Frames(7)=Texture'WeaponFX01.Smokes.smokew008'
     Frames(8)=Texture'WeaponFX01.Smokes.smokew009'
     bDirectional=True
     RemoteRole=ROLE_None
     InitialState=ContinuousSteamOn
     bNet=False
     bNetSpecial=False
     DrawScale=0.400000
     CollisionRadius=4.000000
     CollisionHeight=4.000000
     bCollideWorld=True
}
