//=============================================================================
// KlingonPatrolPoint.
//=============================================================================
class KlingonPatrolPoint expands PatrolPoint;

var() name		PatrolAnimList[5];
var() name		PatrolEventList[5];
var() sound		PatrolSoundList[5];
var() float		PatrolSoundRadius[5];
var() int		NumSeperateAnims;

defaultproperties
{
     PatrolSoundRadius(0)=600.000000
     PatrolSoundRadius(1)=600.000000
     PatrolSoundRadius(2)=600.000000
     PatrolSoundRadius(3)=600.000000
     PatrolSoundRadius(4)=600.000000
}
