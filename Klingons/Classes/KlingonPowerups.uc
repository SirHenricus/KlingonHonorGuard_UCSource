//=============================================================================
// KlingonPowerups.
//=============================================================================
class KlingonPowerups expands Pickup;

var() float		PowerupAmount;
var() bool		bSuperPowerup;

#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01
#exec OBJ LOAD FILE=..\Textures\KlingonHUD.utx PACKAGE=KlingonHUD


simulated function RandSpin(actor A,float Scale)
{
	A.bFixedRotationDir=True;
	A.RotationRate=RotRand(True)*Scale;
}

simulated function VelocitySpin(actor A,vector V)
{
	A.bFixedRotationDir=True;
	A.RotationRate=rotator(V);
}

simulated function MomentumMove(actor A,vector Momentum)
{
	if (Level.NetMode != NM_StandAlone || (Level.Game != None && Level.Game.IsA('DeathMatchGame'))) {
		return;
	}
	A.bBounce=True;
	A.bCollideWorld=True;
	A.SetPhysics(PHYS_Falling);
	A.Velocity+=(Momentum/A.Mass);
	VelocitySpin(A,A.Velocity);
}

simulated function Landed(vector HitNormal)
{
	local rotator	R;
	local float		FallDamage;

	FallDamage=Abs(0.015*Velocity.Z);
	TakeDamage(FallDamage,None,Location,vect(0,0,0),'fell');
	Velocity=((Velocity dot HitNormal)*HitNormal*(-2.0)+Velocity);
	Velocity*=(1.0-(Mass*0.01));
	if (Region.Zone.bWaterZone == False) {
		R=Rotation;
		if (VSize(Velocity) < 30) {
			bBounce=False;
			SetPhysics(PHYS_None);
			Velocity=vect(0,0,0);
			bFixedRotationDir=False;
			R.Roll=0.0;
		}
		R.Pitch=0.0;
		SetRotation(R);
	}
}

singular function ZoneChange(ZoneInfo NewZone)
{
	local KlingonGameInfo	K;

	K=KlingonGameInfo(Level.Game);
	if (K != None) {
		K.ActorZoneChange(NewZone,Self);
	}
}

auto state Pickup
{
	simulated function ZoneChange(ZoneInfo NewZone)
	{
		if (NewZone.bWaterZone) {
			RotationRate*=0.9;
		}
		Global.ZoneChange(NewZone);
	}
	function Touch(actor Other)
	{
		local int	HealMax;
	
		if (ValidTouch(Other)) {		
			HealMax=Pawn(Other).Default.Health;
			if (bSuperPowerup) {
				HealMax=HealMax*2.0;
			}
			if ((Pawn(Other).Health < HealMax) || (Other.IsA('Bots'))) {
				Pawn(Other).Health+=PowerupAmount;
				if (Pawn(Other).Health > HealMax) {
					Pawn(Other).Health=HealMax;
				}
				if (PlayerPawn(Other) != None) {
					if (bSuperPowerup) {
						Pawn(Other).ClientMessage(PickupMessage);
					}
					else {
						Pawn(Other).ClientMessage(PickupMessage$PowerupAmount);
					}
				}
				PlaySound(PickupSound);
				if (Level.Game.Difficulty > 1) {
					Other.MakeNoise(0.1*Level.Game.Difficulty);
				}
				if (bIsItemGoal) {
					Pawn(Other).ItemCount++;
					if (Level.Game != None) {
						if (KlingonGameInfo(Level.Game) != None) {
							KlingonGameInfo(Level.Game).ItemCount++;
						}
					}
				}
				SetRespawn();
			}
		}
	}
	simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
	{
		if (Mass > 0.0) {
			MomentumMove(Self,Momentum);
		}
	}
	simulated function Landed(vector HitNormal)
	{
		Global.Landed(HitNormal);
	}
	simulated function HitWall(vector HitNormal,actor HitWall)
	{
		Global.Landed(HitNormal);
	}
}

defaultproperties
{
     RespawnTime=60.000000
     PickupSound=Sound'KlingonSFX01.Pickups.Health3'
     RespawnSound=Sound'KlingonSFX01.Effects.Replicator'
     bMeshCurvy=False
     bProjTarget=True
     Mass=30.000000
}
