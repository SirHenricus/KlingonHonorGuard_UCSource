//=============================================================================
// BatlethProjectile.
//=============================================================================
class BatlethProjectile expands KlingonProjectiles;

#call q:\Klingons\Art\Weapons\Batleth\Pickup\Final\Batlethpu.mac

#exec MESH ORIGIN MESH=WeapBatlethPickup X=0 Y=0 Z=35 PITCH=128

var() sound		FleshHitSound;
var() sound		MetalHitSound;

var vector		StartLoc;

simulated function VelocitySpin(actor A,vector V)
{
	A.bFixedRotationDir=True;
	A.RotationRate=rotator(V);
}

auto state Flying
{
	simulated function HitWall(vector HitNor,actor HitAct)
	{
		local actor A,Item;
		local int	OldItemGoals;

		if (Role == ROLE_Authority && ExplosionEffect != None) {
			Spawn(ExplosionEffect);
		}
		if (HitAct.IsA('Mover')) {
			SetPhysics(PHYS_Falling);
			bBounce=True;
			Velocity=0.5*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
			if (VSize(Velocity) < 600)
			{
				Velocity = (normal(velocity) * 600) + vrand() * 30;
			}
			speed=VSize(Velocity);
			VelocitySpin(Self,Velocity);
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
				MakeNoise(0.25);
			}
			return;
		}
		if (Level.NetMode != NM_DedicatedServer) {
			speed=VSize(Velocity);
			PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
			MakeNoise(0.25);
		}
		if (Role == ROLE_Authority) {
			SpawnScorch(HitNor);
			OldItemGoals=Level.Game.ItemGoals;
			Item=Spawn(class 'Batleth',,,Location,rotator(Velocity));
			if (Inventory(Item) != None) {
				Inventory(Item).bRotatingPickup=False;
				Inventory(Item).RespawnTime=0.0;
				if (Level.NetMode != NM_Standalone)
					Inventory(Item).LifeSpan=30.0;
				Inventory(Item).GotoState('Pickup','Dropped');
			}
			Level.Game.ItemGoals=OldItemGoals;
			Destroy();
		}
	}
	simulated function Landed(vector HitNor)
	{
		HitWall(HitNor,None);
	}
	simulated function ProcessTouch(actor Other,vector HitLoc)
	{
		local float		DistScale;
		local vector	HitNor;

		if (Other.IsA('HGStatue') || Other.IsA('AttackDroid')) {
			SetPhysics(PHYS_Falling);
			bBounce=True;
			HitNor=Normal(HitLoc-Location);
			Velocity=0.5*((Velocity dot HitNor)*HitNor*(-2.0)+Velocity);
			speed=VSize(Velocity);
			VelocitySpin(Self,Velocity);
			if (Level.NetMode != NM_DedicatedServer) {
				PlaySound(ImpactSound,SLOT_Misc,FMax(0.5,speed/800),,DefaultSoundRadius);
				MakeNoise(0.25);
			}
			return;
		}
		if (bCanHitOwner == True || Other != Instigator) {
			Velocity=vect(0.0,0.0,0.0);
			Acceleration=vect(0.0,0.0,0.0);
			SetPhysics(PHYS_Falling);
		}
		if (Other != Self && Other != Instigator) { // && Pawn(Other) != None) {
			DistScale=(Abs(VSize(StartLoc-HitLoc))*0.006);
			Damage*=min(1.0,DistScale);
			Other.TakeDamage(Damage,Instigator,HitLoc,vect(0,0,0),HurtType);
		}
	}
	simulated function Tick(float delta)
	{
		Velocity.Z+=((Region.Zone.ZoneGravity.Z*(Mass*0.01))*delta);
		SetRotation(Rotation+RotationRate);
	}
	simulated function BeginState()
	{
		bCanHitOwner=False;
		Acceleration=speed*vector(Rotation);
		Velocity=Acceleration;
		StartLoc=Location;
		PlaySound(SpawnSound,,,,DefaultSoundRadius);
	}
}

defaultproperties
{
     WaterEffect=Class'Klingons.WaterBubble'
     TrailPercentage=0.500000
     ExplosionEffect=Class'Klingons.Spark1'
     HurtType=hacked
     speed=600.000000
     MaxSpeed=600.000000
     Damage=150.000000
     MomentumTransfer=20000
     ImpactSound=Sound'KlingonSFX01.Weapons.DaktaghWall'
     ExploWallOut=5.000000
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.WeapBatlethPickup'
     SoundVolume=128
     AmbientSound=Sound'KlingonSFX01.Weapons.BatThrowLp'
     CollisionRadius=10.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=40.000000
     Buoyancy=20.000000
     RotationRate=(Pitch=-3000)
}
