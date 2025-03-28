//=============================================================================
// AndorianSwitch.
//=============================================================================
class AndorianSwitch expands KlingonSwitch;

#exec MESH IMPORT		MESH=DecorAndorianSwitch ANIVFILE=q:\klingons\art\decor\switches\nonlever\nonlever-aniv.3D DATAFILE=q:\klingons\art\decor\switches\nonlever\nonlever-data.3D X=0 Y=0 Z=0 UNMIRROR=1
#exec MESH ORIGIN		MESH=DecorAndorianSwitch X=0 Y=-100 Z=25 ROLL=-64 YAW=-64

#exec MESH SEQUENCE	MESH=DecorAndorianSwitch SEQ=All STARTFRAME=0 NUMFRAMES=1
#exec MESH SEQUENCE	MESH=DecorAndorianSwitch SEQ=Static STARTFRAME=1 NUMFRAMES=1

#exec TEXTURE IMPORT	NAME=AndorianSwitchTex1 FILE=q:\klingons\art\decor\switches\nonlever\n-l-k-2-1.PCX
#exec TEXTURE IMPORT	NAME=AndorianSwitchTex2 FILE=q:\klingons\art\decor\switches\nonlever\n-l-k-2-2.PCX

#exec MESHMAP NEW		MESHMAP=DecorAndorianSwitch MESH=DecorAndorianSwitch
#exec MESHMAP SCALE	MESHMAP=DecorAndorianSwitch X=0.08 Y=0.08 Z=0.15

#exec MESHMAP SETTEXTURE MESHMAP=DecorAndorianSwitch NUM=0 TEXTURE=AndorianSwitchTex1

defaultproperties
{
     SwitchOnTex=Texture'Klingons.AndorianSwitchTex2'
     SwitchOnSound=Sound'KlingonSFX01.Beeps.Bp25'
     SwitchOffSound=Sound'KlingonSFX01.Beeps.Bp25'
     Mesh=Mesh'Klingons.DecorAndorianSwitch'
}
