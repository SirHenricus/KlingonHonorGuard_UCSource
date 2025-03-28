//=============================================================================
// EmptyGoblet.
//=============================================================================
class EmptyGoblet expands KlingonDecorations;

#call q:\Klingons\Art\Pickups\Food\Goblet\Final\Goblet.mac

#exec MESH ORIGIN MESH=PowerUpGoblet X=0 Y=0 Z=25

defaultproperties
{
     ImpactSound=Sound'KlingonSFX01.Effects.DropGlass'
     DrawType=DT_Mesh
     Mesh=Mesh'Klingons.PowerUpGoblet'
     DrawScale=0.500000
     CollisionRadius=8.000000
     CollisionHeight=8.000000
     bCollideActors=True
     bProjTarget=True
     Mass=10.000000
     Buoyancy=8.000000
}
