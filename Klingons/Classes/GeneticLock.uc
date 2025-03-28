//=============================================================================
// GeneticLock.
//=============================================================================
class GeneticLock expands Locks;

#call q:\Klingons\Art\Decor\Lock\Genetic\Final\Genetic.mac

defaultproperties
{
     TriggerKey=Class'Klingons.GeneticKey'
     AccessDeniedMsg="You need a Genetic Key to open this door "
     AccessDeniedSnd=Sound'KlingonSFX01.Beeps.Bp09'
     AccessApprovedMsg="Access Granted"
     AccessApprovedSnd=Sound'KlingonSFX01.Beeps.Bp23'
     Mesh=Mesh'Klingons.LockGenetic'
     DrawScale=0.500000
}
