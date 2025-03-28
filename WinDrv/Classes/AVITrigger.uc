//=============================================================================
// AVITrigger.
//=============================================================================
class AVITrigger expands KlingonTrigger;

var   actor			GOther;
var   int  	 	    DonePlaying;
var() string[64] 	FileName[5];
var() string[2]		IsBriefing[5];

var actor A;
var int i;
var string[255] sendstr;


function Touch(actor Other)
{
	if (Level.NetMode == NM_StandAlone) {
		PlayerPawn(Other).ClientSetMusic( None, 0, 255, MTRAN_Instant );
		GOther = other;	
		KlingonHud(KlingonPlayer(Other).MyHud).AllowMenu(false);
		KlingonHUD(PlayerPawn(Other).myHUD).AnimateComStart();
		GotoState('AVIPlay');
	}
}


function Trigger(actor Other,pawn EventInstigator)
{
	Touch( EventInstigator );
	Super.Trigger(Other, EventInstigator);
}

state AVIPlay
{
	Begin:
		Sleep ( 2.0 );

		if( IsRelevant( GOther ) )
		{		    
			if (GOther.Instigator != None) {
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
							KlingonPlayer(GOther).LogBook.AVIIndex++;						
					}
							
					if ( "" == IsBriefing[i] )
						sendstr = sendstr $ " N";
					else
						sendstr = sendstr $ " " $ IsBriefing[i];
						
					if ( IsBriefing[i] == "Y" )
						KlingonPlayer(GOther).LogBook.CurrentAVI = FileName[i];
				}
				
				PlayerPawn(GOther).ConsoleCommand( sendstr );
			}

			KlingonHUD(PlayerPawn(GOther).myHUD).AnimateComStop();
			KlingonHud(KlingonPlayer(GOther).MyHud).AllowMenu(true);			
			Super.Touch( GOther );
	}

	PlayerPawn(GOther).ClientSetMusic( None, 0, Level.CDTrack, MTRAN_Instant );
}

defaultproperties
{
     FileName(0)="None"
     FileName(1)="None"
     FileName(2)="None"
     FileName(3)="None"
     FileName(4)="None"
     IsBriefing(0)="N"
     IsBriefing(1)="N"
     IsBriefing(2)="N"
     IsBriefing(3)="N"
     IsBriefing(4)="N"
}
