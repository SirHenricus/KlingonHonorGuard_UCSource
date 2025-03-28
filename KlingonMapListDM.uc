//=============================================================================
// KlingonMapListDM.
//=============================================================================
class KlingonMapListDM expands MapList
	config;

function string[32] GetNextMap()
{
	local int	i;

	Log(Self$".MapNum="$MapNum);
	for (i=0 ; i < 32 ; i++) {
		if (Maps[i] != "") {
			Log(Self$".Maps["$i$"]="$Maps[i]);
		}
	}
	return(Super.GetNextMap());
}

defaultproperties
{
     Maps(0)="DR01.unr"
     Maps(1)="DR02.unr"
     Maps(2)="DR03.unr"
     Maps(3)="DR04.unr"
     Maps(4)="DR05.unr"
     Maps(5)="DR06.unr"
     Maps(6)="DR07.unr"
     Maps(7)="DR08.unr"
     Maps(8)="DR09.unr"
     Maps(9)="DR10.unr"
     Maps(10)="DR11.unr"
     Maps(11)="DR12.unr"
}
