//=============================================================================
// KlingonInventory.
//=============================================================================
class KlingonInventory expands Inventory;

var travel string[35] CurrentAVI;
var travel string[35] AVIToPlay;
var() string[35] 	  HUDAVIList[36];
var travel int		  AVIIndex;


simulated function ResetAVI()
{
	log ("ResetAVI");
	CurrentAVI = "None";
	AVIToPlay = "None";
	AVIIndex = 1;
}


simulated function SetAVIToPlay (int d)
{
	AVIToPlay = HUDAVIList[d];
	if ( AVIToPlay == "Brief03a.avi" )
		AVIToPlay = "Brief03a.avi C Brief03bcd.avi Y";
	
	log ("AVIToPlay" $ AVIToPlay);
}

defaultproperties
{
     HUDAVIList(1)="intro.avi N None N"
     HUDAVIList(2)="Brief0102.avi Y None N"
     HUDAVIList(3)="Brief03a.avi"
     HUDAVIList(4)="f_iceorb.avi N None N"
     HUDAVIList(5)="Brief04.avi Y  None N"
     HUDAVIList(6)="Brief05.avi Y None N"
     HUDAVIList(7)="Brief06.avi Y None N"
     HUDAVIList(8)="Brief07.avi Y None N"
     HUDAVIList(9)="f_bopo.avi N None N"
     HUDAVIList(10)="Brief08.avi Y None N"
     HUDAVIList(11)="f_ss.avi Y None N"
     HUDAVIList(12)="Brief09.avi Y None N"
     HUDAVIList(13)="Brief10.avi Y None N"
     HUDAVIList(14)="f_s2kv.avi Y None N"
     HUDAVIList(15)="Brief11.avi Y None N"
     HUDAVIList(16)="f_kv2d7.avi N None N"
     HUDAVIList(17)="Brief12.avi Y None N"
     HUDAVIList(18)="f_hullsep.avi N None N"
     HUDAVIList(19)="Brief13.avi Y None N"
     HUDAVIList(20)="f_decloak.avi N None N"
     HUDAVIList(21)="Brief14.avi Y None N"
     HUDAVIList(22)="Brief15.avi Y None N"
     HUDAVIList(23)="Brief16.avi Y None N"
     HUDAVIList(24)="Brief17.avi Y None N"
     HUDAVIList(25)="boplands.avi None N"
     HUDAVIList(26)="Brief18.avi Y None N"
     HUDAVIList(27)="kcs4-1.avi N None N"
     HUDAVIList(28)="Brief19.avi Y None N"
     HUDAVIList(29)="victory.avi Y None N"
}
