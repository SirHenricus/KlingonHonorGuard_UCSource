//=============================================================================
// TeleportEffects.
//=============================================================================
class TeleportEffects expands KlingonEffects;

#call q:\Klingons\Art\Effects\A-Transport\Final\A-Transport.mac

#exec MESHMAP SCALE MESHMAP=EffectAndorTransport X=0.08 Y=0.08 Z=0.15

var() float		TeleportDelay;

var actor		TriggerWhenDone;

state SpecialEffect
{
Begin:
	PlayAnim('Start',0.2);
	FinishAnim();
	LoopAnim('Transport',1.0);
	if (TeleportDelay != 0.0) {
		Sleep(TeleportDelay);
		PlayAnim('End',0.2);
		FinishAnim();
		if (TriggerWhenDone != None) {
			TriggerWhenDone.Trigger(Self,None);
		}
		Destroy();
	}
}

state TeleportEnd
{
Begin:
	PlayAnim('End',1.0);
	FinishAnim();
	if (TriggerWhenDone != None) {
		TriggerWhenDone.Trigger(Self,None);
	}
	Destroy();
}

defaultproperties
{
     TeleportDelay=2.000000
     ChildEffect=Class'Klingons.TeleportParticles'
     RemoteRole=ROLE_SimulatedProxy
     DrawType=DT_Mesh
     Style=STY_Masked
     Texture=FireTexture'KlingonFX01.Transporter.KTransp1'
     Skin=FireTexture'KlingonFX01.Transporter.KTransp1'
     Mesh=Mesh'Klingons.EffectAndorTransport'
     CollisionRadius=40.000000
     CollisionHeight=40.000000
     bProjTarget=True
}
