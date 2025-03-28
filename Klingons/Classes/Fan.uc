//=============================================================================
// Fan.
//=============================================================================
class Fan expands Destructable;

#call q:\Klingons\Art\Missn_14\Geometry\Actors\Fan\Final\Fan.mac

#exec MESH ORIGIN MESH=Fan X=0 Y=0 Z=175 YAW=64

#exec MESH NOTIFY MESH=Fan SEQ=Spin TIME=0.33 FUNCTION=PullRadiusActors
#exec MESH NOTIFY MESH=Fan SEQ=Spin TIME=0.66 FUNCTION=PullRadiusActors
#exec MESH NOTIFY MESH=Fan SEQ=Spin TIME=0.99 FUNCTION=PullRadiusActors

var() float			FanRPM;
var() float			FanDamage;
var() float			FanForce;
var() float			FanRadius;
var() name			FanHurtType;
var() bool			bFanOn;
var() sound			FanBladeSound;
var() float			FanSoundRadius;
var() bool			bSpinUp;

var float			FanStartRPM;

var bool			bInPullRadiusFunction;

var int				Iterations;

function PullRadiusActors()
{
	Iterations++;
}

function CalcPullRadiusActors()
{
	local float		D,
					dx,
					PullRadius,
					RPMScale,
					ScaledDamage;
	local actor		A;
	local vector	Dir,V;
	local int		VisibleCount;
	local int		i,n;

	if (bInPullRadiusFunction) {
		return;
	}
	if (FanForce == 0.0) {
		return;
	}
	n=Iterations;
	bInPullRadiusFunction=True;
	for (i=0 ; i < n ; i++) {
		if (FanRPM > 0.0) {
			RPMScale=FanRPM*FanForce;
			if (FanRadius == 0.0) {
				PullRadius=CollisionRadius*(FanRPM*0.2)*DrawScale;
			}
			else {
				PullRadius=FanRadius;
			}
			VisibleCount=0;
			foreach VisibleActors(class 'Actor',A,PullRadius) {
				if (A.Mass > 0.0 && Mover(A) == None) {
					Dir=Location-A.Location;
					dx=Fmax(VSize(Dir),1.0);
					V=(Normal(Dir)*((RPMScale*DrawScale*20000.0)/(dx*dx)));
					D=(Dir dot vector(Rotation));
					if (D >= 0.0) {
						V*=-1.0;
					}
					if (Pawn(A) != None) {
						Pawn(A).Velocity+=(V/A.Mass); //AddVelocity(V/A.Mass);
					}
					else {
						MomentumMove(A,V);
					}
					if (VisibleCount < 30) {
						VisibleCount++;
					}
					else {
						break;
					}
					if (FanDamage > 0) {
						if (dx < ((CollisionRadius+CollisionHeight)*0.5)) {
							V=vect(0,0,0);
							ScaledDamage=FanDamage*RPMScale*DrawScale;
							A.TakeDamage(ScaledDamage,None,Location,V,FanHurtType);
						}
					}
				}
			}
			if (FanBladeSound != None) {
				if (FanStartRPM != 0.0) {
					PlaySound(FanBladeSound,,,,FanSoundRadius,Fmax(FanRPM/FanStartRPM,0.25));
				}
			}
		}
		if (!bFanOn) {
			if (bSpinUp) {
				if (FanRPM > 0.0) {
					if (DrawScale == 0.0) {
						FanRPM=FanRPM-1.0;
					}
					else {
						FanRPM=FanRPM-Fmin(0.9/DrawScale,0.9);
					}
					if (FanRPM <= 1.0) {
						FanRPM=0.0;
						LoopAnim('Stop');
					}
					else {
						LoopAnim('Spin',FanRPM/20.0);
					}
				}
			}
			else {
				FanRPM=0.0;
				LoopAnim('Stop');
			}
		}
		else if (FanRPM != FanStartRPM) {
			if (bSpinUp) {
				if (DrawScale == 0.0) {
					FanRPM=FanRPM+1.0;
				}
				else {
					FanRPM=FanRPM+Fmin(0.9/DrawScale,0.9);
				}
				if (FanRPM > FanStartRPM) {
					FanRPM=FanStartRPM;
				}
			}
			else {
				FanRPM=FanStartRPM;
			}
			LoopAnim('Spin',FanRPM/20.0);
		}
	}
	bInPullRadiusFunction=False;
	Iterations-=n;
}

function ShardSpawned(actor S)
{
	S.Skin=Skin;
}

function Tick(float delta)
{
/*
	local float		D;
	local vector	M;
	local actor		A;
*/
	Super.Tick(delta);
	CalcPullRadiusActors();
/*
	if (FanDamage > 0) {
		foreach TouchingActors(class 'Actor',A) {
			M=vect(0,0,0);
			D=FanDamage*FanRPM*FanForce*DrawScale;
			A.TakeDamage(int(D),None,A.Location,M,FanHurtType);
		}
	}
*/
}

auto state Sitting
{
	function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
	{
		if (InstigatedBy != None) {
			Super.TakeDamage(Damage,InstigatedBy,HitLoc,Momentum,DamageType);
		}
	}
	function Trigger(actor Other,pawn InstigatedBy)
	{
		if (bFanOn) {
			bFanOn=False;
		}
		else {
			FanRPM=1.0;
			bFanOn=True;
			LoopAnim('Spin',FanRPM/20.0);
		}
	}
	function BeginState()
	{
		FanStartRPM=FanRPM;
		if (bFanOn) {
			FanRPM=1.0;
			LoopAnim('Spin',FanRPM/20.0);
		}
		else {
			LoopAnim('Stop');
		}
	}
Begin:
	AccumulatedDamage=0;
}

defaultproperties
{
     FanRPM=20.000000
     FanDamage=100.000000
     FanForce=100.000000
     FanHurtType=Blended
     bFanOn=True
     FanSoundRadius=1600.000000
     bSpinUp=True
     ExplosionDamage=0.000000
     ObjectDamagedEffect=None
     ShardClass(0)=Class'Klingons.FanShard'
     ShardClass(1)=Class'Klingons.FanShard02'
     ShardClass(2)=Class'Klingons.FanShard03'
     ShardClass(3)=Class'Klingons.FanShard04'
     ShardCount=4.000000
     bPushable=False
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.Fan'
     CollisionRadius=42.000000
     CollisionHeight=42.000000
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
     Mass=0.000000
     Buoyancy=0.000000
}
