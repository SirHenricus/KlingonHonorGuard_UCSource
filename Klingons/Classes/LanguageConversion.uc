//=============================================================================
// LanguageConversion.
//=============================================================================
class LanguageConversion expands KlingonTrigger;

function PreBeginPlay()
{
	local KlingonTrigger KT;
	foreach AllActors(class 'KlingonTrigger', KT)  
	{
		log("Name:"$KT.Name$"  Tag:"$KT.Tag$"  Event:"$KT.Event$"  Location:"$KT.location$"  Message:"$KT.Message);
	}
	
}

defaultproperties
{
}
