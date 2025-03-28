//=============================================================================
// KlingonDamageTypes.
//=============================================================================
class KlingonDamageTypes expands DamageType;

var() name						DamageName[20];
var() class<KlingonDamageType>	DamageClass[20];

function string[64] GetDeathString(class<KlingonDamageType> cDamage)
{
	if (FRand() < 0.5) {
		return(cDamage.Default.Name);
	}
	else {
		return(cDamage.Default.AltName);
	}
}

function string[64] GetDeathMessage(pawn Killed,name DamageType)
{
	local class<KlingonDamageType>	cDamage;

	cDamage=GetDamageClass(DamageType);
	if (cDamage == None) {
		return("");
	}
	if (PlayerPawn(Killed) != None) {
		PlayerPawn(Killed).ClientFlash(ViewFlash,ViewFog);
	}
	return(GetDeathString(cDamage));
}

function DamageTypeFog(int DamageAmount,pawn Injured,name DamageType)
{
	local class<KlingonDamageType>	cDamage;

	if (PlayerPawn(Injured) != None) {
		cDamage=GetDamageClass(DamageType);
		if (cDamage != None) {
			PlayerPawn(Injured).ClientFlash(cDamage.Default.ViewFlash,cDamage.Default.ViewFog*DamageAmount);
		}
	}
}

function class<KlingonDamageType> GetDamageClass(name DamageType)
{
	local int	i;

	for (i=0 ; i < 20 ; i++) {
		if (DamageType == DamageName[i]) {
			return(DamageClass[i]);
		}
	}
	return(None);
}

defaultproperties
{
     DamageName(0)=Blasted
     DamageName(1)=burned
     DamageName(2)=Crushed
     DamageName(3)=Disintegrated
     DamageName(4)=drowned
     DamageName(5)=exploded
     DamageName(6)=fell
     DamageName(7)=hacked
     DamageName(8)=Imploded
     DamageName(9)=Peppered
     DamageName(10)=Perforated
     DamageName(11)=Pureed
     DamageName(12)=sliced
     DamageName(13)=Suffocated
     DamageName(14)=suicided
     DamageName(15)=Zapped
     DamageName(16)=stomped
     DamageName(17)=shot
     DamageClass(0)=Class'Klingons.Blasted'
     DamageClass(1)=Class'Klingons.burned'
     DamageClass(2)=Class'Klingons.Crushed'
     DamageClass(3)=Class'Klingons.Disintegrated'
     DamageClass(4)=Class'Klingons.drowned'
     DamageClass(5)=Class'Klingons.exploded'
     DamageClass(6)=Class'Klingons.fell'
     DamageClass(7)=Class'Klingons.hacked'
     DamageClass(8)=Class'Klingons.Imploded'
     DamageClass(9)=Class'Klingons.Peppered'
     DamageClass(10)=Class'Klingons.Perforated'
     DamageClass(11)=Class'Klingons.Pureed'
     DamageClass(12)=Class'Klingons.sliced'
     DamageClass(13)=Class'Klingons.Suffocated'
     DamageClass(14)=Class'Klingons.Suicide'
     DamageClass(15)=Class'Klingons.Zapped'
     DamageClass(16)=Class'Klingons.Crushed'
     DamageClass(17)=Class'Klingons.Zapped'
     Name=""
     AltName=""
     bHidden=True
     Tag=None
}
