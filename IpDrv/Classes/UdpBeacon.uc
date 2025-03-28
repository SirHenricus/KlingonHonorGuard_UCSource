//=============================================================================
// UdpBeacon: Base class of beacon sender and receiver.
//=============================================================================
class UdpBeacon expands UdpLink
	config
	transient;

var() globalconfig bool       DoBeacon;
var() globalconfig float      BeaconTime;
var() globalconfig int        BeaconPort;
var() globalconfig float      BeaconTimeout;
var() globalconfig string[32] BeaconProduct;

defaultproperties
{
     DoBeacon=True
     BeaconTime=0.500000
     BeaconPort=7776
     BeaconTimeout=5.000000
     BeaconProduct="Unreal"
}
