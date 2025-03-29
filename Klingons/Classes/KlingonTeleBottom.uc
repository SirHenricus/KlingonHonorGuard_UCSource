//=============================================================================
// KlingonTeleBottom.
//=============================================================================
class KlingonTeleBottom expands KlingonDecorations;

#call q:\Klingons\Art\Creatures\Teleport\T-Bse.mac

#exec MESH ORIGIN MESH=TeleBase X=0 Y=0 Z=35 YAW=128

var() string[64]		DestURL;

var KlingonTeleporter	T;

function BeginPlay()
{
	local vector				TLoc;

	T=Spawn(class 'KlingonTeleporter',Self,Tag,,Rotation);
	if (T != None) {
		TLoc=Location+(vect(0,0,1)*(T.CollisionHeight*0.5));
		T.SetLocation(TLoc);
		T.URL=DestURL;
		T.bChangesYaw=True;
		if (T.URL != "") {
			T.SetCollision(True,False,False);
		}
	}
}

defaultproperties
{
     bDirectional=True
     bMovable=False
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.TeleBase'
     CollisionRadius=35.000000
     CollisionHeight=5.000000
     bCollideActors=True
     bBlockActors=True
     bBlockPlayers=True
     LightType=LT_Pulse
     LightBrightness=255
     LightHue=140
     LightRadius=8
     LightPeriod=16
     LightPhase=16
}
