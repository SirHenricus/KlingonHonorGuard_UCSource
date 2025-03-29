//=============================================================================
// SentryTopCarcass.
//=============================================================================
class SentryTopCarcass expands KlingonCarcass;
var float LastSmoke;



function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'SentryGunTop');
}

function SpawnBlood(float Damage, vector HitLocation, vector Momentum)
{

}

function Tick(float Delta)
{
	LastSmoke += Delta;
	if (LastSmoke > 0.1)
	{
		spawn(class 'BlackSmoke2');
		LastSmoke = 0;
	}
}

	function HitWall(vector HitNormal, actor Wall)
	{
		//XXXSpawn(class 'Bloodspurt');
//		Velocity = 0.7 * (Velocity - 2 * HitNormal * (Velocity Dot HitNormal));
//		Velocity.Z *= 0.9;

		Velocity=((Velocity dot HitNormal)*HitNormal*(-2.0)+Velocity);
		if (Region.Zone.ZoneGravity.Z > -200)
		{
			Velocity *= 0.8;
	
			RotationRate.Yaw *= 0.8;
			RotationRate.Roll *= 0.8;
			RotationRate.Pitch *= 0.8;			
			if ( Abs(Velocity.Z) < 20)
			{
				bBounce = false;
				Disable('HitWall');
			}
			
		}
		else
		{
			Velocity *= 0.1;
			RotationRate.Yaw *= 0.2;
			RotationRate.Roll *= 0.2;
			RotationRate.Pitch *= 0.2;	
			PlaySound(sound'DaktaghWall',SLOT_Interact,1.0,,2200);
			SpawnBlood(5, Location, vect(0,0,0));					
			if ( Abs(Velocity.Z) < 200)
			{
				bBounce = false;
				Disable('HitWall');
			}
			
		}
		
//		Velocity*=(1.0-(Mass*0.01));
		
	}


function GibIt()
{
	
}

defaultproperties
{
     LifeSpan=30.000000
     Mesh=Mesh'Klingons.PawnSentryGunTop'
     CollisionRadius=12.000000
     bCollideActors=True
}
