//=============================================================================
// Keys.
//=============================================================================
class Keys expands KlingonPickups;

//
// Don't do anything on Toggle Activation of selected Item.
// 
function Activate()
{
}

//
// Advanced function which lets existing items in a pawn's inventory
// prevent the pawn from picking something up. Return true to abort pickup
// or if item handles the pickup
function bool HandlePickupQuery(Inventory Item)
{
	if (Item.IsA('Keys')) {
		if (Pawn(Owner).FindInventoryType(Item.Class) != None) {
			return(True);
		}
	}
	return(Super.HandlePickupQuery(Item));
}

defaultproperties
{
     bActivatable=False
     RespawnTime=1.000000
     bTravel=False
     Mass=0.000000
}
