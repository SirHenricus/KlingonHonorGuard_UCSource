//=============================================================================
// LadderLifter.
//=============================================================================
class LadderLifter expands KlingonDecorations;

#call q:\Klingons\Art\Decor\Boxes\TallBox\Final\LadderLift.mac
//#call q:\Klingons\Art\Decor\LadderLift\Final\LadderLift.mac

//#exec MESH ORIGIN MESH=LadderLift X=0 Y=0 Z=15

var() sound		LadderStartSound;
var() sound		LadderStopSound;
var() sound		LadderMovingSound;

var float		LadderLiftSpeed;

var vector		LadderLiftTop,
				LadderLiftBottom,
				LadderVelocity;

simulated function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLocation,Vector Momentum,name DamageType)
{
}

simulated function ZoneChange(ZoneInfo NewZone)
{
}

simulated function HitWall(vector HitNor,actor HitActor)
{
}

simulated function Landed(vector HitNor)
{
}

simulated function Destroyed()
{
}

simulated function Bump(actor Other)
{
}

singular function BaseChange()
{
}

state LadderLiftUp
{
	simulated function Tick(float delta)
	{
		if (Location.Z >= LadderLiftTop.Z) {
			if (VSize(Velocity) != 0) {
				Velocity=vect(0,0,0);
				SetPhysics(PHYS_None);
				SetLocation(LadderLiftTop);
				if (Level.NetMode != NM_DedicatedServer) {
					PlaySound(LadderStopSound);
					AmbientSound=None;
				}
				GotoState('LadderLiftDown'); //,'Wait4Sec');
			}
		}
		else {
			if (VSize(Velocity) != VSize(LadderVelocity)) {
				Velocity=LadderVelocity;
			}
			if (Physics != PHYS_Projectile) {
				SetPhysics(PHYS_Projectile);
			}
		}
	}
	simulated function Timer()
	{
		SetPhysics(PHYS_Projectile);
		Velocity=vect(0,0,1)*LadderLiftSpeed;
		LadderVelocity=Velocity;
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(LadderStartSound);
			AmbientSound=LadderMovingSound;
		}
		Enable('Tick');
	}
	simulated function BeginState()
	{
		Disable('Tick');
		SetTimer(2,False);
	}
}

state LadderLiftDown
{
	simulated function Tick(float delta)
	{
		if (Location.Z <= LadderLiftBottom.Z) {
			if (VSize(Velocity) != 0) {
				Velocity=vect(0,0,0);
				SetPhysics(PHYS_None);
				SetLocation(LadderLiftBottom);
				if (Level.NetMode != NM_DedicatedServer) {
					PlaySound(LadderStopSound);
					AmbientSound=None;
				}
				GotoState('Waiting'); //,'Wait4Sec');
			}
		}
		else {
			if (VSize(Velocity) != VSize(LadderVelocity)) {
				Velocity=LadderVelocity;
			}
			if (Physics != PHYS_Projectile) {
				SetPhysics(PHYS_Projectile);
			}
		}
	}
	simulated function Timer()
	{
		SetPhysics(PHYS_Projectile);
		Velocity=vect(0,0,-1)*LadderLiftSpeed;
		LadderVelocity=Velocity;
		if (Level.NetMode != NM_DedicatedServer) {
			PlaySound(LadderStartSound);
			AmbientSound=LadderMovingSound;
		}
		Enable('Tick');
	}
	simulated function BeginState()
	{
		Disable('Tick');
		SetTimer(4,False);
	}
}

auto state Waiting
{
	simulated function Bump(actor Other)
	{
		if (Other.IsA('PlayerPawn')) {
			GotoState('LadderLiftUp'); //,'Wait2Sec');
		}
	}
	simulated function Timer()
	{
		local int	i;

		Enable('Bump');
		for (i=0 ; i < 4 ; i++) {
			if (touching[i] != None) {
				Bump(touching[i]);
			}
		}
	}
	simulated function BeginState()
	{
		Disable('Bump');
		SetTimer(2,False);
	}
}

defaultproperties
{
     LadderStartSound=Sound'KlingonSFX01.Movers.LiftStrt'
     LadderStopSound=Sound'KlingonSFX01.Movers.LiftEnd'
     LadderMovingSound=Sound'KlingonSFX01.Movers.LiftLoop'
     LadderLiftSpeed=75.000000
     bStasis=False
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.LadderLift'
     CollisionRadius=1.000000
     CollisionHeight=1.000000
     bProjTarget=True
}
