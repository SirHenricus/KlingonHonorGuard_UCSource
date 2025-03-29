//=============================================================================
// PasscardLock.
//=============================================================================
class PasscardLock expands Locks;

#call q:\Klingons\Art\Decor\Lock\Passcard\Final\Passcard.mac

defaultproperties
{
     TriggerKey=Class'Klingons.PasscardKey'
     AccessDeniedMsg="You need a Passcard to open this door "
     AccessDeniedSnd=Sound'KlingonSFX01.Beeps.Bp09'
     AccessApprovedMsg="Access Granted"
     AccessApprovedSnd=Sound'KlingonSFX01.Beeps.Bp23'
     Mesh=Mesh'Klingons.LockPassCard'
     DrawScale=0.700000
}
