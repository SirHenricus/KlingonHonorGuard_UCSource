//=============================================================================
// BlindAll.
//=============================================================================
class BlindAll expands KlingonEffects;

var() float		BlindRadius;
var() name		HurtType;

var bool		bBlindEntry;

var BlindAll	BA;

simulated function DetermineOwner()
{
	Super.DetermineOwner();
	if (BlindAll(K) == None) {
		BA=Self;
	}
	else {
		BA=BlindAll(K);
	}
}

function BlindRadiusActors(float BlindRadius)
{
	local float		dist;
	local pawn		Victims;
	local vector	Blindness;

	if (bBlindEntry) {
		return;
	}
	bBlindEntry=True;
	foreach VisibleCollidingActors(class 'Pawn',Victims,BlindRadius) {
		if (Victims != Self) {
			if (KlingonPlayer(Victims) != None) {
				dist=Abs(BlindRadius-VSize(Victims.Location-Location));
				dist*=(255.0/BlindRadius);
				dist=FClamp(dist,0.0,256.0);
				Blindness=vect(4,4,4)*dist;
				KlingonPlayer(Victims).ClientBlindPlayer(Blindness);
			}
		} 
	}
	bBlindEntry=False;
}

state SpecialEffect
{
	simulated function BeginState()
	{
		Super.BeginState();
		BlindRadiusActors(BA.BlindRadius);
	}
}

defaultproperties
{
     BlindRadius=1000.000000
     HurtType=Blinded
     EffectSound=Sound'KlingonSFX01.Weapons.Exp5'
     ChildEffect=Class'Klingons.ParticleWave'
     bHidden=True
     RemoteRole=ROLE_SimulatedProxy
}
