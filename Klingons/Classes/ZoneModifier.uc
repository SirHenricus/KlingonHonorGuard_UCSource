//=============================================================================
// ZoneModifier.
//=============================================================================
class ZoneModifier expands KlingonTrigger;

var(ZoneInfo) vector				ZoneGravity;
var(ZoneInfo) vector				ZoneVelocity;
var(ZoneInfo) float					ZoneGroundFriction;
var(ZoneInfo) float					ZoneFluidFriction;
var(ZoneInfo) name					ZonePlayerEvent;
var(ZoneInfo) int					DamagePerSec;
var(ZoneInfo) name					DamageType;
var(ZoneInfo) localized string[64]	DamageString;
var(ZoneInfo) sound					EntrySound;
var(ZoneInfo) sound					ExitSound;
var(ZoneInfo) class<Actor>			EntryActor;
var(ZoneInfo) class<Actor>			ExitActor;
var(ZoneInfo) bool					bGravityZone;
var(ZoneInfo) bool					bPainZone;
var(ZoneInfo) bool					bDestructive;

var(ZoneLight) vector				ViewFlash,
									ViewFog;

var bool							bToggle;

simulated function Trigger(actor Other,pawn InstigatedBy)
{
	if (bToggle) {
		UnTouch(Other);
		bToggle=False;
	}
	else {
		Touch(Other);
		bToggle=True;
	}
}

simulated function UnTrigger(actor Other,pawn InstigatedBy)
{
	Trigger(Other,InstigatedBy);
}

function Touch(actor Other)
{
	local Pawn		P;

	if (ZoneGravity != Default.ZoneGravity) {
		Region.Zone.ZoneGravity=ZoneGravity;
	}
	if (ZoneVelocity != Default.ZoneVelocity) {
		Region.Zone.ZoneVelocity=ZoneVelocity;
	}
	if (ZoneGroundFriction != Default.ZoneGroundFriction) {
		Region.Zone.ZoneGroundFriction=ZoneGroundFriction;
	}
	if (ZoneFluidFriction != Default.ZoneFluidFriction) {
		Region.Zone.ZoneFluidFriction=ZoneFluidFriction;
	}
	if (ZonePlayerEvent != Default.ZonePlayerEvent) {
		Region.Zone.ZonePlayerEvent=ZonePlayerEvent;
	}
	if (DamagePerSec != Default.DamagePerSec) {
		Region.Zone.DamagePerSec=DamagePerSec;
	}
	if (DamageType != Default.DamageType) {
		Region.Zone.DamageType=DamageType;
	}
	if (DamageString != Default.DamageString) {
		Region.Zone.DamageString=DamageString;
	}
	if (EntrySound != Default.EntrySound) {
		Region.Zone.EntrySound=EntrySound;
	}
	if (ExitSound != Default.ExitSound) {
		Region.Zone.ExitSound=ExitSound;
	}
	if (EntryActor != Default.EntryActor) {
		Region.Zone.EntryActor=EntryActor;
	}
	if (ExitActor != Default.ExitActor) {
		Region.Zone.ExitActor=ExitActor;
	}
	if (bGravityZone != Region.Zone.bGravityZone) {
		Region.Zone.bGravityZone=bGravityZone;
	}
	if (bPainZone != Region.Zone.bPainZone) {
		Region.Zone.bPainZone=bPainZone;
	}
	if (bDestructive != Region.Zone.bDestructive) {
		Region.Zone.bDestructive=bDestructive;
	}
	if (ViewFlash != Default.ViewFlash) {
		Region.Zone.ViewFlash=ViewFlash;
	}
	if (ViewFog != Default.ViewFog) {
		Region.Zone.ViewFog=ViewFog;
	}
	Super.Touch(Other);
	foreach AllActors(class 'Pawn',P) {
		if (P.Region.Zone == Region.Zone) {
			P.ZoneChange(Region.Zone);
		}
	}
}

function UnTouch(actor Other)
{
	local Pawn		P;

	Region.Zone.ZoneGravity=Region.Zone.Default.ZoneGravity;
	Region.Zone.ZoneVelocity=Region.Zone.Default.ZoneVelocity;
	Region.Zone.ZoneGroundFriction=Region.Zone.Default.ZoneGroundFriction;
	Region.Zone.ZoneFluidFriction=Region.Zone.Default.ZoneFluidFriction;
	Region.Zone.ZonePlayerEvent=Region.Zone.Default.ZonePlayerEvent;
	Region.Zone.DamagePerSec=Region.Zone.Default.DamagePerSec;
	Region.Zone.DamageType=Region.Zone.Default.DamageType;
	Region.Zone.DamageString=Region.Zone.Default.DamageString;
	Region.Zone.EntrySound=Region.Zone.Default.EntrySound;
	Region.Zone.ExitSound=Region.Zone.Default.ExitSound;
	Region.Zone.EntryActor=Region.Zone.Default.EntryActor;
	Region.Zone.ExitActor=Region.Zone.Default.ExitActor;
	Region.Zone.bGravityZone=Region.Zone.Default.bGravityZone;
	Region.Zone.bPainZone=Region.Zone.Default.bPainZone;
	Region.Zone.bDestructive=Region.Zone.Default.bDestructive;
	Region.Zone.ViewFlash=Region.Zone.Default.ViewFlash;
	Region.Zone.ViewFog=Region.Zone.Default.ViewFog;
	Super.UnTouch(Other);
	foreach AllActors(class 'Pawn',P) {
		P.ZoneChange(Region.Zone);
	}
}

defaultproperties
{
     bCollideActors=False
}
