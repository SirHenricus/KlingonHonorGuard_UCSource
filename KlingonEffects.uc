//=============================================================================
// KlingonEffects.
//=============================================================================
class KlingonEffects expands Effects;

#exec OBJ LOAD FILE=..\Textures\WeaponFX01.utx PACKAGE=WeaponFX01
#exec OBJ LOAD FILE=..\Textures\KlingonFX01.utx PACKAGE=KlingonFX01
#exec OBJ LOAD FILE=..\Sounds\KlingonSFX01 PACKAGE=KlingonSFX01

var() bool				bOnlyWhenSeen;
var() float				DefaultSoundRadius;
var() float				ScaleRate;
var() float				ScaleGlowRate;
var() float				EffectTimer;
var() sound				EffectSound;
var() class<Effects>	ChildEffect;
var() class<Effects>	TickEffect;
var() class<Effects>	DestroyedEffect;
var() class<Effects>	WaterEffect;
var() texture			Frames[20];

var int					CurrentFrame;
var actor				ChildActor,
						DestroyedActor,
						TickActor;

var KlingonEffects		K;

function DetermineOwner()
{
	if (K == None) {
		if (KlingonEffects(Owner) == None) {
			K=Self;
		}
		else {
			K=KlingonEffects(Owner);
		}
	}
}

function ZoneChange(ZoneInfo NewZone)
{
}

function actor SpawnEffect(class<Effects> C,optional actor O)
{
	if (Level.NetMode != NM_StandAlone && !C.Default.bNet) {
		return(None);
	}
	return(Spawn(C,O));
}

function EffectAnim(float delta)
{
	if (K.Frames[0] != None) {
		if (K.Frames[CurrentFrame] == None || CurrentFrame == 19) {
			if (LifeSpan != 0.0) {
				CurrentFrame=0;
			}
			else {
				Destroy();
				return;
			}
		}
		Texture=K.Frames[CurrentFrame];
		CurrentFrame++;
	}
	if (K.ScaleRate != 0.0) {
		DrawScale+=K.ScaleRate;
		if (DrawScale <= 0.0) {
			Destroy();
			return;
		}
	}
	if (K.ScaleGlowRate != 0.0) {
		ScaleGlow+=K.ScaleGlowRate;
		if (ScaleGlow <= 0.0) {
			Destroy();
			return;
		}
	}
	if (Region.Zone.bWaterZone && K.WaterEffect != None) {
		TickActor=SpawnEffect(K.WaterEffect);
//		TickActor=Spawn(K.WaterEffect); //,K);
	}
	else if (K.TickEffect != None) {
		TickActor=SpawnEffect(K.TickEffect);
//		TickActor=Spawn(K.TickEffect); //,K);
	}
}

state() SpecialEffect
{
	function ZoneChange(ZoneInfo NewZone)
	{
		Global.ZoneChange(NewZone);
	}
	function Tick(float delta)
	{
		DetermineOwner();
		EffectAnim(delta);
	}
	function Timer()
	{
		DetermineOwner();
		EffectAnim(K.EffectTimer);
	}
	function Destroyed()
	{
		DetermineOwner();
		if (K.DestroyedEffect != None) {
			if (Region.Zone.bWaterZone && K.WaterEffect != None) {
				DestroyedActor=SpawnEffect(K.WaterEffect); //,K);
			}
			else {
				DestroyedActor=SpawnEffect(K.DestroyedEffect); //,K);
			}
		}
		if (K.EffectSound2 != None) {
			PlaySound(K.EffectSound2,,,,K.DefaultSoundRadius);
		}
	}
	function BeginState()
	{
		DetermineOwner();
		if (K.EffectSound != None) {
			PlaySound(K.EffectSound,,,,K.DefaultSoundRadius);
		}
		if (K.EffectSound1 != None) {
			PlaySound(K.EffectSound1,,,,K.DefaultSoundRadius);
		}
		if (Region.Zone.bWaterZone && K.WaterEffect != None) {
			ChildActor=SpawnEffect(K.WaterEffect); //,K);
		}
		else if (K.ChildEffect != None) {
			ChildActor=SpawnEffect(K.ChildEffect); //,K);
		}
		if (K.Frames[0] != None) {
			Texture=K.Frames[0];
		}
		if (K.EffectTimer != 0.0) {
			Disable('Tick');
			SetTimer(K.EffectTimer,True);
		}
		DrawScale=K.DrawScale;
	}
}

state() TriggeredEffect
{
	function TakeDamage(int Damage,Pawn InstigatedBy,Vector HitLoc,Vector Momentum,name DamageType)
	{
	}
	function Trigger(actor Other,pawn EventInstigator)
	{
		if (Region.Zone.bWaterZone && WaterEffect != None) {
			SpawnEffect(WaterEffect,K);
		}
		else {
			SpawnEffect(Class,K);
		}
	}
	function BeginState()
	{
		DetermineOwner();
		bHidden=True;
		LightType=LT_None;
		SetPhysics(PHYS_None);
		Mass=0.0;
		Buoyancy=Mass;
		if (bOnlyWhenSeen) {
			bStasis=True;
		}
	}
}

defaultproperties
{
     bOnlyWhenSeen=True
     DefaultSoundRadius=1600.000000
     RemoteRole=ROLE_None
     InitialState=SpecialEffect
     DrawType=DT_Sprite
     Style=STY_Translucent
     bMeshCurvy=False
}
