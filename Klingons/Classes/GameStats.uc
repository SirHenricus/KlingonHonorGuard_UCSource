//=============================================================================
// GameStats.
//=============================================================================
class GameStats expands Actor;

var int		ElapsedTime,
			GameKillCount,GameKillGoals,
			GameItemCount,GameItemGoals,
			GameSecretCount,GameSecretGoals;

var float	ElapsedMin,
			LastUpdateTime;

var int		ElapsedSec,
			LineNum,
			StartY;

function UpdateClient(KlingonPlayer Requester)
{
	Requester.ServerUpdateLevelStats();
}

function RefreshStats(int NewET,int NewKC,int NewKG,int NewIC,int NewIG,int NewSC,int NewSG)
{
	ElapsedTime=NewET;
	GameKillCount=NewKC;
	GameKillGoals=NewKG;
	GameItemCount=NewIC;
	GameItemGoals=NewIG;
	GameSecretCount=NewSC;
	GameSecretGoals=NewSG;
}

function PostRenderDrawText(canvas Canvas,string[64] S)
{
	local int	X,Y;
	local int	L,XL,YL;

	if (Canvas.ClipX >= 512) {
		Canvas.Font=Font'hMWhiteFont';
	}
	else {
		Canvas.Font=Font'hSWhiteFont';
	}
	L=Len(S);
	Canvas.StrLen(S,L,0,XL,YL);
	X=(Canvas.ClipX*0.5)-(XL*0.5);
	Y=StartY+(LineNum*YL);
	Canvas.SetPos(X,Y);
	Canvas.DrawText(S,False);
}

function PostRenderDrawLargeText(canvas Canvas,string[64] S)
{
	local int	X,Y;
	local int	L,XL,YL;

	if (Canvas.ClipX >= 512) {
		Canvas.Font=Font'hLRedFont';
	}
	else {
		Canvas.Font=Font'hMRedFont';
	}
	L=Len(S);
	Canvas.StrLen(S,L,0,XL,YL);
	X=(Canvas.ClipX*0.5)-(XL*0.5);
	Y=StartY+(LineNum*YL);
	Canvas.SetPos(X,Y);
	Canvas.DrawText(S,False);
}

function ShowStats(canvas Canvas)
{
	if (Level.LevelAction != LEVACT_None) {
		return;
	}
	if (Level.TimeSeconds-LastUpdateTime > 1.0) {
		if (KlingonPlayer(Owner) != None) {
			KlingonPlayer(Owner).ServerRequestLevelStats();
		}
		LastUpdateTime=Level.TimeSeconds;
	}
	if (Owner.IsInState('LevelEnded')) {
		ShowEndLevelStats(Canvas);
	}
	else {
		ShowInGameStats(Canvas);
	}
}

function ShowEndLevelStats(canvas Canvas)
{
	StartY=(Canvas.ClipY*0.2);
	LineNum=0;
	ElapsedMin=float(ElapsedTime)/60.0;
	ElapsedSec=int((ElapsedMin-int(ElapsedMin))*60.0);
	if (Level.Title != "" && Level.Title != "Untitled") {
		PostRenderDrawLargeText(Canvas,Level.Title);
	}
	LineNum++;
	LineNum++;
	if (ElapsedMin < 10) {
		if (ElapsedSec < 10) {
			PostRenderDrawText(Canvas,"TIME 0"$int(ElapsedMin)$":0"$ElapsedSec);
		}
		else {
			PostRenderDrawText(Canvas,"TIME 0"$int(ElapsedMin)$":"$ElapsedSec);
		}
	}
	else {
		if (ElapsedSec < 10) {
			PostRenderDrawText(Canvas,"TIME "$int(ElapsedMin)$":0"$ElapsedSec);
		}
		else {
			PostRenderDrawText(Canvas,"TIME "$int(ElapsedMin)$":"$ElapsedSec);
		}
	}
	LineNum++;
	PostRenderDrawText(Canvas,"KILLS "$GameKillCount$" / "$GameKillGoals);
	LineNum++;
	PostRenderDrawText(Canvas,"ITEMS "$GameItemCount$" / "$GameItemGoals);
	LineNum++;
	PostRenderDrawText(Canvas,"SECRETS "$GameSecretCount$" / "$GameSecretGoals);
	LineNum++;
	LineNum++;
	PostRenderDrawText(Canvas,"PRESS FIRE TO CONTINUE");
}

function ShowInGameStats(canvas Canvas)
{
	local string[50]	S;

	StartY=(Canvas.ClipY*0.8);
	LineNum=0;
	ElapsedMin=float(ElapsedTime)/60.0;
	ElapsedSec=int((ElapsedMin-int(ElapsedMin))*60.0);
	if (Level.Title != "" && Level.Title != "Untitled") {
		S=Left(Level.Title,4)$" ";
	}
	LineNum++;
	if (ElapsedMin < 10) {
		if (ElapsedSec < 10) {
			PostRenderDrawText(Canvas,S$"TIME 0"$int(ElapsedMin)$":0"$ElapsedSec);
		}
		else {
			PostRenderDrawText(Canvas,S$"TIME 0"$int(ElapsedMin)$":"$ElapsedSec);
		}
	}
	else {
		if (ElapsedSec < 10) {
			PostRenderDrawText(Canvas,S$"TIME "$int(ElapsedMin)$":0"$ElapsedSec);
		}
		else {
			PostRenderDrawText(Canvas,S$"TIME "$int(ElapsedMin)$":"$ElapsedSec);
		}
	}
	LineNum++;
	S="KILLS "$GameKillCount$"/"$GameKillGoals$" ITEMS "$GameItemCount$"/"$GameItemGoals$" SECRETS "$GameSecretCount$"/"$GameSecretGoals;
	PostRenderDrawText(Canvas,S);
}

function PreBeginPlay()
{
}

defaultproperties
{
     bHidden=True
}
