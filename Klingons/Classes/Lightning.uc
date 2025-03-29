//=============================================================================
// Lightning.
//=============================================================================
class Lightning expands KlingonLights;

var float	DoEffectTimer;
var bool	DoEffectFlag;

auto state LightingEffect
{
	function Timer()
	{
		if (DoEffectFlag) {
			LightType=LT_None;
			DoEffectFlag=False;
			DoEffectTimer=FRand()*LightPeriod;
			SetTimer(DoEffectTimer,False);
			PlaySound(LightOffSound,SLOT_Ambient,LightOffVol);
		}
		else {
			LightType=Default.LightType;
			DoEffectFlag=True;
			SetTimer(1.0,False);
			PlaySound(LightOnSound,SLOT_Ambient,LightOnVol);
		}
	}
	function BeginState()
	{
		LightType=LT_None;
		DoEffectTimer=FRand()*LightPeriod;
		SetTimer(DoEffectTimer,False);
	}
}

defaultproperties
{
     bStatic=False
     LightType=LT_Flicker
     LightEffect=LE_TorchWaver
     LightBrightness=175
     LightHue=140
     LightSaturation=0
     LightRadius=50
     LightPeriod=200
     LightPhase=16
}
