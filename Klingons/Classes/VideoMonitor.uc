//=============================================================================
// VideoMonitor.
//=============================================================================
class VideoMonitor expands Destructable;

#call q:\Klingons\Art\Decor\VideoBox\Final\VideoBox1.mac

var() texture	AnimatedTextures[5];
var() float		AnimatedFPS;

var int			AnimatedFrame;

var float		AnimatedTicks;

simulated function Tick(float delta)
{
	Super.Tick(delta);
	AnimatedTicks+=delta;
	if (AnimatedTicks > (1.0/(AnimatedFPS+1.0))) {
		AnimatedTicks-=(1.0/(AnimatedFPS+1.0));
		if (AnimatedTextures[AnimatedFrame] == None) {
			AnimatedFrame=0;
		}
		Skin=AnimatedTextures[AnimatedFrame];
		AnimatedFrame++;
	}
}

auto state Sitting
{
	function Touch(actor Other)
	{
		local actor		A;
		local rotator swaprot;

		if (KlingonPlayer(Other) != None) 
		{
			swaprot = rotation;
			swaprot.yaw -= 16383;
			if (vsize(vector(KlingonPlayer(Other).rotation) + vector(swaprot)) < 1)
			{
				if (Event != '') 
				{
					foreach AllActors(class 'Actor',A,Event) 
					{
						A.Trigger(Other,Other.Instigator);
					}
				}
			}
		}
	}
	function UnTouch(actor Other)
	{
		local actor	A;

		if (KlingonPlayer(Other) != None) {
			if (Event != '') {
				foreach AllActors(class 'Actor',A,Event) {
					A.UnTrigger(Other,Other.Instigator);
				}
			}
		}
	}
Begin:
	AccumulatedDamage=0;
}

defaultproperties
{
     AnimatedTextures(0)=Texture'KlingonFX01.Items.Vidbox01'
     AnimatedTextures(1)=Texture'KlingonFX01.Items.Vidbox02'
     AnimatedTextures(2)=Texture'KlingonFX01.Items.Vidbox03'
     AnimatedTextures(3)=Texture'KlingonFX01.Items.Vidbox04'
     AnimatedFPS=10.000000
     ExplosionDamage=0.000000
     ExplosionRadius=0.000000
     ExplosionMomentum=0.000000
     ObjectHealth=0.000000
     ObjectDamagedEffect=None
     bPushable=False
     DrawType=DT_Mesh
     Texture=Texture'KlingonFX01.Items.Vidbox01'
     Mesh=Mesh'Klingons.VideoBox'
     DrawScale=1.400000
     CollisionRadius=15.000000
     bCollideWorld=False
     bBlockActors=False
     bBlockPlayers=False
     bProjTarget=False
     Mass=0.000000
     Buoyancy=0.000000
}
