//=============================================================================
// RadarDish.
//=============================================================================
class RadarDish expands KlingonDecorations;

#call q:\klingons\art\missn_08\geometry\pawns\final\dish\dish.mac
#exec MESH ORIGIN MESH=RadarDish X=-200 Y=-125 Z=0 YAW=128
var () float TimeToExplode;
var() class<Shards>		ShardClass[10];
var() float				ShardCount;
var() float				ExplosionMomentum;
var() float			TriggerVelocity;


var float	starttriggertime;

function timer()
{
	spawn(class'AirExplosion3');
	SpawnShards();
	Destroy();
}

function Trigger(actor Other,pawn EventInstigator)
{
	setPhysics(PHYS_Projectile);
	RotationRate.Yaw = -5000;
	RotationRate.Roll = 3800;
	RotationRate.Pitch = 15000;
	starttriggertime = level.timeseconds;
	SetTimer(timetoexplode,false);
	Velocity = vector(Rotation) * TriggerVelocity;
}


function SpawnShards()
{
	local int		i,n;
	local actor		S;
	local vector	V;

	n=0;
	for (i=0 ; i < ShardCount ; i++) {
		if (n == 10 || ShardClass[n] == None) {
			n=0;
		}
		if (ShardClass[n] != None) {
			S=Spawn(ShardClass[n],Self);
			if (S != None) {
				if (S.Mass != 0.0) {
					V=(vect(0.5,0.5,1.0)*VRand());
					V.Z=Abs(V.Z);
					V*=((ExplosionMomentum/Mass)*(FRand()+0.25));
					S.Velocity=Velocity+V;
				}
				RandSpin(S,1.0);
			}
			n++;
		}
	}
}

defaultproperties
{
     TimeToExplode=5.000000
     ShardClass(0)=Class'Klingons.BoxShard01'
     ShardClass(1)=Class'Klingons.BoxShard02'
     ShardClass(2)=Class'Klingons.BoxBoomShard02'
     ShardClass(3)=Class'Klingons.BoxBoomShard01'
     ShardClass(4)=Class'Klingons.BoxBoomShard04'
     ShardClass(5)=Class'Klingons.BoxBoomShard05'
     ShardClass(6)=Class'Klingons.BoxBoomShard02'
     ShardClass(7)=Class'Klingons.BoxBoomShard03'
     ShardClass(8)=Class'Klingons.BoxBoomShard01'
     ShardClass(9)=Class'Klingons.BoxShard02'
     ShardCount=10.000000
     ExplosionMomentum=10.000000
     TriggerVelocity=200.000000
     bDirectional=True
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.RadarDish'
     CollisionRadius=30.000000
     CollisionHeight=32.000000
     bCollideActors=True
     bFixedRotationDir=True
}
