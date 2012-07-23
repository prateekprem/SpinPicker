//
//  Constents.h
//  SlotMAchine
//
//  Created by RAVI DAS on 06/07/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#define HANDLE_AS_MASTER YES

// connection timeouts
#define TIMEOUT 120

typedef enum ImagesOnStrip {
	ImageCherry,
	ImageApple,
	ImageBar,
	ImageOrange,
	ImageSeven
} ImagesOnStrip;

typedef enum WinState {
	WinNothing,
	WinWin,
	WinBig,
	WinJackpot
} WinState;

#define Slot        @"SlotShading.png"
#define Line        @"StopBar.png"
#define IMAGESINSTRIP			5



#define VIEWPORTINCREMENT(noOfRows)	((1.0 / (CGFloat) noOfRows))
#define MAXROTATION			4
#define MINROTATION			2
