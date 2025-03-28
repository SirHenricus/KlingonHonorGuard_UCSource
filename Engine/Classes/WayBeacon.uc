//=============================================================================
// WayBeacon.
//=============================================================================
class WayBeacon expands Keypoint;

//temporary beacon for serverfind navigation

function touch(actor other)
{
	if (other == owner)
		PlayerPawn(owner).ShowPath();
}

defaultproperties
{
     bStatic=False
     bHidden=False
     LifeSpan=6.000000
     DrawType=DT_Mesh
     DrawScale=0.500000
     AmbientGlow=40
     bOnlyOwnerSee=True
     bCollideActors=True
     LightType=LT_Steady
     LightBrightness=125
     LightSaturation=125
}
