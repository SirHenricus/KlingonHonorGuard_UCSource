//=============================================================================
// AviTeleporter.
//=============================================================================
class AVITeleporter expands KlingonTeleporter;

var() string[64] 	FileName[5];
var() string[2]		IsBriefing[5];

function Touch(actor Other)
{
	local int			AVIIndex,
						i;
	local KlingonPlayer	K;
	local string[64]	LastAVI;
	local string[128] 	sendstr;

// It's possible that a boss may kill himself causing an AVI teleport
// so we'll make this not rely on players -LB

	if (Role < ROLE_Authority) {
		return;
	}

	if (Other != None && PlayerPawn(Other) != None) {
		if (PlayerPawn(Other).Health <= 0 && Level.NetMode == NM_StandAlone) {
			return;
		}
		if (PlayerPawn(Other).myHUD != None) {
			if (KlingonHUD(PlayerPawn(Other).myHUD) != None) {
				KlingonHUD(PlayerPawn(Other).myHUD).AllowMenu(False);
			}
		}
	}

	if (Level.NetMode == NM_StandAlone) {
		AVIIndex=0;
		sendstr="playavi";
		for (i=0 ; i < 5 ; i++) {
			if (FileName[i] == "") {
				sendstr=sendstr$" None";
			}
			else {
				sendstr=sendstr$" "$FileName[i];
				if ((FileName[i] != "None") 
					&& (FileName[i] != "death.avi")
					&& (FileName[i] != "f_d7x.avi") 
					&& (FileName[i] != "f_prax.avi")) {
						AVIIndex++;
				}
			}
			if (IsBriefing[i] == "") {
				sendstr=sendstr$" N";
			}
			else {
				sendstr=sendstr$" "$IsBriefing[i];
			}
			if (IsBriefing[i] == "Y") {
				LastAVI=FileName[i];
			}
		}
	}

// Find the player wherever he may be on the level.

	foreach AllActors(class 'KlingonPlayer',K) {
		if (Level.NetMode == NM_StandAlone) {
			if (K.LogBook != None) {
				K.LogBook.AVIIndex+=AVIIndex;
				K.LogBook.CurrentAVI=LastAVI;
			}
			K.CStr=sendstr;
		}
		Super.Touch(K);
	}
}

/*
function Touch(actor Other)
{
	local actor A;
	local int i;
	local string[255] sendstr;
	    
	if ( KlingonPlayer(Other).Health <= 0 ) 
		return;

	PlayerPawn(Other).ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );

	KlingonHud(KlingonPlayer(Other).MyHud).AllowMenu(false);
		
	if( Other.bCanTeleport && Other.PreTeleport(Self)==false )
	{
		if (Other.Instigator != None && Level.NetMode == NM_StandAlone) {
			sendstr = "playavi";
			for (i=0; i < 5; i++)
			{
				if ( "" == FileName[i] )		
					sendstr = sendstr $ " None";
				else
				{
					sendstr = sendstr $ " " $ FileName[i];
					if ( ( FileName[i] != "None" ) && ( FileName[i] != "death.avi" ) 
						 && ( FileName[i] != "f_d7x.avi" ) && ( FileName[i] != "f_prax.avi" ) )
						KlingonPlayer(Other).LogBook.AVIIndex++;						
				}
	
				if ( "" == IsBriefing[i] )
					sendstr = sendstr $ " N";
				else
					sendstr = sendstr $ " " $ IsBriefing[i];
					
				if ( IsBriefing[i] == "Y" )
					KlingonPlayer(Other).LogBook.CurrentAVI = FileName[i];					
			}
			
//			PlayerPawn(Other).ConsoleCommand( sendstr );
			if (KlingonPlayer(Other) != None) {
				KlingonPlayer(Other).CStr=sendstr;
			}
		}

//		PlayerPawn(Other).ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );
		
		Super.Touch( Other );
	}

}
*/

function Trigger(actor Other,pawn EventInstigator)
{
	Touch( EventInstigator );
	Super.Trigger(Other, EventInstigator);
}

defaultproperties
{
}
