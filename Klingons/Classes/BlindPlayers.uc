//=============================================================================
// BlindPlayers.
//=============================================================================
class BlindPlayers expands BlindAll;

function BlindRadiusActors(float BlindRadius)
{
	local float			dist;
	local KlingonPlayer	Victims;
	local vector		Blindness;

	if (bBlindEntry) {
		return;
	}
	bBlindEntry=True;
	foreach VisibleCollidingActors(class 'KlingonPlayer',Victims,BlindRadius) {
		if (Victims != Self) {
			if (Victims != None) {
				dist=Abs(BlindRadius-VSize(Victims.Location-Location));
				dist*=(255.0/BlindRadius);
				dist=FClamp(dist,0.0,256.0);
				Blindness=vect(4,4,4)*dist;
				Victims.ClientBlindPlayer(Blindness);
			}
		} 
	}
	bBlindEntry=False;
}

defaultproperties
{
}
