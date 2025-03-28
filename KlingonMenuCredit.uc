//=============================================================================
// KlingonMenuCredit.
//=============================================================================
class KlingonMenuCredit expands KlingonMenu;

var() sound ExitSound;
var bool    bSetup;
var int     pagenum;
var int     fadeval;
var int     fadestat;
var int 	fadetime;
var int     wait;
var bool    Exiting;
var float   AccumTime;
var localized string[40] SubTitle;
var int 	XDrawPos;
var int		YDrawPos;
var int 	CDWait;
var int 	LineNum;
var int 	CurrentLine;
var () texture Gamelogos[10];



function SetUpDisplay()
{	
	
	bSetup = true;
	fadetime = 7;
//	fadetime = 0;
	fadeval = fadetime-1;
	fadestat = 1;
	pagenum = 0;
	wait = 90;
	CDWait = 20;
	Exiting = false;
	AccumTime = 0;
	SubTitle = "MICROPROSE HUNT VALLEY DEVELOPMENT TEAM";
	XDrawPos = 110;
	YDrawPos = 100;
}

simulated function DrawLogo ( canvas Canvas , int TextureNumber, int X, int Y)
{
	local int TU;
	local int TV;

	TU = GameLogos[TextureNumber].UClamp * XRatio;
	TV = GameLogos[TextureNumber].VClamp * YRatio;
	
	Canvas.DrawColor.r = 255;
	Canvas.DrawColor.g = 255;
	Canvas.DrawColor.b = 255;	
	Canvas.bNoSmooth = true;	

	Canvas.Style = 2;
	
	Canvas.SetPos(X * XRatio,Y * YRatio);
	Canvas.DrawTile( GameLogos[TextureNumber], TU, TV, 0, 0, GameLogos[TextureNumber].UClamp, GameLogos[TextureNumber].VClamp );

	Canvas.bNoSmooth = True;	
	
	Canvas.Style = 1;
}


function CenterText(canvas Canvas,int NewY, string[64] S)
{
	local int	X,Y;
	local int	L,XL,YL;

	L=Len(S);
	Canvas.StrLen(S,L,0,XL,YL);
	X=(Canvas.ClipX*0.5)-(XL*0.5);
	Y=(Canvas.ClipY*0.2)+(LineNum*YL);

	Canvas.SetPos(X,NewY);
	Canvas.DrawText(S,False);
}


function CenterTextW(canvas Canvas,int NewY, string[64] S)
{
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMWhiteFont';
	else
		Canvas.Font = Font'hSWhiteFont';	
	CenterText(Canvas,NewY, S);
}

function CenterTextG(canvas Canvas,int NewY, string[64] S)
{
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMGreenFont';
	else
		Canvas.Font = Font'hSGreenFont';	
	CenterText(Canvas,NewY, S);
}

function CenterTextY(canvas Canvas,int NewY, string[64] S)
{
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMYellowFont';
	else
		Canvas.Font = Font'hSYellowFont';	
	CenterText(Canvas,NewY, S);
}

function CenterTextR(canvas Canvas,int NewY, string[64] S)
{
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMRedFont';
	else
		Canvas.Font = Font'hSRedFont';	
	CenterText(Canvas,NewY, S);
}

function CenterTextO(canvas Canvas,int NewY, string[64] S)
{
	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hMOrangeFont';
	else
		Canvas.Font = Font'hSOrangeFont';	
	CenterText(Canvas,NewY, S);
}


function int CurLine(float StartLine)
{
	CurrentLine += (20 * StartLine) * YRatio;
	return CurrentLine;
}


