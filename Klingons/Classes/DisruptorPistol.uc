//=============================================================================
// DisruptorPistol.
//=============================================================================
class DisruptorPistol expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\DPistol\InHand\Final\DPistol.mac
#call q:\Klingons\Art\Weapons\DPistol\Pickup\Final\DPistolpu.mac

#exec MESH ORIGIN MESH=WeapDPistolPickup X=0 Y=0 Z=75

#call q:\Klingons\Art\Weapons\DPistol\3rd\Final\DPistol3rd.mac

#exec MESH ORIGIN MESH=WeapDPistol3rd X=-10 Y=0 Z=-10

#exec MESH SEQUENCE MESH=WeapDPistol SEQ=Select STARTFRAME=1 NUMFRAMES=21
#exec MESH SEQUENCE MESH=WeapDPistol SEQ=Down STARTFRAME=22 NUMFRAMES=10

#exec MESH NOTIFY MESH=WeapDPistol SEQ=Shoot TIME=0.15 FUNCTION=FireProjectile

function Finish()
{
	if (bChangeWeapon) {
		if (ChargeCell(AmmoType) != None) {
			ChargeCell(AmmoType).GotoState('Charging');
		}
		GotoState('DownWeapon');
		return;
	}
	if (PlayerPawn(Owner) == None) {
		if (Pawn(Owner).bFire != 0 && FRand() < RefireRate && AmmoType.AmmoAmount >= AmmoConsumption) {
			Global.Fire(0);
		}
		else if (Pawn(Owner).bAltFire != 0 && FRand() < AltRefireRate && AmmoType.AmmoAmount >= AltAmmoConsumption) {
			Global.AltFire(0);	
		}
		else {
			Pawn(Owner).StopFiring();
			GotoState('Idle');
		}
		return;
	}
	if (Pawn(Owner).Weapon != Self) {
		GotoState('Idle');
	}
	else if (Pawn(Owner).bFire != 0 && AmmoType.AmmoAmount >= AmmoConsumption) {
		Global.Fire(0);
	}
	else if (Pawn(Owner).bAltFire != 0 && AmmoType.AmmoAmount >= AltAmmoConsumption) {
		Global.AltFire(0);
	}
	else {
		GotoState('Idle');
	}
}

state Idle
{
/*
	function Timer()
	{
		if (AmmoType.AmmoAmount < AmmoType.Default.AmmoAmount) {
			AmmoType.AmmoAmount++;
		}
	}
	function BeginState()
	{
		Super.BeginState();
		SetTimer(1.0,True);
	}
*/
	function BeginState()
	{
		if (ChargeCell(AmmoType) != None) {
			ChargeCell(AmmoType).GotoState('Charging');
		}
	}
}

state NormalFire
{
	function BeginState()
	{
		if (ChargeCell(AmmoType) != None) {
			ChargeCell(AmmoType).GotoState('NotCharging');
		}
	}
}

state AltFiring
{
	function BeginState()
	{
		if (ChargeCell(AmmoType) != None) {
			ChargeCell(AmmoType).GotoState('NotCharging');
		}
	}
}

defaultproperties
{
     AmmoConsumption=2
     AltAmmoConsumption=10
     NumProjectiles=1
     AltNumProjectiles=2
     DamageAmount=6.000000
     AltDamageAmount=10.000000
     FireRate=1.000000
     AltFireRate=0.700000
     AltDispersion=500.000000
     AimAdjust=(Yaw=100)
     AltAimAdjust=(Yaw=100)
     HurtType=Zapped
     AltHurtType=Disintegrated
     ProjClass=Class'Klingons.DisruptorGreen'
     AltProjClass=Class'Klingons.DisruptorRed'
     MuzzleFlash=Class'Klingons.DisruptorTrail1'
     AltMuzzleFlash=Class'Klingons.DisruptorFlash2'
     WeaponType=3
     FireNoise=0.600000
     AltFireNoise=0.700000
     AmmoName=Class'Klingons.ChargeCell'
     PickupAmmoCount=100
     bWarnTarget=True
     bAltWarnTarget=True
     FireOffset=(X=33.000000,Y=-3.000000,Z=15.000000)
     shakemag=0.000000
     shaketime=0.000000
     shakevert=0.000000
     AIRating=0.200000
     FireSound=Sound'KlingonSFX01.Weapons.Wepon4'
     AltFireSound=Sound'KlingonSFX01.Weapons.Wepon4'
     SelectSound=Sound'KlingonSFX01.Pickups.GenPickup'
     MessageNoAmmo="No ammunition for Disruptor Pistol"
     AutoSwitchPriority=20
     InventoryGroup=2
     PickupMessage="You picked up a Disruptor Pistol."
     PlayerViewMesh=Mesh'Klingons.WeapDPistol'
     PickupViewMesh=Mesh'Klingons.WeapDPistolPickup'
     PickupViewScale=1.800000
     ThirdPersonMesh=Mesh'Klingons.WeapDPistol3RD'
     Mesh=Mesh'Klingons.WeapDPistolPickup'
     DrawScale=1.800000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=35.000000
}
