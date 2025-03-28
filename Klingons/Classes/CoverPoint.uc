//=============================================================================
// CoverPoint.
//=============================================================================
class CoverPoint expands Keypoint;

var 	   bool   bTaken;  //whether or not someone is using this cover
var(Cover) bool   bUniDirectional;  //if true, only good in one direction (useful for long skinny things like tables)
var(Cover) vector CoverDirection;	//if UniDirectional--the direction in which cover is useful

var(Cover) enum ECoverHeight
{
	COVER_WAISTHEIGHT,
	COVER_SHOULDERHEIGHT,
	COVER_BODYHEIGHT
} CoverHeight;  //height of top of cover--i.e. useful to duck, stand up, or just get behind to hide

function PreBeginPlay()
{
	CoverDirection = normal(vector(rotation));
}

defaultproperties
{
}
