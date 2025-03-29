//=============================================================================
// KlingonTeleTop.
//=============================================================================
class KlingonTeleTop expands KlingonTeleBottom;

#call q:\Klingons\Art\Creatures\Teleport\T-Top.mac

#exec MESH ORIGIN MESH=TeleTop X=0 Y=0 Z=-350 YAW=128

function BeginPlay()
{
}

defaultproperties
{
     bStatic=True
     Mesh=Mesh'Klingons.TeleTop'
     CollisionHeight=15.000000
}
