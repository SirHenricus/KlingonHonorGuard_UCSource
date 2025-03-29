//=============================================================================
// KlingonSwitch.
//=============================================================================
class KlingonSwitch expands Switches;

#exec MESH IMPORT		MESH=DecorKlingonSwitch ANIVFILE=q:\klingons\art\decor\switches\nonlever\nonlever-aniv.3D DATAFILE=q:\klingons\art\decor\switches\nonlever\nonlever-data.3D X=0 Y=0 Z=0 UNMIRROR=1
#exec MESH ORIGIN		MESH=DecorKlingonSwitch X=0 Y=-100 Z=25 ROLL=-64 YAW=-64

#exec MESH SEQUENCE	MESH=DecorKlingonSwitch SEQ=All STARTFRAME=0 NUMFRAMES=1
#exec MESH SEQUENCE	MESH=DecorKlingonSwitch SEQ=Static STARTFRAME=1 NUMFRAMES=1

#exec TEXTURE IMPORT	NAME=KlingonSwitchTex1 FILE=q:\klingons\art\decor\switches\nonlever\n-l-k-1-1.PCX
#exec TEXTURE IMPORT	NAME=KlingonSwitchTex2 FILE=q:\klingons\art\decor\switches\nonlever\n-l-k-1-2.PCX

#exec MESHMAP NEW		MESHMAP=DecorKlingonSwitch MESH=DecorKlingonSwitch
#exec MESHMAP SCALE	MESHMAP=DecorKlingonSwitch X=0.08 Y=0.08 Z=0.15

#exec MESHMAP SETTEXTURE MESHMAP=DecorKlingonSwitch NUM=0 TEXTURE=KlingonSwitchTex1

var() bool		bUnTrigger;

var bool		bToggle;

replication
{
	reliable if (Role == ROLE_Authority)
		bToggle;
}

function Touch(actor Other)
{
	if (IsRelevant(Other) && !bToggle) {
		Activator=Other.Instigator;
		Super.SwitchOnFunction();
		Super.Touch(Activator);
		SetTimer(5,False);
		bToggle=True;
	}
}

simulated function Timer()
{
	if (bToggle) {
		Super.SwitchOnFunction();
		if (bUnTrigger) {
			Super.UnTouch(Activator);
		}
		bToggle=False;
	}
}

simulated function Trigger(actor Other,pawn EventInstigator)
{
	Touch(EventInstigator);
}

defaultproperties
{
     SwitchOnTex=Texture'Klingons.KlingonSwitchTex2'
     SwitchOnSound=Sound'KlingonSFX01.Beeps.Bp15'
     SwitchOffSound=Sound'KlingonSFX01.Beeps.Bp15'
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.DecorKlingonSwitch'
}
