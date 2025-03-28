//=============================================================================
// ChargeCell.
//=============================================================================
class ChargeCell expands KlingonAmmo;

state Charging
{
	function Timer()
	{
		if (AmmoAmount < MaxAmmo) {
			AmmoAmount++;
		}
	}
	function BeginState()
	{
		SetTimer(0.5,True);
	}
}

state NotCharging
{
}

defaultproperties
{
     AmmoAmount=100
     MaxAmmo=100
     UsedInWeaponSlot(0)=2
     Icon=Texture'KlingonHUD.InvIcons.a_charge'
     bIsItemGoal=False
     DrawType=DT_Sprite
}
