//=============================================================================
// CipherLock.
//=============================================================================
class CipherLock expands Locks;

#call q:\Klingons\Art\Decor\Lock\Cipher\Final\Cipher.mac

defaultproperties
{
     TriggerKey=Class'Klingons.CipherKey'
     AccessDeniedMsg="You need a Cipher Decoding Module to open this door"
     AccessDeniedSnd=Sound'KlingonSFX01.Beeps.Bp09'
     AccessApprovedMsg="Access Granted"
     AccessApprovedSnd=Sound'KlingonSFX01.Beeps.Bp23'
     Mesh=Mesh'Klingons.LockCipher'
     DrawScale=0.500000
}
