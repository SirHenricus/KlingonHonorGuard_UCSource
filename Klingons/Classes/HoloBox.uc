//=============================================================================
// HoloBox.
//=============================================================================
class HoloBox expands KlingonDecorations;

var float LastUpdate;
var() bool HolodeckVisible;
var() float TimeIn;
var() float TimeOut;

var Pawn OldInstigator;

#call q:\klingons\art\effects\hologrid\final\HoloGrid1.mac

#exec MESH ORIGIN MESH=HoloGrid X=0 Y=0 Z=-5 YAW=0


function FadeAllPawns()
{
	local KlingonPawn A;
	
			foreach RadiusActors(class 'KlingonPawn', A, 3000)
			{
//				log("triggering "$A);
//				A.TakeDamage(500, OldInstigator, A.location, vect(0,0,0),'Disintegrated');
//				A.VolumeRadius = 0;
//				A.LightRadius = 0;
				A.PlayWaiting();
				A.ClientGameEnded();
			}
	
}

auto state Startup
{
Begin:
	if (Level.NetMode != NM_Standalone)
	{
		bHidden = true;
	}
	else
	{
		if (HolodeckVisible)
			GotoState('HoloVisible');
		else
			GotoState('HoloInVisible');
	}
		
}


state GoingVis2
{
	function tick(float Delta)
	{
		local Actor A;

		if (Level.NetMode != NM_Standalone)
			return;
		
		LastUpdate += Delta;
		if (LastUpdate > 0.05)
		{

			AmbientGlow =255;
			LastUpdate = 0;
//			ScaleGlow +=0.08;
			if (TimeIn < 0.1)
				TimeIn = 1;
			ScaleGlow += (Delta / TimeIn);
			if (ScaleGlow > 1.0)
			{
				Style = STY_Normal;
				ScaleGlow = 1.0;
//				KlingonPlayer(OldInstigator).GotoState('UnlockControls');
				GotoState('HoloVisible');
			}
		}
	}
}


state() GoingVisible
{
	
begin:
	if (Level.NetMode != NM_Standalone)
	{
		bHidden = true;
	}
	else
	{
	
//		log("going visible");
		
		Style = STY_Translucent;
		ScaleGlow = 0.0;
		PlaySound(sound'BP22');
		
		FadeAllPawns();			
		
		sleep(2.0);
		PlaySound(sound'BP22');
		
		GotoState('GoingVis2');	
	}
	
}




state() GoingInvisible
{
	function tick(float Delta)
	{
		if (Level.NetMode != NM_Standalone)
			return;
	
		LastUpdate += Delta;
		if (LastUpdate > 0.05)
		{
			LastUpdate = 0;
			if (TimeOut < 0.1)
				TimeOut = 1;
			ScaleGlow -= (Delta / TimeOut);
//			ScaleGlow -=0.02;
			if (ScaleGlow <= 0.02)
			{
				ScaleGlow = 0.0;
				KlingonPlayer(OldInstigator).GotoState('UnlockControls');
				PlaySound(sound'BP22');
				
				GotoState('HoloInvisible');
			}
		}
	}
	
begin:
	if (Level.NetMode != NM_Standalone)
	{
		bHidden = true;
	}
	else
	{
		Style = STY_Translucent;
		ScaleGlow = 1.0;
		PlaySound(sound'BP22');
	}
	
}


// Active means its not there and you are playing in the holodeck
state() HoloInvisible
{
begin:
	if (Level.NetMode != NM_Standalone)
	{
		bHidden = true;
	}
	else
	{
		ScaleGlow = 0.0;
		AmbientGlow = 0;
		SetLocation(location+vect(0,0,-2000));
		Style = STY_Translucent;
	}

}


state() HoloVisible
{
begin:

	if (Level.NetMode != NM_Standalone)
	{
		bHidden = true;
	}
	else
	{
		Style = STY_Normal;
		ScaleGlow = 1.0;
		if (KlingonPlayer(OldInstigator) != none)
		{
			if (KlingonPlayer(OldInstigator).Health <= 0)
			{
				KlingonPlayer(OldInstigator).ReStartLevel(); 				
			}
		}
	}
	
	
}

function trigger(actor Other, Pawn Instigator)
{
	local HoloBox Ho;
	local float temp1;	
	local vector temp2;
	HolodeckVisible = !HolodeckVisible;

	if (Level.NetMode != NM_Standalone)
		return;
		
	if (HolodeckVisible)
	{
		if (KlingonPlayer(Instigator) != none)
		{
			
			Setlocation( KlingonPlayer(Instigator).location + vect (0,0,35));
			GotoState('GoingVisible');
//			GotoState('HoloVisible');
			OldInstigator = Instigator;
			KlingonPlayer(Instigator).GotoState('LockControls');
		}
	}
	else
	{
		if (KlingonPlayer(Instigator) != none)
		{
//			Setlocation( KlingonPlayer(Instigator).location + vect (0,0,35));
//			Setlocation( KlingonPlayer(Instigator).location + vect (0,0,35));

			GotoState('GoingInVisible');
			OldInstigator = Instigator;
			KlingonPlayer(Instigator).GotoState('lockControls');
		}
		
	}
}



state Sitting
{
begin:
//	Do nada
}

defaultproperties
{
     TimeIn=2.000000
     TimeOut=2.000000
     DrawType=DT_Mesh
     Style=STY_Translucent
     Mesh=Mesh'Klingons.HoloGrid'
     ScaleGlow=0.000000
     CollisionRadius=32.000000
     CollisionHeight=15.000000
     bCollideActors=True
     bCollideWorld=True
}
