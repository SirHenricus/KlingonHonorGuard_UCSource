//=============================================================================
// BlindActors.
//=============================================================================
class BlindActors expands BlindAll;

function BlindRadiusActors(float BlindRadius)
{
	local float			dist;
	local KlingonPawn	Victims;
	local vector		Blindness;

	if (bBlindEntry) {
		return;
	}
	bBlindEntry=True;
	foreach VisibleCollidingActors(class 'KlingonPawn',Victims,BlindRadius) {
		if (Victims != Self) {
			dist=Abs(BlindRadius-VSize(Victims.Location-Location));
			dist*=(255.0/BlindRadius);
			dist=FClamp(dist,0.0,256.0);
			Blindness=vect(4,4,4)*dist;
		} 
	}
	bBlindEntry=False;
}

defaultproperties
{
}
