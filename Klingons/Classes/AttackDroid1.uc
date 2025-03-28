//=============================================================================
// AttackDroid1.
//=============================================================================
class AttackDroid1 expands AttackDroid;

#alwayscall q:\klingons\art\pawns\attackd1\final\attackd.mac
#alwaysexec MESH ORIGIN MESH=PawnAttackDroid1 X=0 Y=0 Z=170 YAW=64
#exec MESH NOTIFY MESH=PawnAttackDroid1 SEQ=FireBig  TIME=0.1 FUNCTION=SpawnTwoShots

defaultproperties
{
     TimeBetweenAttacks=1.000000
     RefireRate=0.500000
     RangedProjectile=Class'Klingons.DisruptorRed'
     ProjectileSpeed=1800.000000
     DodgeAmount=0.500000
     Health=60
     Mesh=Mesh'Klingons.PawnAttackDroid1'
}
