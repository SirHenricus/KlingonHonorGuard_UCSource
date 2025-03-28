//=============================================================================
// CreatureFactory.
//=============================================================================
class CreatureFactory expands KlingonTriggers;

var() class<Actor>			CreatureClass;
var() name					CreatureEvent;
var() sound					SpawnStartSound;
var() sound					SpawnEndSound;

var(Pawn) bool				bIsWuss;
var(Pawn) bool				bIsBoss;
var(Pawn) bool				bBreath;
var(Pawn) bool				bForceBreath;
var(Pawn) float				MeleeRange;
var(Pawn) float				CombatStyle;
var(Pawn) float				Aggressiveness;
var(Pawn) name				AlarmTag;
var(Pawn) name				Orders;
var(Pawn) name				OrderTag;
var(Pawn) name				CoverTag;
var(Pawn) int				Health;
var(Pawn) class<Inventory>	DropWhenKilled;
var(Pawn) sound				BreathSound;

var bool					bWaitToDie;

var actor					NewCreature;

function SpawnCreature()
{
	local KlingonPawn	K;

	NewCreature=Spawn(CreatureClass);
	if (NewCreature == None) {
		return;
	}
	if (SpawnStartSound != None) {
		PlaySound(SpawnStartSound,SLOT_Misc);
	}
	NewCreature.Event=CreatureEvent;
	NewCreature.SetRotation(Rotation);
	if (KlingonPawn(NewCreature) != None) {
//		Level.Game.KillGoals++;
		K=KlingonPawn(NewCreature);
		K.bIsWuss=bIsWuss;
		K.bIsBoss=bIsBoss;
		K.bBreath=bBreath;
		K.bForceBreath=bForceBreath;
		if (MeleeRange != 0.0) {
			K.MeleeRange=MeleeRange;
		}
		if (CombatStyle != 0.0) {
			K.CombatStyle=CombatStyle;
		}
		if (Aggressiveness != 0.0) {
			K.Aggressiveness=Aggressiveness;
		}
		K.AlarmTag=AlarmTag;
		K.Orders=Orders;
		K.OrderTag=OrderTag;
		K.CoverTag=CoverTag;
		K.DropWhenKilled=DropWhenKilled;
		K.Breath=BreathSound;
		if (Health != 0.0) {
			K.Health=Health;
		}
	}
	else if (Inventory(NewCreature) != None) {
		Level.Game.ItemGoals++;
	}
	if (SpawnEndSound != None) {
		PlaySound(SpawnEndSound,SLOT_Misc);
	}
}

auto state TriggerWaiting
{
	function Trigger(actor Other,pawn EventInstigator)
	{
		if (CreatureClass != None) {
			SpawnCreature();
		}
	}
	function BeginState()
	{
		NewCreature=None;
	}
}

defaultproperties
{
     MeleeRange=40.000000
     CombatStyle=0.800000
     Aggressiveness=0.800000
     Health=100
     bDirectional=True
}
