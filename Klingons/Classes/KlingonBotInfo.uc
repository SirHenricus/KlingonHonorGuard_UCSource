//=============================================================================
// KlingonBotInfo.
//=============================================================================
class KlingonBotInfo expands Info
	config;

var() config bool	bAdjustSkill;
var() config bool	bRandomOrder;

var() config string[20] BotNames[32];
var() config string[20] BotTeams[32];
var() config float BotSkills[32];
var	  byte ConfigUsed[32];
var() config string[32] BotClasses[32];
var() config string[64] BotSkins[32];

function PreBeginPlay()
{
	//DON'T Call parent prebeginplay
}

function int ChooseBotInfo()
{
	local int n, start;

	if ( bRandomOrder )
		n = Rand(16);
	else 
		n = 0;

	start = n;
	while ( (n < 32) && (ConfigUsed[n] == 1) )
		n++;

	if ( (n == 32) && bRandomOrder )
	{
		n = 0;
		while ( (n < start) && (ConfigUsed[n] == 1) )
			n++;
	}

	if ( n > 31 )
		n = 31;

	return n;
}

function class<bots> GetBotClass(int n)
{
	return class<bots>( DynamicLoadObject(GetBotClassName(n), class'Class') );
}

function Individualize(bots NewBot, int n, int NumBots)
{
	local texture NewSkin;
	local string[64] NewSkinName;


	// Set bot's skin
	NewSkinName = string(NewBot.skin);
	if ( (n >= 0) && (n < 32) && (BotSkins[n] != "") )
		NewSkinName = BotSkins[n];

	NewSkin = texture(DynamicLoadObject(string(NewBot.Mesh)$"Skins."$NewSkinName, class'Texture'));
	if ( NewSkin != None )
		NewBot.Skin = NewSkin;

	// Set bot's name.
	if ( (BotNames[n] == "") || (ConfigUsed[n] == 1) )
	{
		if ( NewBot.skin != None )
			BotNames[n] = string(NewBot.skin);
		else
			BotNames[n] = "Bot";
	}

	Level.Game.ChangeName( NewBot, BotNames[n], false );
	if ( BotNames[n] != NewBot.PlayerName )
		Level.Game.ChangeName( NewBot, ("Bot"$NumBots), false);

	ConfigUsed[n] = 1;

	// adjust bot skill
	NewBot.Skill = FClamp(NewBot.Skill + BotSkills[n], 0, 3);
	NewBot.ReSetSkill();
}

function SetBotClass(string[32] ClassName, int n)
{
	BotClasses[n] = ClassName;
}

function SetBotName(coerce string[20] NewName, int n)
{
	BotNames[n] = NewName;
}

function String[32] GetBotName(int n)
{
	return BotNames[n];
}

function string[20] GetBotTeam(int num)
{
	return BotTeams[Num];
}

function SetBotTeam(coerce string[20] NewTeam, int n)
{
	BotTeams[n] = NewTeam;
}

function string[64] GetBotSkin(int num)
{
	return BotSkins[Num];
}

function SetBotSkin(coerce string[64] NewSkin, int n)
{
	BotSkins[n] = NewSkin;
}

function String[32] GetBotClassName(int n)
{
	local float decision;


	if ( (n < 0) || (n > 31) || (BotClasses[n] == "") )
	{
		decision = FRand();
		if ( decision < 0.33 )
			BotClasses[n] = "Klingons.DMFemaleBot";
		else if ( decision < 0.5 )
			BotClasses[n] = "Klingons.DMMaleBot";
		else if ( decision < 0.67 )
			BotClasses[n] = "Klingons.DMFemaleBot";
		else if ( decision < 0.83 )
			BotClasses[n] = "Klingons.DMFemaleBot";
		else
			BotClasses[n] = "Klingons.DMMaleBot";
	}

	return BotClasses[n];
}

defaultproperties
{
     BotNames(0)="BOT00"
     BotNames(1)="BOT01"
     BotNames(2)="BOT02"
     BotNames(3)="BOT03"
     BotNames(4)="BOT04"
     BotNames(5)="BOT05"
     BotNames(6)="BOT06"
     BotNames(7)="BOT07"
     BotNames(8)="BOT08"
     BotNames(9)="BOT09"
     BotNames(10)="BOT10"
     BotNames(11)="BOT11"
     BotNames(12)="BOT12"
     BotNames(13)="BOT13"
     BotNames(14)="BOT14"
     BotNames(15)="BOT15"
     BotTeams(0)="Red"
     BotTeams(1)="Gold"
     BotTeams(2)="Green"
     BotTeams(3)="Grey"
     BotTeams(4)="Red"
     BotTeams(5)="Gold"
     BotTeams(6)="Green"
     BotTeams(7)="Grey"
     BotTeams(8)="Red"
     BotTeams(9)="Gold"
     BotTeams(10)="Green"
     BotTeams(11)="Grey"
     BotTeams(12)="Red"
     BotTeams(13)="Gold"
     BotTeams(14)="Green"
     BotTeams(15)="Grey"
     BotClasses(0)="Klingons.DMFemaleBot"
     BotClasses(1)="Klingons.DMMaleBot"
     BotClasses(2)="Klingons.DMFemaleBot"
     BotClasses(3)="Klingons.DMMaleBot"
     BotClasses(4)="Klingons.DMFemaleBot"
     BotClasses(5)="Klingons.DMMaleBot"
     BotClasses(6)="Klingons.DMFemaleBot"
     BotClasses(7)="Klingons.DMMaleBot"
     BotClasses(8)="Klingons.DMFemaleBot"
     BotClasses(9)="Klingons.DMMaleBot"
     BotClasses(10)="Klingons.DMFemaleBot"
     BotClasses(11)="Klingons.DMMaleBot"
     BotClasses(12)="Klingons.DMFemaleBot"
     BotClasses(13)="Klingons.DMMaleBot"
     BotClasses(14)="Klingons.DMFemaleBot"
     BotClasses(15)="Klingons.DMMaleBot"
     BotSkins(0)="DMFemaleSkins.Red"
     BotSkins(1)="DMMaleSkins.Gold"
     BotSkins(2)="DMFemaleSkins.Green"
     BotSkins(3)="DMMaleSkins.Grey"
     BotSkins(4)="DMFemaleSkins.Gold"
     BotSkins(5)="DMMaleSkins.Green"
     BotSkins(6)="DMFemaleSkins.Grey"
     BotSkins(7)="DMMaleSkins.Red"
     BotSkins(8)="DMFemaleSkins.Green"
     BotSkins(9)="DMMaleSkins.Grey"
     BotSkins(10)="DMFemaleSkins.Red"
     BotSkins(11)="DMMaleSkins.Gold"
     BotSkins(12)="DMFemaleSkins.Grey"
     BotSkins(13)="DMMaleSkins.Red"
     BotSkins(14)="DMFemaleSkins.Gold"
     BotSkins(15)="DMMaleSkins.Green"
}
