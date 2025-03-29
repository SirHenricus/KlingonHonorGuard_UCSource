//=============================================================================
// LeverSwitch.
//=============================================================================
class LeverSwitch expands Switches;

//#call q:\Klingons\Art\Decor\Switches\Lever\Lever.mac

#exec MESH IMPORT MESH=DecorLever ANIVFILE=q:\klingons\art\decor\switches\lever\lever-aniv.3D DATAFILE=q:\klingons\art\decor\switches\lever\lever-data.3D X=0 Y=0 Z=0
#exec MESH ORIGIN MESH=DecorLever X=450 Y=450 Z=50 YAW=-64 ROLL=-64

#exec MESH SEQUENCE MESH=DecorLever SEQ=All			STARTFRAME=0  NUMFRAMES=30
#exec MESH SEQUENCE MESH=DecorLever SEQ=SwitchOff	STARTFRAME=0  NUMFRAMES=1
#exec MESH SEQUENCE MESH=DecorLever SEQ=SwitchOn	STARTFRAME=29 NUMFRAMES=1
#exec MESH SEQUENCE MESH=DecorLever SEQ=Switching 	STARTFRAME=0  NUMFRAMES=30

#exec TEXTURE IMPORT NAME=LeverOffTex1 FILE=q:\klingons\art\decor\switches\lever\lever-1.PCX FAMILY=Switches
#exec TEXTURE IMPORT NAME=LeverOnTex1 FILE=q:\klingons\art\decor\switches\lever\lever-2.PCX FAMILY=Switches

#exec MESHMAP NEW   MESHMAP=DecorLever MESH=DecorLever ; Assign name and mesh to new sprite
#exec MESHMAP SCALE MESHMAP=DecorLever X=0.08 Y=0.08 Z=0.15

#exec MESHMAP SETTEXTURE MESHMAP=DecorLever NUM=0 TEXTURE=LeverOffTex1 ; Apply textures

#exec MESH NOTIFY MESH=DecorLever SEQ=Switching TIME=0.5 FUNCTION=SwitchOnFunction

simulated function SwitchOnFunction()
{
	Super.SwitchOnFunction();
	Super.Touch(Activator);
}

function Touch(actor Other)
{
	if (IsRelevant(Other)) {
		Activator=Other;
		PlayAnim('Switching',1.0);
	}
}

function Trigger(actor Other,pawn EventInstigator)
{
	Touch(EventInstigator);
}

defaultproperties
{
     SwitchOnTex=Texture'Klingons.LeverOnTex1'
     SwitchOnSound=Sound'KlingonSFX01.Beeps.LightSwitch'
     SwitchOffSound=Sound'KlingonSFX01.Beeps.LightSwitch'
     bTriggerOnceOnly=True
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.DecorLever'
}