function MenuTick( float DeltaTime )
{
	// ( Level.Pauser == "" ) ||  Removed so deathmatch exit worked correctly
	if ( ( ( fadetime == 0 ) && ( Exiting == false ) ) )
		return;
	
	AccumTime += DeltaTime;

	if ( CDWait != 99 )
		CDWait--;
		
	if (( CDWait <= 0 ) && (Exiting == false))
	{
		PlayerOwner.ClientSetMusic( None, 0, 8, MTRAN_Fade );		
		CDWait = 99;
	}
	
	if ( AccumTime > 0.03 )
	{
		if ( fadeval > ( 255 - fadetime ) )
			fadestat = -fadetime;
		
		if ( fadeval < fadetime )		
		{
			fadestat = fadetime;
			pagenum++;
		}
			
		fadeval += fadestat;
		
		if ( true == Exiting )
			wait -= 1;
			
		AccumTime = 0;
	}
}


function MenuProcessInput( byte KeyNum, byte ActionNum )
{
	if ( Exiting == false )
	{
		if ( fadetime == 0 )
		{
			if ( KeyNum == EInputKey.IK_Escape )
			{
				PlayerOwner.PlaySound(ExitSound,,2.0);
				Exiting = true;
			}	
			else
				pagenum++;
		}
		else
		{
			PlayerOwner.PlaySound(ExitSound,,2.0);
			Exiting = true;
		}
	}
	else
	{
		Wait = 0;
	}
}


