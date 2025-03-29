//=============================================================================
// WhiteSteam1.
//=============================================================================
class WhiteSteam1 expands Smokes;

var() float			SteamRate;
var() float			SteamTime;

var WhiteSteam1		WS;

auto state SpecialEffect
{
	simulated function Tick(float delta)
	{
		local float		ZoneZ;

		Super.Tick(delta);
		ZoneZ=Abs(Region.Zone.ZoneGravity.Z);
		Velocity=(Velocity*0.75)+((((vect(0,0,0.001)*ZoneZ)*FRand())*WS.SteamRate)*delta);
	}
	simulated function Timer()
	{
		local float		ZoneZ;

		Super.Timer();
		ZoneZ=Abs(Region.Zone.ZoneGravity.Z);
		Velocity=(Velocity*0.75)+((((vect(0,0,0.001)*ZoneZ)*FRand())*WS.SteamRate)*K.EffectTimer);
	}
	simulated function BeginState()
	{
		if (Level.NetMode != NM_StandAlone && !bNet) {
			Destroy();
			return;
		}
		bHidden=False;
		Super.BeginState();
		if (WhiteSteam1(K) == None) {
			WS=Self;
		}
		else {
			WS=WhiteSteam1(K);
		}
		Velocity=(vector(Rotation)*WS.SteamRate);
		SetPhysics(PHYS_Projectile);
		DrawScale=K.DrawScale;
		SteamRate=WS.SteamRate;
	}
}

state() TriggerTimedSteam
{
	simulated function Tick(float delta)
	{
		local WhiteSteam1	E;

		E=Spawn(Class,Self);
//		E.DrawScale=DrawScale;
//		E.SteamRate=SteamRate;
		E.GotoState('SpecialEffect');
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
		local WhiteSteam1	E;

		E=Spawn(Class,Self);
//		E.SteamRate=SteamRate;
		E.GotoState('SpecialEffect');
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
     RisingRate=0.000000
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
     InitialState=ContinuousSteamOn
     bNet=False
     bNetSpecial=False
     DrawScale=0.400000
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bCollideWorld=True
}
