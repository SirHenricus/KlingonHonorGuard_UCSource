//=============================================================================
// KlingonMenuSlot.
//=============================================================================
class KlingonMenuSlot expands KlingonMenu
	config
	localized;

var   globalconfig string[100] SlotNames[9];
var() localized string[16] MonthNames[12];
var() localized string[32] EmptyString;

function DrawSlots(canvas Canvas, int StartX, int StartY)
{
	local int i;

	For ( i=1; i < 10; i++ )
	{
		MenuValues[i] = SlotNames[i-1];
	}
	
	KDrawChangeList(Canvas, StartX, StartY);
}

defaultproperties
{
     SlotNames(0)="..Empty.."
     SlotNames(1)="..Empty.."
     SlotNames(2)="..Empty.."
     SlotNames(3)="..Empty.."
     SlotNames(4)="..Empty.."
     SlotNames(5)="..Empty.."
     SlotNames(6)="..Empty.."
     SlotNames(7)="..Empty.."
     SlotNames(8)="..Empty.."
     MonthNames(0)="January"
     MonthNames(1)="February"
     MonthNames(2)="March"
     MonthNames(3)="April"
     MonthNames(4)="May"
     MonthNames(5)="June"
     MonthNames(6)="July"
     MonthNames(7)="August"
     MonthNames(8)="September"
     MonthNames(9)="October"
     MonthNames(10)="November"
     MonthNames(11)="December"
     EmptyString="..Empty.."
     MenuLength=9
}