function DrawMenu(canvas Canvas)
{	
	DrawCreditBackGround( Canvas );
			
	if ( !bSetup )
		SetUpDisplay();

	DrawTitle( Canvas );
	DrawSubTitle( Canvas );

	if ( wait <= 0 )
		PlayerOwner.ConsoleCommand("Exit");


	if ( fadetime == 0 )
	{
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;	
	}
	else if ( fadeval > 255 ) 
	{
		Canvas.DrawColor.r = 255;
		Canvas.DrawColor.g = 255;
		Canvas.DrawColor.b = 255;
	}
	else if ( fadeval < 0 ) 
	{
		Canvas.DrawColor.r = 0;
		Canvas.DrawColor.g = 0;
		Canvas.DrawColor.b = 0;
	}
	else
	{
		Canvas.DrawColor.r = fadeval;
		Canvas.DrawColor.g = fadeval;
		Canvas.DrawColor.b = fadeval;
	}
		
	Canvas.bNoSmooth = False;
		
	switch ( pagenum )
	{
		case 1 :  // PRODUCTION STAFF
				if ( fadetime != 0 )
					fadetime = 4;
				
				CurrentLine = 0;				
				CenterTextW(Canvas, CurLine(7), "PRODUCERS");
				CenterTextG(Canvas, CurLine(1), "ALEX DE LUCIA");
				CenterTextG(Canvas, CurLine(1), "JAY LUSS");
				
				CenterTextW(Canvas, CurLine(2), "ASSOC PRODUCER");
				CenterTextG(Canvas, CurLine(1), "CHRIS BOWLING");

				CenterTextW(Canvas, CurLine(2), "GAME DESIGN");
				CenterTextG(Canvas, CurLine(1), "CHRISTOPHER CLARK");

				CenterTextW(Canvas, CurLine(2), "STORY BY");
				CenterTextG(Canvas, CurLine(1), "DAVID ELLIS");
				CenterTextG(Canvas, CurLine(1), "CHRISTOPHER CLARK");

				break;
		case 2 :  // LEADS
				if ( fadetime != 0 )
					fadetime = 4;

				CurrentLine = 0;
				CenterTextW(Canvas, CurLine(8), "LEAD PROGRAMMER");
				CenterTextG(Canvas, CurLine(1), "LES BIRD");
				
				CenterTextW(Canvas, CurLine(2), "LEAD ARTIST");
				CenterTextG(Canvas, CurLine(1), "DANIEL MYCKA");
				
				CenterTextW(Canvas, CurLine(2), "COMPOSER");
				CenterTextG(Canvas, CurLine(1), "ROLAND RIZZO");

				break;
				
		case 3 :  // PROGRAMMING
				if ( fadetime != 0 )
					fadetime = 4;

				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6) , "PROGRAMMING");

				CenterTextW(Canvas, CurLine(2), "AI PROGRAMMING");
				CenterTextY(Canvas, CurLine(1), "MARK 'ROADWARRIORX' BRADSHAW");
				CenterTextY(Canvas, CurLine(1), "WITH NATHAN MEFFORD");

				CenterTextW(Canvas, CurLine(2), "INSTALLER, INTERFACE, AND VIDEO INTEGRATION");
				CenterTextY(Canvas, CurLine(1), "KEITH 'SPECTYR' VERITY");

				CenterTextW(Canvas, CurLine(2), "DEATHRITE PROGRAMMING");
				CenterTextY(Canvas, CurLine(1), "CHRIS TAORMINO");

				break;
		case 4 :  // ART STAFF
				if ( fadetime != 0 )
					fadetime = 3;
			
				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "ART STAFF");

				CenterTextW(Canvas, CurLine(2), "CHARACTER/WEAPON ANIMATIONS");
				CenterTextY(Canvas, CurLine(1), "FRANK VIVIRITO");

				CenterTextW(Canvas, CurLine(2), "CHARACTER/WEAPON MODELS");
				CenterTextY(Canvas, CurLine(1), "FRANK VIVIRITO");
				CenterTextY(Canvas, CurLine(1), "DANIEL MYCKA");
				CenterTextY(Canvas, CurLine(1), "STACEY CLARK TRANTER");
				CenterTextY(Canvas, CurLine(1), "BARBARA BENTS MILLER");
				CenterTextY(Canvas, CurLine(1), "IAN WILMOTH");

				break;
		case 5 :  // ART STAFF 2
				if ( fadetime != 0 )
					fadetime = 4;

				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "ART STAFF");

				CenterTextW(Canvas, CurLine(2), "CHARACTER/WEAPON TEXTURES");
				CenterTextY(Canvas, CurLine(1), "JOHN CAMERON");
				CenterTextY(Canvas, CurLine(1), "STACEY CLARK TRANTER");
				CenterTextY(Canvas, CurLine(1), "BARBARA BENTS MILLER");
				CenterTextY(Canvas, CurLine(1), "KATHARINE SEMAN GARCIA");
				CenterTextY(Canvas, CurLine(1), "IAN WILMOTH");
				CenterTextY(Canvas, CurLine(1), "JEFF SKALSKI");
				CenterTextY(Canvas, CurLine(1), "DANIEL MYCKA");
				CenterTextY(Canvas, CurLine(1), "BOB KATHMAN");
				break;
		case 6 :  // ART STAFF 3
				if ( fadetime != 0 )
					fadetime = 3;
					
				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMWhiteFont';
				else
					Canvas.Font = Font'hSWhiteFont';
			
				Canvas.SetPos(254 * XRatio, 118 * YRatio );
				Canvas.DrawText("LEVEL DESIGN", False);

				Canvas.SetPos(245 * XRatio, 186 * YRatio );
				Canvas.DrawText("LEVEL BUILDERS", False);

				Canvas.SetPos(244 * XRatio, 300 * YRatio );
				Canvas.DrawText("WORLD TEXTURES", False);

				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMYellowFont';
				else
					Canvas.Font = Font'hSYellowFont';

				Canvas.SetPos(103 * XRatio, 138 * YRatio );
				Canvas.DrawText("CHRISTOPHER CLARK", False);

				Canvas.SetPos(375 * XRatio, 138 * YRatio );
				Canvas.DrawText("CHARLIE SHENTON", False);

				Canvas.SetPos(100 * XRatio, 158 * YRatio );
				Canvas.DrawText("DANIEL MYCKA", False);

				Canvas.SetPos(264 * XRatio, 158 * YRatio );
				Canvas.DrawText("KEVIN BOEHM", False);

				Canvas.SetPos(414 * XRatio, 158 * YRatio );
				Canvas.DrawText("JEFF SKALSKI", False);

				Canvas.SetPos(130 * XRatio, 206 * YRatio );
				Canvas.DrawText("CHARLIE SHENTON", False);

				Canvas.SetPos(383 * XRatio, 206 * YRatio );
				Canvas.DrawText("KEVIN BOEHM", False);

				Canvas.SetPos(130 * XRatio, 226 * YRatio );
				Canvas.DrawText("DANIEL MYCKA", False);

				Canvas.SetPos(383 * XRatio, 226 * YRatio );
				Canvas.DrawText("JEFF SKALSKI", False);

				Canvas.SetPos(188 * XRatio, 246 * YRatio );
				Canvas.DrawText("JAMES 'GO CANES' WHEELER", False);

				Canvas.SetPos(131 * XRatio, 266 * YRatio );
				Canvas.DrawText("WITH BOB KATHMAN AND JOHN CAMERON", False);

				// 	World Texturers
				Canvas.SetPos(130 * XRatio, 320 * YRatio );
				Canvas.DrawText("CHARLIE SHENTON", False);

				Canvas.SetPos(368 * XRatio, 320 * YRatio );
				Canvas.DrawText("KEVIN BOEHM", False);

				Canvas.SetPos(130 * XRatio, 340 * YRatio );
				Canvas.DrawText("JEFF SKALSKI", False);

				Canvas.SetPos(368 * XRatio, 340 * YRatio );
				Canvas.DrawText("BOB KATHMAN", False);

				Canvas.SetPos(130 * XRatio, 360 * YRatio );
				Canvas.DrawText("JOHN CAMERON", False);

				Canvas.SetPos(368 * XRatio, 360 * YRatio );
				Canvas.DrawText("DANIEL MYCKA", False);

				Canvas.SetPos(202 * XRatio, 380 * YRatio );
				Canvas.DrawText("KATHARINE SEMAN GARCIA", False);
				break;
				
		case 7 :  // ART STAFF 4
				if ( fadetime != 0 )
					fadetime = 3;
					
				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "MISSION BRIEFINGS");
				
				CenterTextW(Canvas, CurLine(1), "KURN AND KOREK MODELING/ANIMATION/LIP-SYNCH");
				CenterTextY(Canvas, CurLine(1), "BARBARA BENTS MILLER");
				
				CenterTextW(Canvas, CurLine(1.4), "GRAPHIC ANIMATIONS");
				CenterTextY(Canvas, CurLine(1), "BARBARA BENTS MILLER");
				CenterTextY(Canvas, CurLine(1), "STACEY CLARK TRANTER");
				CenterTextY(Canvas, CurLine(1), "WITH JOHN CAMERON AND MURRAY TAYLOR");

				CenterTextW(Canvas, CurLine(1.4), "CUT-SCENE ANIMATIONS");
				CenterTextY(Canvas, CurLine(1), "MURRAY TAYLOR");

				CenterTextW(Canvas, CurLine(1.4), "INSTALLATION MOVIE");
				CenterTextY(Canvas, CurLine(1), "DANIEL MYCKA");
				CenterTextY(Canvas, CurLine(1), "MURRAY TAYLOR");
				CenterTextY(Canvas, CurLine(1), "BARBARA BENTS MILLER");
				
				break;
		case 8 :  // SOUND DEPARTMENT
				if ( fadetime != 0 )
					fadetime = 3;
			
				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "SOUND RECORDING AND ENGINEERING");
			
				CenterTextW(Canvas, CurLine(2), "SOUND EFFECTS AND VOICE RECORDING");
				CenterTextY(Canvas, CurLine(1), "MARK CROMER");
				CenterTextY(Canvas, CurLine(1), "MARK REIS");

				CenterTextW(Canvas, CurLine(2), "DOLBY MOVIE SOUNDTRACK MIXES");
				CenterTextY(Canvas, CurLine(1), "MARK REIS");

				CenterTextW(Canvas, CurLine(2), "SCRIPTS");
				CenterTextY(Canvas, CurLine(1), "DAVID ELLIS AND CHRISTOPHER CLARK");

				break;
		case 9 :  // VOICE TALENT
				if ( fadetime != 0 )
					fadetime = 3;

				CurrentLine = 0;
				CenterTextW(Canvas, CurLine(7), "VOICE TALENT");

				CenterTextY(Canvas, CurLine(1), "CHRISTOPHER CLARK");
				CenterTextY(Canvas, CurLine(1), "MARK CROMER");
				CenterTextY(Canvas, CurLine(1), "DAVID ELLIS");
				CenterTextY(Canvas, CurLine(1), "LANI MINELLA");
				CenterTextY(Canvas, CurLine(1), "MATTHEW BELL");
				CenterTextY(Canvas, CurLine(1), "PAUL MOGH");
				CenterTextY(Canvas, CurLine(1), "KATHY FRAWLEY");
				CenterTextY(Canvas, CurLine(1), "MICHAEL DUBOSE");
				CenterTextY(Canvas, CurLine(1), "ROLAND RIZZO");
				CenterTextY(Canvas, CurLine(1), "BOB KATHMAN");
				
				
				break;
				
		case 10 :	// QUALITY ASSURANCE
				if ( fadetime != 0 )
					fadetime = 4;
				
				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "QUALITY ASSURANCE STAFF");
				
				CenterTextW(Canvas, CurLine(2), "DIRECTOR");
				CenterTextY(Canvas, CurLine(1), "RAY 'HENNY' BOYLAN");
				
				CenterTextW(Canvas, CurLine(2), "SUPERVISOR");
				CenterTextY(Canvas, CurLine(1), "THOMAS FALZONE, JR.");
				
				CenterTextW(Canvas, CurLine(2), "PROJECT LEADS");
				CenterTextY(Canvas, CurLine(1), "JEFF SMITH");
				CenterTextY(Canvas, CurLine(1), "TIM BEGGS");
				break;
		case 11 :	// QUALITY ASSURANCE
				if ( fadetime != 0 )
					fadetime = 3;
					
				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "QUALITY ASSURANCE STAFF");
				CenterTextW(Canvas, CurLine(1), "TESTERS");

				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMYellowFont';
				else
					Canvas.Font = Font'hSYellowFont';

				// Testers
				Canvas.SetPos(135 * XRatio, 170 * YRatio );
				Canvas.DrawText("PAUL AMBROSE", False);

				Canvas.SetPos(360 * XRatio, 170 * YRatio );
				Canvas.DrawText("MATT BITTMAN", False);

				Canvas.SetPos(135 * XRatio, 190 * YRatio );
				Canvas.DrawText("ELLIE CRAWLEY", False);

				Canvas.SetPos(360 * XRatio, 190 * YRatio );
				Canvas.DrawText("MIKE DAVIDSON", False);

				Canvas.SetPos(135 * XRatio, 210 * YRatio );
				Canvas.DrawText("ROSS EDWARDS", False);

				Canvas.SetPos(360 * XRatio, 210 * YRatio );
				Canvas.DrawText("GRANT FRAZIER", False);

				Canvas.SetPos(135 * XRatio, 230 * YRatio );
				Canvas.DrawText("MARK GUTKNECHT", False);

				Canvas.SetPos(360 * XRatio, 230 * YRatio );
				Canvas.DrawText("BRAD HOPPENSTEIN", False);

				Canvas.SetPos(135 * XRatio, 250 * YRatio );
				Canvas.DrawText("ROSALIE KOFSKY", False);

				Canvas.SetPos(360 * XRatio, 250 * YRatio );
				Canvas.DrawText("CHARLES LANE", False);

				Canvas.SetPos(135 * XRatio, 270 * YRatio );
				Canvas.DrawText("JOE LEASE", False);

				Canvas.SetPos(360 * XRatio, 270 * YRatio );
				Canvas.DrawText("JASON LEGO", False);

				Canvas.SetPos(135 * XRatio, 290 * YRatio );
				Canvas.DrawText("BRANDON MARTIN", False);

				Canvas.SetPos(360 * XRatio, 290 * YRatio );
				Canvas.DrawText("REX MARTIN", False);

				Canvas.SetPos(135 * XRatio, 310 * YRatio );
				Canvas.DrawText("TIM MCCRACKEN", False);

				Canvas.SetPos(360 * XRatio, 310 * YRatio );
				Canvas.DrawText("STEVE PURDIE", False);

				Canvas.SetPos(135 * XRatio, 330 * YRatio );
				Canvas.DrawText("SAL SACCHERI", False);

				Canvas.SetPos(360 * XRatio, 330 * YRatio );
				Canvas.DrawText("RICK SAFFERY", False);

				Canvas.SetPos(234 * XRatio, 350 * YRatio );
				Canvas.DrawText("GREG SCHNEIDER", False);
				break;		
		case 12 :	// OTHER FOLKS
				if ( fadetime != 0 )
					fadetime = 3;
				CurrentLine = 0;						
				CenterTextW(Canvas, CurLine(8), "DEATHRITE LEVEL BUILDERS");
				CenterTextY(Canvas, CurLine(1), "KLINGON HONOR GUARD TEAM");
				CenterTextY(Canvas, CurLine(1), "DANIEL ERAT");
				CenterTextY(Canvas, CurLine(1), "BRETT 'BEG' GNEITING");
				CenterTextY(Canvas, CurLine(1), "TOM HASKINS");
				CenterTextY(Canvas, CurLine(1), "A. ROBERTSON");

				CenterTextW(Canvas, CurLine(2), "DOCUMENTATION");
				CenterTextY(Canvas, CurLine(1), "JOHN POSSIDENTE");

				break;
		case 13 :	// OTHER FOLKS
				if ( fadetime != 0 )
					fadetime = 3;
					
				SubTitle = "";

				CurrentLine = 0;
				CenterTextW(Canvas, CurLine(7), "PRODUCT MARKETING");			
				CenterTextY(Canvas, CurLine(1), "DOMESTIC - MARY LYNN SLATTERY");			
				CenterTextY(Canvas, CurLine(1), "INTERNATIONAL - MATT CARROLL");			

				CenterTextW(Canvas, CurLine(2), "PUBLIC RELATIONS");
				CenterTextY(Canvas, CurLine(1), "DOMESTIC - KATHY SANGUINETTI");
				CenterTextY(Canvas, CurLine(1), "INTERNATIONAL - JASON DUTTON");
				
				CenterTextW(Canvas, CurLine(2), "LOCALIZATION");			
				CenterTextY(Canvas, CurLine(1), "DANIEL BERNER");			
				CenterTextY(Canvas, CurLine(1), "KAREN FFINCH");			
				CenterTextY(Canvas, CurLine(1), "SARAH COLLINS");			
				break;
				
		case 14 :  // PARAMOUNT
				if ( fadetime != 0 )
					fadetime = 3;

				CurrentLine = 0;
				CenterTextR(Canvas, CurLine(6), "PARAMOUNT PICTURES");

				CenterTextW(Canvas, CurLine(2), "VIACOM CONSUMER PRODUCTS");
				CenterTextY(Canvas, CurLine(1), "SUZIE DOMNICK");
				CenterTextY(Canvas, CurLine(1), "JULIET DUTTON");
				CenterTextY(Canvas, CurLine(1), "HARRY LANG");

				CenterTextW(Canvas, CurLine(2), "VOICE TALENT");
				CenterTextY(Canvas, CurLine(1), "TONY TODD AS COMMANDER KURN");
				CenterTextY(Canvas, CurLine(1), "ROBERT O' REILLY AS GOWRON");
				CenterTextY(Canvas, CurLine(1), "GWYNYTH WALSH AS B'ETOR");
				CenterTextY(Canvas, CurLine(1), "BARBARA MARCH AS LURSA");																
			
				break;
		case 15 :  // SPECIAL THANKS
				if ( fadetime != 0 )
					fadetime = 3;
					
				SubTitle = "SPECIAL THANKS";
				XDrawPos = 244;

				if ( Canvas.ClipY >= 400 )
					Canvas.Font = Font'hMOrangeFont';
				else
					Canvas.Font = Font'hSOrangeFont';

				Canvas.SetPos(100 * XRatio, 140 * YRatio );
				Canvas.DrawText("TIM SWEENY", False);

				Canvas.SetPos(400 * XRatio, 140 * YRatio );
				Canvas.DrawText("DAVID BROW", False);

				Canvas.SetPos(100 * XRatio, 160 * YRatio );
				Canvas.DrawText("RAUL 'ONLY ONE' AGUILAR", False);

				Canvas.SetPos(400 * XRatio, 160 * YRatio );
				Canvas.DrawText("DAN CURRY", False);

				Canvas.SetPos(100 * XRatio, 180 * YRatio );
				Canvas.DrawText("BUZZY'S RECORDING", False);

				Canvas.SetPos(400 * XRatio, 180 * YRatio );
				Canvas.DrawText("ROB CLOUTIER", False);

				Canvas.SetPos(100 * XRatio, 200 * YRatio );
				Canvas.DrawText("HARRY DENHOLM" , False);

				Canvas.SetPos(400 * XRatio, 200 * YRatio );
				Canvas.DrawText("SID DUTTON" , False);

				Canvas.SetPos(100 * XRatio, 220 * YRatio );
				Canvas.DrawText("DON HOWARD" , False);

				Canvas.SetPos(400 * XRatio, 220 * YRatio );
				Canvas.DrawText("ROBERT JANNEY" , False);

				Canvas.SetPos(100 * XRatio, 240 * YRatio );
				Canvas.DrawText("RICH 'YNROHKEEG' MATHESON", False);

				Canvas.SetPos(400 * XRatio, 240 * YRatio );
				Canvas.DrawText("MICHEAL REIS", False);

				Canvas.SetPos(100 * XRatio, 260 * YRatio );
				Canvas.DrawText("DESTIN STRADER", False);

				Canvas.SetPos(400 * XRatio, 260 * YRatio );
				Canvas.DrawText("JOHN TACKETT" , False);

				Canvas.SetPos(100 * XRatio, 280 * YRatio );
				Canvas.DrawText("GUY VARDAMAN" , False);

				Canvas.SetPos(400 * XRatio, 280 * YRatio );
				Canvas.DrawText("J WHITE" , False);
				
				Canvas.SetPos(400 * XRatio, 300 * YRatio );
				Canvas.DrawText("DAVID ROSSI" , False);
				

				break;
				
		case 16 :  // SPECIAL THANKS
				if ( fadetime != 0 )
					fadetime = 3;
					
				SubTitle = "SPECIAL THANKS";
				XDrawPos = 244;

				CurrentLine = 0;
				
				CenterTextO(Canvas, CurLine(7), "BRIAN BRUNNING - 3DFX");
				CenterTextO(Canvas, CurLine(1), "BRAD CRAIG - ADVANCED MICRO DEVICES");
				CenterTextO(Canvas, CurLine(1), "KEITH KOLOSI - ADVANCED MICRO DEVICES");
				CenterTextO(Canvas, CurLine(1), "SKIP MCILVAINE - AUREAL SEMICONDUCTOR");
				CenterTextO(Canvas, CurLine(1), "BILL HAVLICEK - CREATIVE LABS");
				CenterTextO(Canvas, CurLine(1), "JOHN LOOSE - DOLBY LABS");
				CenterTextO(Canvas, CurLine(1), "BRETT SCHNEPH - MICROSOFT");
				CenterTextO(Canvas, CurLine(1), "MATT PLOYHAR - MICROSOFT");
				DrawLogo ( Canvas , 0, 90, 20 * 5);	// 3dfx
				DrawLogo ( Canvas , 2, 430, 20 * 6);	// amd
				DrawLogo ( Canvas , 1, 100, 20 * 13);	// aureal
				DrawLogo ( Canvas , 3, 410, 20 * 16);	// creative
				
			
				break;
		case 17 :  // SPECIAL THANKS
				if ( fadetime != 0 )
					fadetime = 3;

				SubTitle = "SPECIAL THANKS";
				XDrawPos = 244;

				CurrentLine = 0;
				
				CenterTextO(Canvas, CurLine(7), "DIANA GOWEN - INTEL CORPORATION");
				CenterTextO(Canvas, CurLine(1), "ZACHARY SACHEN - INTEL CORPORATION");
				CenterTextO(Canvas, CurLine(1), "SHU-LING WU - INTEL CORPORATION");
				CenterTextO(Canvas, CurLine(1), "JAMES CLARDY - NEC");
				CenterTextO(Canvas, CurLine(1), "VIK LONG - NEC");
				CenterTextO(Canvas, CurLine(1), "DANNY SANCHEZ - QUANTUM3D");
				CenterTextO(Canvas, CurLine(1), "ANDY HESS - QUANTUM3D");
				DrawLogo ( Canvas , 5, 100, 260);	// Power
				DrawLogo ( Canvas , 6, 450, 260);	// quan
				DrawLogo ( Canvas , 7, 280, 300);	// intel
				

				break;
		case 18 : 
				if ( fadetime != 0 )
					fadetime = 3;

				SubTitle = "SPECIAL THANKS";
				XDrawPos = 244;

				CurrentLine = 0;
				CenterTextO(Canvas, CurLine(8), "AMY SMITH-BOYLAN");
				CenterTextO(Canvas, CurLine(1), "AND");
				CenterTextO(Canvas, CurLine(1), "SAMMY THE WONDER BEAGLE");

				break;
		case 19 : 
				if ( fadetime != 0 )
					fadetime = 3;

				SubTitle = "";
				XDrawPos = 244;

				CurrentLine = 0;
				DrawLogo ( Canvas , 4, 290, 170);	// epic
				
				CenterTextO(Canvas, CurLine(13), "THIS GAME MADE USING");
				CenterTextO(Canvas, CurLine(1), "THE UNREAL 3D ENGINE FROM");
				CenterTextO(Canvas, CurLine(1), "EPIC MEGAGAMES, INC.");
				if ( Exiting == false )
				{
					PlayerOwner.PlaySound(ExitSound,,2.0);
					Exiting = true;
				}
				break;
	}
}


