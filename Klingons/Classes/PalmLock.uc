//=============================================================================
// PalmLock.
//=============================================================================
class PalmLock expands Locks;

#call q:\Klingons\Art\Decor\Lock\Palm\Final\Palm.mac

defaultproperties
{
     TriggerKey=Class'Klingons.PalmKey'
     AccessDeniedMsg="You need a Digital Palm Imprint to open this door"
     AccessDeniedSnd=Sound'KlingonSFX01.Beeps.Bp09'
     AccessApprovedMsg="Access Granted"
     AccessApprovedSnd=Sound'KlingonSFX01.Beeps.Bp23'
     Mesh=Mesh'Klingons.LockPalmScanner'
}
