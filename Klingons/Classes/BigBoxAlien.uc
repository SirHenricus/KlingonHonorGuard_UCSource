//=============================================================================
// BigBoxAlien.
//=============================================================================
class BigBoxAlien expands Destructable;

#call q:\Klingons\Art\Decor\Boxes\BigBox\Final\BigBoxAlien.mac

#exec MESH ORIGIN MESH=BoxBigAlien X=0 Y=0 Z=0

defaultproperties
{
     ExplosionDamage=30.000000
     ExplosionRadius=0.000000
     ObjectDamagedSkin=Texture'Klingons.BoxAlienTex2'
     ShardClass(0)=Class'Klingons.BoxShard01'
     ShardClass(1)=Class'Klingons.BoxShard02'
     ShardClass(2)=Class'Klingons.BoxShard03'
     ShardClass(3)=Class'Klingons.BoxShard04'
     ShardCount=4.000000
     Physics=PHYS_Falling
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.BoxBigAlien'
     CollisionRadius=21.000000
     CollisionHeight=19.000000
     bBounce=True
     Buoyancy=52.000000
}