function DrawTitle(canvas Canvas)
{
	local int	X,L,XL,YL;

	if ( Canvas.ClipY >= 400 )
		Canvas.Font = Font'hLRedFont';
	else
		Canvas.Font = Font'hMRedFont';

	L=Len(MenuTitle);
	Canvas.StrLen(MenuTitle,L,0,XL,YL);
	X=(Canvas.ClipX*0.5)-(XL*0.5);

	Canvas.SetPos( X, 70 * YRatio);

	Canvas.DrawText(MenuTitle, False);
}



function DrawSubTitle(canvas Canvas)
{
	CurrentLine = 0;
	CenterTextR(Canvas, CurLine(5), SubTitle);			
}

defaultproperties
{
     ExitSound=Sound'KlingonSFX01.creature.KorekLaugh'
     Gamelogos(0)=Texture'KlingonHUD.gamelogo.3dfx'
     Gamelogos(1)=Texture'KlingonHUD.gamelogo.A3D'
     Gamelogos(2)=Texture'KlingonHUD.gamelogo.Amd'
     Gamelogos(3)=Texture'KlingonHUD.gamelogo.Creative'
     Gamelogos(4)=Texture'KlingonHUD.gamelogo.Epiclogo'
     Gamelogos(5)=Texture'KlingonHUD.gamelogo.Powervr'
     Gamelogos(6)=Texture'KlingonHUD.gamelogo.Quantum3D'
     Gamelogos(7)=Texture'KlingonHUD.gamelogo.Intel'
     MenuTitle="KLINGON HONOR GUARD"
}
