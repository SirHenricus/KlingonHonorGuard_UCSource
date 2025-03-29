//=============================================================================
// StealthSuit.
//=============================================================================
class StealthSuit expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\Stealth\Final\Stealth.mac

#exec MESH ORIGIN MESH=EquipStealthSuit X=0 Y=0 Z=0

var() sound		StealthAmbientSound;

simulated function SetOwnerTranslucency()
{
	local float		GlowVal;
	local int		v;

	GlowVal=MyOwner.Default.ScaleGlow-(float(Charge)/float(Default.Charge));
	if (Level.NetMode != NM_StandAlone) {
		MyOwner.bHidden=True;
		if (MyOwner.LightType == MyOwner.Default.LightType) {
			MyOwner.LightSaturation=255;
			MyOwner.LightEffect=LE_WateryShimmer;
			MyOwner.LightType=LT_Steady;
		}
		else if (MyOwner.LightEffect == LE_WateryShimmer) {
			v=Clamp(int(128.0*GlowVal),16,255);
			MyOwner.LightBrightness=v;
			v=Clamp(int(8.0*GlowVal),3,8);
			MyOwner.LightRadius=v;
		}
	}
	else {
		GlowVal*=4.0;
		MyOwner.Style=STY_Translucent;
		MyOwner.ScaleGlow=FClamp(GlowVal,0.1,4.0);
	}
	if (Pawn(MyOwner) != None) {
		if (Pawn(MyOwner).Weapon != None) {
			Pawn(MyOwner).Weapon.Style=STY_Translucent;
			Pawn(MyOwner).Weapon.ScaleGlow=FClamp(GlowVal,0.5,4.0);
		}
		Pawn(MyOwner).Visibility=((128*MyOwner.ScaleGlow)/4.0);
	}
}

simulated function ResetOwnerTranslucency()
{
	if (Level.NetMode != NM_StandAlone) {
		MyOwner.bHidden=False;
		if (MyOwner.LightEffect == LE_WateryShimmer) {
			MyOwner.LightSaturation=MyOwner.Default.LightSaturation;
			MyOwner.LightEffect=MyOwner.Default.LightEffect;
			MyOwner.LightBrightness=MyOwner.Default.LightBrightness;
			MyOwner.LightRadius=MyOwner.Default.LightRadius;
			MyOwner.LightType=MyOwner.Default.LightType;
		}
	}
	else {
		MyOwner.Style=MyOwner.Default.Style;
		MyOwner.ScaleGlow=MyOwner.Default.ScaleGlow;
	}
	if (Pawn(MyOwner) != None) {
		if (Pawn(MyOwner).Weapon != None) {
			Pawn(MyOwner).Weapon.Style=Pawn(MyOwner).Weapon.Default.Style;
			Pawn(MyOwner).Weapon.ScaleGlow=Pawn(MyOwner).Weapon.Default.ScaleGlow;
		}
		Pawn(MyOwner).Visibility=Pawn(MyOwner).Default.Visibility;
	}
}

simulated function ItemActivated()
{
	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).bStealth=True;
	}
	SetOwnerTranslucency();
	AmbientSound=StealthAmbientSound;
}

simulated function ItemDeActivated()
{
	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).bStealth=False;
	}
	ResetOwnerTranslucency();
	AmbientSound=None;
}

state Activated
{
	simulated function Timer()
	{
		Super.Timer();
		SetOwnerTranslucency();
	}
}

defaultproperties
{
     StealthAmbientSound=Sound'KlingonSFX01.Inventory_Items.StealthLp'
     Warning1Sound=Sound'KlingonSFX01.Beeps.Bp08'
     Warning1Time=15
     Warning2Sound=Sound'KlingonSFX01.Beeps.Bp09'
     Warning2Time=5
     ConsumptionRate=1.000000
     PickupMessage="You got the Stealth Suit"
     RespawnTime=300.000000
     PickupViewMesh=Mesh'Klingons.EquipStealthSuit'
     PickupViewScale=0.300000
     Charge=60
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.StealthActi'
     DeActivateSound=Sound'KlingonSFX01.Inventory_Items.StealthDeActi'
     Icon=Texture'KlingonHUD.InvIcons.I_stlth'
     Mesh=Mesh'Klingons.EquipStealthSuit'
     DrawScale=0.300000
     CollisionHeight=16.000000
}
