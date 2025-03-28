//=============================================================================
// CDMusicTimer.
//=============================================================================
class CDMusicTimer expands Info;


var () float Tracks[20];
var int TrackNumber;


function PreBeginPlay()
{
	Super.PreBeginPlay();
//	log("in prebegin play for "$self);
//	log("owner="$Owner$"  "$KlingonPlayer(Owner));
	
	if (KlingonPlayer(Owner) != none)
	{
//		log("geing to playtrack for "$self);

		TrackNumber = 2;		// first track
//		GotoState('PlayTracks');
	}
}

function SetTrackNumber(float Tn)
{
	TrackNumber = Tn;
}

state PlayTracks
{

	function Timer()
	{
		TrackNumber++;
		if (TrackNumber < 20)
		{
			if (Tracks[TrackNumber] == 0.0)
			{
				// length is zero assume this is the last track
				TrackNumber = 2;
				KlingonPlayer(Owner).ClientSetMusic(None,0,TrackNumber,MTRAN_Instant);		
				SetTimer(Tracks[TrackNumber], false);
			}
			else
			{
				KlingonPlayer(Owner).ClientSetMusic(None,0,TrackNumber,MTRAN_Instant);		
				SetTimer(Tracks[TrackNumber], false);
			}
		}
		else
		{
			log("attempted to overwrite array bounds for CDMusicTimer");
		}
	}
	function BeginState()
	{
		if (TrackNumber < 2)
		{
//			log("invalid Data Track accessed");
			TrackNumber = 2;
		}
		if (Tracks[TrackNumber] == 0.0)
		{
			// length is zero assume this is the last track
			TrackNumber = 2;
			KlingonPlayer(Owner).ClientSetMusic(None,0,TrackNumber,MTRAN_Instant);		
		}
//		log("calling clientsetmusic for track "$TrackNumber);
		SetTimer(Tracks[TrackNumber], false);
	}
	
}

state StopTracks
{
	function BeginState()
	{
//		KlingonPlayer(Owner).ClientSetMusic(None,0,255,MTRAN_Fade);		
	}
}

defaultproperties
{
     Tracks(2)=264.000000
     Tracks(3)=262.000000
     Tracks(4)=254.000000
     Tracks(5)=259.000000
     Tracks(6)=249.000000
     Tracks(7)=263.000000
     Tracks(8)=284.000000
}
