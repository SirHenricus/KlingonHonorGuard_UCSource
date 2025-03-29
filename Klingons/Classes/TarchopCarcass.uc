//=============================================================================
// TarchopCarcass.
//=============================================================================
class TarchopCarcass expands KlingonCarcass;

function ForceMeshToExist()
{
	//XXXnever called
	Spawn(class 'Tarchop');
}

function PreBeginPlay()
{
	Super.PreBeginPlay();
	if (FRand() < 0.2)
		GibIt();
}


function GibIt()
{
	local TarchopGibs TCG;
	local int i;
	local Rotator rot;

	if (Level.Game.bLowGore)
		return;

	for (i=0; i<6; i++)
	{
		TCG = Spawn(class 'TCLeg');
		TCG.velocity = VRand() * 300;
		rot = Rotator(VRand());
		rot.pitch = -15288;
		TCG.SetRotation(rot);
		if (TCG.velocity.Z < 0)
			TCG.velocity.Z = -TCG.velocity.Z;
	}
	TCG = Spawn(class 'TCFlat');
	TCG.velocity = VRand() * 250;
	rot = Rotator(VRand());
	TCG.SetRotation(rot);

	if (TCG.velocity.Z < 0)
		TCG.velocity.Z = -TCG.velocity.Z;
			
	TCG = Spawn(class 'TCLong');
	TCG.velocity = VRand() * 100;
	if (TCG.velocity.Z < 0)
		TCG.velocity.Z = -TCG.velocity.Z;

	TCG = Spawn(class 'TCBlob');
	TCG.velocity = VRand() * 300;
	rot = Rotator(VRand());
	TCG.SetRotation(rot);
	if (TCG.velocity.Z < 0)
		TCG.velocity.Z = -TCG.velocity.Z;

	destroy();
}

function TakeDamage( int Damage, Pawn InstigatedBy, Vector Hitlocation, 
							Vector Momentum, name DamageType)
{
	
	Super.TakeDamage(Damage,InstigatedBy,HitLocation,Momentum,DamageType);

	if ( (((Damage > 15) || !IsAnimating()) && (CumulativeDamage > 7)) || (Damage > Mass) 
		|| ((Velocity.Z > 250) && !IsAnimating()) )
	{
		GibIt();
	}
}

defaultproperties
{
     bodyparts(0)=Mesh'Klingons.GibTCflat'
     bodyparts(1)=Mesh'Klingons.GibTClong'
     bodyparts(2)=Mesh'Klingons.GibTCblob'
     bodyparts(3)=Mesh'Klingons.GibTCleg'
     bodyparts(4)=Mesh'Klingons.GibTCleg'
     bodyparts(5)=Mesh'Klingons.GibTCleg'
     bodyparts(6)=Mesh'Klingons.GibTCleg'
     bodyparts(7)=Mesh'Klingons.GibTCleg'
     AnimSequence=BlownUp
     AnimFrame=0.990000
     Mesh=Mesh'Klingons.PawnTarchop'
     bCollideActors=True
}
