//=============================================================================
// CameraMonitor.
//=============================================================================
class CameraMonitor expands Destructable;

#call q:\Klingons\Art\Pickups\Equip\Camera1\InHand\Final\Camera1.mac
#call q:\Klingons\Art\Pickups\Equip\Camera1\Pickup\Final\Camera1pu.mac

#exec MESH ORIGIN MESH=EquipCamera1 X=-70 Y=0 Z=0 YAW=64
#exec MESH ORIGIN MESH=EquipCamera1Pickup X=-60 Y=-50 Z=25

var() bool		bCameraPan;
var() float		CameraPanDegrees;
var() float		CameraPanSpeed;
var() float		CameraPanDelay;
var() float		CameraFOV;

var bool		bDirectionToggle;

var rotator		StartRotation;

function Trigger(actor Other,pawn Instigator)
{
	if (KlingonPlayer(Instigator) != None) {
		KlingonPlayer(Instigator).ViewFrom(Self);
		KlingonPlayer(Instigator).SetDesiredFOV(CameraFOV);
		KlingonPlayer(Instigator).StowWeapon();
		KlingonPlayer(Instigator).HideHUD();
		KlingonPlayer(Instigator).CameraOverlay(True);
	}
}

function UnTrigger(actor Other,pawn Instigator)
{
	if (KlingonPlayer(Instigator) != None) {
		KlingonPlayer(Instigator).ViewFrom(None);
		KlingonPlayer(Instigator).SetDesiredFOV(Instigator.Default.FOVAngle);
		KlingonPlayer(Instigator).ShowWeapon();
		KlingonPlayer(Instigator).ShowHUD();
		KlingonPlayer(Instigator).CameraOverlay(False);
	}
}

auto state CameraOn
{
	simulated function PickNewRotation()
	{
		local float		D;
		local rotator	R,R2;

		D=(65536.0/(360.0/CameraPanDegrees))*0.5;
		R2=rotator(vect(0,1,0))*D;
		if (bDirectionToggle) {
			R=StartRotation+R2;
			bDirectionToggle=False;
		}
		else {
			R=StartRotation-R2;
			bDirectionToggle=True;
		}
		R.Yaw=R.Yaw&65535;
		DesiredRotation=R;
		SetTimer(CameraPanDelay,False);
	}
	simulated function EndedRotation()
	{
		bRotateToDesired=False;
		PickNewRotation();
	}
	simulated function Timer()
	{
		bRotateToDesired=True;
	}
Begin:
	if (bCameraPan) {
		StartRotation=Rotation;
		RotationRate=rotator(vect(1,1,1))*CameraPanSpeed;
		PickNewRotation();
	}
	PlayAnim('Open',1.0,1.0);
	FinishAnim();
}

defaultproperties
{
     CameraPanDegrees=90.000000
     CameraPanSpeed=0.500000
     CameraPanDelay=4.000000
     CameraFOV=120.000000
     ExplosionDamage=0.000000
     ObjectHealth=0.000000
     Physics=PHYS_Rotating
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.EquipCamera1'
     DrawScale=0.250000
     Mass=0.000000
     Buoyancy=0.000000
}
