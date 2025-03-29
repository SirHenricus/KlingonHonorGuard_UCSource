//=============================================================================
// KlingonTeleporter.
//=============================================================================
class KlingonTeleporter expands Teleporter;

var() class<TeleportEffects>	TeleportEffect;
var() sound						TeleportSound;

function PlayTeleportEffect(actor Incoming,bool bOut)
{
	local TeleportEffects	T;

	if (Incoming.IsA('Pawn')) {
		Incoming.MakeNoise(1.0);
		T=Spawn(TeleportEffect,,,Incoming.Location);
		if (T != None) {
			T.DrawScale=Incoming.DrawScale;
			T.TeleportDelay=2.0;
			T.PlaySound(TeleportSound);
		}
	}
}

defaultproperties
{
     TeleportEffect=Class'Klingons.TeleportParticles'
     TeleportSound=Sound'KlingonSFX01.Effects.Transporter'
     bStatic=False
}
