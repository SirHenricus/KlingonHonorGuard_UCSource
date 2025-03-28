//=============================================================================
// AttackDroid2.
//=============================================================================
class AttackDroid2 expands AttackDroid;

#alwayscall q:\klingons\art\pawns\attackd2\final\attackd2.mac
#alwaysexec MESH ORIGIN MESH=PawnAttackDroid2 X=0 Y=0 Z=170 YAW=64

#exec MESH NOTIFY MESH=PawnAttackDroid2 SEQ=FireBig  TIME=0.1 FUNCTION=SpawnTwoShots

defaultproperties
{
     TimeBetweenAttacks=4.000000
     RefireRate=0.000000
     RangedProjectile=Class'Klingons.AssaultProjectile'
     ProjectileSpeed=1250.000000
     DodgeAmount=0.500000
     Health=70
     Mesh=Mesh'Klingons.PawnAttackDroid2'
}
