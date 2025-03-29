//=============================================================================
// KlingonTeleporterFavorites.
//=============================================================================
class KlingonTeleporterFavorites expands Teleporter;

var() byte FavoriteNumber;

function PostBeginPlay()
{
	local class<menu> MenuClass;
	local KlingonMenuFavorites TempM;

	MenuClass = class<menu>(DynamicLoadObject("Klingons.KlingonMenuFavorites", class'Class'));
	TempM = KlingonMenuFavorites(spawn(MenuClass));
	// FIXME (Help TIm?)
	//if ( FavoriteNumber < 12 )
	//	URL = TempM.Favorites[FavoriteNumber];
	Super.PostBeginPlay();
}

defaultproperties
{
}
