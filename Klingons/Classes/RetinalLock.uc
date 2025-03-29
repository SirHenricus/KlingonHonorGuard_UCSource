//=============================================================================
// RetinalLock.
//=============================================================================
class RetinalLock expands Locks;

#call q:\Klingons\Art\Decor\Lock\Retinal\Final\Retinal.mac

defaultproperties
{
     TriggerKey=Class'Klingons.RetinalKey'
     AccessDeniedMsg="You need a Holographic Retinal Projector to open this door "
     AccessDeniedSnd=Sound'KlingonSFX01.Beeps.Bp09'
     AccessApprovedMsg="Access Granted"
     AccessApprovedSnd=Sound'KlingonSFX01.Beeps.Bp23'
     Mesh=Mesh'Klingons.LockRetinalScanner'
}
