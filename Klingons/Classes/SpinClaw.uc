//=============================================================================
// SpinClaw.
//=============================================================================
class SpinClaw expands KlingonWeapons;

#call q:\Klingons\Art\Weapons\SpinClaw\InHand\Final\SpinClaw.mac
#call q:\Klingons\Art\Weapons\SpinClaw\Pickup\Final\SpinClawpu.mac
#call q:\Klingons\Art\Weapons\SpinClaw\3rd\Final\SpinClaw3rd.mac

#exec MESH ORIGIN MESH=WeapSpinClaw3rd X=-30 Y=0 Z=0

#exec MESH SEQUENCE MESH=WeapSpinClaw SEQ=Select STARTFRAME=1 NUMFRAMES=20
#exec MESH SEQUENCE MESH=WeapSpinClaw SEQ=Down STARTFRAME=22 NUMFRAMES=20

#exec MESH NOTIFY MESH=WeapSpinClaw SEQ=Shoot TIME=0.2 FUNCTION=FireProjectile

var() texture			AnimatedTextures[4];

var int					AnimatedFrame;

var float				AnimatedTick;

var SpinClawProjectile	SpinClawProj;

var bool				bHasBlade;

function TweenDown()
{
	if (GetAnimGroup(AnimSequence) == 'Select') {
		TweenAnim(AnimSequence,AnimFrame*0.4);
	}
	else {
		if (bHasBlade) {
			PlayAnim('Down',1.0,0.05);
		}
		else {
			PlayAnim('HandleStow',1.0,0.05);
		}
	}
}

function TweenSelect()
{
	if (bHasBlade) {
		TweenAnim('Select',0.001);
	}
	else {
		TweenAnim('HandlePickup',0.001);
	}
}

function PlaySelect()
{
	if (bHasBlade) {
		PlayAnim('Select',1.0,0.0);
	}
	else {
		PlayAnim('HandlePickup',1.0,0.0);
	}
	Owner.PlaySound(SelectSound, SLOT_Misc, Pawn(Owner).SoundDampening);	
}

state NormalFire
{
	function Fire(float F)
	{
		if (SpinClawProj != None) {
			SpinClawProj.GotoState('GoHome');
		}
	}
	function AltFire(float F)
	{
		if (bHasBlade == False && SpinClawProj != None) {
			SpinClawProj.Damage=SpinClawProj.Default.Damage*10.0;
			SpinClawProj.HurtType='exploded';
			SpinClawProj.Explode(SpinClawProj.Location,vect(0,0,0));
			Pawn(Owner).SwitchToBestWeapon();
		}
	}
	function Tick(float delta)
	{
		if (bChangeWeapon) {
			GotoState('DownWeapon');
		}
	}
Begin:
	FinishAnim();
	if (WeapProj != None) {
		SpinClawProj=SpinClawProjectile(WeapProj);
		bHasBlade=False;
	}
}

state AltFiring
{
	function Fire(float F) {}
	function AltFire(float F) {}

Begin:
	FinishAnim();
}

state Catch
{
	function Fire(float F) {}
	function AltFire(float F) {}

Begin:
	if (Misc1Sound != None) {
		PlaySound(Misc1Sound,SLOT_Misc,Pawn(Owner).SoundDampening);
	}
	PlayAnim('Catch',1.0);
	FinishAnim();
	AmmoType.AddAmmo(1);
	bHasBlade=True;
	Finish();
}

state Idle
{
	simulated function Tick(float delta)
	{
		Super.Tick(delta);
		AnimatedTick+=delta;
		if (AnimatedTick >= 0.1) {
			if (AnimatedFrame == 4 || AnimatedTextures[AnimatedFrame] == None) {
				AnimatedFrame=0;
			}
			Skin=AnimatedTextures[AnimatedFrame];
			AnimatedFrame++;
			AnimatedTick-=0.1;
		}
	}
	function BeginState()
	{
		Super.BeginState();
		LightBrightness=128;
		LightHue=45;
		LightRadius=8;
		LightType=LT_Steady;
		AmbientGlow=64;
	}
	function EndState()
	{
		Super.EndState();
		AmbientGlow=0;
		LightType=LT_None;
	}
}

defaultproperties
{
     AnimatedTextures(0)=Texture'WeaponFX01.Weapons.SpinAnivTex1'
     AnimatedTextures(1)=Texture'WeaponFX01.Weapons.SpinAnivTex2'
     AnimatedTextures(2)=Texture'WeaponFX01.Weapons.SpinAnivTex3'
     AnimatedTextures(3)=Texture'WeaponFX01.Weapons.SpinAnivTex4'
     AmmoConsumption=1
     NumProjectiles=1
     DamageAmount=80.000000
     FireRate=1.000000
     ShotRecoil=100.000000
     HurtType=Pureed
     AltHurtType=Pureed
     ProjClass=Class'Klingons.SpinClawProjectile'
     WeaponType=9
     FireNoise=0.500000
     AltFireNoise=1.000000
     AmmoName=Class'Klingons.SpinClaws'
     PickupAmmoCount=1
     FireOffset=(X=33.000000,Y=-7.000000,Z=10.000000)
     AIRating=0.800000
     SelectSound=Sound'KlingonSFX01.Weapons.SpinSelect'
     Misc1Sound=Sound'KlingonSFX01.Weapons.SpinEnd3'
     MessageNoAmmo="No ammunition for Ding pach"
     AutoSwitchPriority=15
     InventoryGroup=5
     PickupMessage="You picked up a Ding' pah"
     PlayerViewMesh=Mesh'Klingons.WeapSpinClaw'
     PickupViewMesh=Mesh'Klingons.SpinClawPU'
     PickupViewScale=0.250000
     ThirdPersonMesh=Mesh'Klingons.WeapSpinClaw3RD'
     Mesh=Mesh'Klingons.SpinClawPU'
     DrawScale=0.250000
     CollisionRadius=20.000000
     CollisionHeight=10.000000
     bProjTarget=True
     Mass=30.000000
}
