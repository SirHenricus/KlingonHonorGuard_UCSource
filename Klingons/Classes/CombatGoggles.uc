//=============================================================================
// CombatGoggles.
//=============================================================================
class CombatGoggles expands KlingonPickups;

#call q:\Klingons\Art\Pickups\Equip\Goggles\Final\Goggles.mac

#exec MESH ORIGIN MESH=EquipCombatGoggles X=0 Y=400 Z=0

var() float				ZoomFOV[5];
var() float				ZoomRate;
var() float				TargetRange;
var() int				TargetCount;
var() class<Targeters>	TargeterType;

var float				DestFOV,
						CurFOV;

var int					FOVIndex;

var Pawn				TargetLocated[5];

var Targeters			Targeter[5];

var int					TargetsFound;

function EnableNightVision()
{
}

function DisableNightVision()
{
}

function EnableBlindness()
{
	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).bNoBlind=False;
	}
}

function DisableBlindness()
{
	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).bNoBlind=True;
	}
}

function FindTargets()
{
	local int			i;
	local Pawn			Other;

	for (i=0 ; i < TargetCount ; i++) {
		TargetLocated[i]=None;
		if (Targeter[i] != None) {
			Targeter[i].bHidden=True;
			Targeter[i].bInSight=False;
		}
	}
	TargetsFound=0;
	foreach Owner.VisibleActors(class 'Pawn',Other,TargetRange) {
		if (TargetsFound < TargetCount) {
			if (Targeter[TargetsFound] == None) {
				Targeter[TargetsFound]=Spawn(TargeterType,Self);
				Targeter[TargetsFound].bHidden=True;
				Targeter[TargetsFound].bInSight=True;
			}
			TargetLocated[TargetsFound]=Other;
			TargetsFound++;
		}
	}
}

function DisableTargetLocators()
{
	local int	i;

	for (i=0 ; i < TargetsFound ; i++) {
		Targeter[i].bHidden=True;
	}
}

function ShowTargetLocators()
{
	local int		i;
	local actor		HitAct;
	local vector	HitLoc,
					HitNor,
					EndLoc,
					StartLoc,
					Loc;

	FindTargets();
	for (i=0 ; i < TargetsFound ; i++) {
		StartLoc=Owner.Location; //+(vect(0,0,1)*Owner.CollisionHeight*0.5);
		EndLoc=TargetLocated[i].Location;
		HitAct=Owner.Trace(HitLoc,HitNor,EndLoc,StartLoc,True);
		if (HitAct != None) {
			Loc=HitAct.Location+(vect(0,0,0.5)*TargetLocated[i].CollisionHeight);
			if (Targeter[i] != None) {
				Targeter[i].bHidden=False;
				Targeter[i].bInSight=True;
				Targeter[i].SetLocation(Loc);
			}
		}
	}
}

function Destroyed()
{
	local int	i;

	for (i=0 ; i < TargetCount ; i++) {
		if (Targeter[i] != None) {
			Targeter[i].Destroy();
		}
	}
	Super.Destroyed();
}

function ItemActivated()
{
	TargetCount=Clamp(TargetCount,0,5);
	if (PlayerPawn(MyOwner) != None) {
		CurFOV=PlayerPawn(MyOwner).Default.FOVAngle;
		FOVIndex=0;
//		DestFOV=ZoomFOV[FOVIndex];
//		FOVIndex++;
//		PlayerPawn(MyOwner).SetDesiredFOV(DestFOV);
		DisableBlindness();
		EnableNightVision();
		if (KlingonPlayer(MyOwner) != None) {
			KlingonPlayer(MyOwner).GoggleOverlay(True);
		}
	}
}

function ItemDeActivated()
{
	if (PlayerPawn(MyOwner) != None) 
	{
		DestFOV=PlayerPawn(MyOwner).Default.FOVAngle;
		PlayerPawn(MyOwner).SetDesiredFOV(DestFOV);
	}

	if (KlingonPlayer(MyOwner) != None) {
		KlingonPlayer(MyOwner).GoggleOverlay(False);
	}
	EnableBlindness();
	DisableNightVision();
	DisableTargetLocators();
}
	
state Activated
{
	function Tick(float delta)
	{
		ShowTargetLocators();
	}
	function Activate()
	{
		if (FOVIndex < 5 && ZoomFOV[FOVIndex] != 0.0) {
			DestFOV=ZoomFOV[FOVIndex];
			FOVIndex++;
			if (PlayerPawn(MyOwner) != None) {
				PlayerPawn(MyOwner).SetDesiredFOV(DestFOV);
			}
		}
		else {
			if (PlayerPawn(MyOwner) != None) {
				PlayerPawn(MyOwner).SetDesiredFOV(PlayerPawn(MyOwner).Default.FOVAngle);
				PlayerPawn(Owner).ClientMessage(class$M_Deactivated);
			}
			FOVIndex=0;
			GotoState('DeActivated');
		}
	}
}

defaultproperties
{
     ZoomFOV(0)=70.000000
     ZoomFOV(1)=30.000000
     ZoomFOV(2)=10.000000
     ZoomRate=0.050000
     TargetRange=2000.000000
     TargetCount=5
     TargeterType=Class'Klingons.Targeters'
     ConsumptionRate=1.000000
     PickupMessage="You got the Combat Goggles"
     RespawnTime=60.000000
     PickupViewMesh=Mesh'Klingons.EquipCombatGoggles'
     PickupViewScale=0.250000
     Charge=300
     ActivateSound=Sound'KlingonSFX01.Inventory_Items.CameraActi'
     Icon=Texture'KlingonHUD.InvIcons.I_goggle'
     Mesh=Mesh'Klingons.EquipCombatGoggles'
     DrawScale=0.250000
     CollisionHeight=10.000000
}
