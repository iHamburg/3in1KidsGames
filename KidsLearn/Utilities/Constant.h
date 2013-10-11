

#pragma mark - Constant

#ifdef FREE
#define kAPPID 540878802
#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=540878802&mt=8"
#else
#define kAPPID 540869085
#define kApplink @"http://phobos.apple.com/WebObjects/MZStore.woa/wa/viewSoftware?id=540869085&mt=8"
#endif


#define kIAPFullVersion @"de.xappsoft.kidslearnnscfree.fullversion"

#define kCORNERRADIUS 20

#pragma mark - file


#define kFileAppSettingName @"AppSettingFile"
#define kFileSetting @"SettingFile"



#pragma mark - ViewTag


#define kTagCoverPhotoBarButtonItem 125



#pragma mark - Setting

#define kSettingFrameEnabled @"frameEnable"


#pragma mark - Notification

#define kNotifiRootDismiss @"dismiss"
#define kNotifiRootOpenTextLabelVC @"openTextLabel"  // object is string, font name, color?




#pragma mark - Universal UI

#define kUniversalFaktor isPad?1:2
#define kFrameUniversalHorizont isPad?CGRectMake(0,0,1024,768):CGRectMake(0,0,480,320)
#define kFrameUniHorizontWithNaviBar isPad?CGRectMake(0,0,1024,724):CGRectMake(0,0,480,288)


#define kUIContainerFrame isPad?CGRectMake(0,0,960,640):CGRectMake(0,0,480,320)




#define SSupportEmailTitle @"Feedback for 3in1 Kids Games"
#define SRecommendEmailTitle @"3in1 Kids Games -- Amazing App for Kids"



#pragma mark - Debug & Release

#ifdef DEBUG


#define kHost @"http://dev.thebootic.com/cgi-bin/search/"



#else

#define kHost @"http://www.thebootic.com/cgi-bin/search/"


#endif


#pragma mark - enum


typedef enum{
	PS_None,
	PS_Text,
	PS_TextLabel,
	PS_Image,
	PS_OneImage,
	PS_Zettel,
	PS_Sticker,
	PS_Love,
	PS_Setting,
	PS_Info
} PopOverStatus;


typedef enum{
    shapeCircle,
    shapeSquare,
    shapeTriangle,
    shapeRectangle,
    shapePentagon,
    shapeDiamond
}Shape;

typedef enum {
    colorRed,
    colorOrange,
    colorYellow,
    colorGreen,
    colorPink,
    colorBlue,
    colorViolet
}Color;



typedef enum {
    spielModeSpiel,
    spielModeTest,
    spielModeNumberLearn,
	spielModeColorLearn,
	SpielModeShapeLearn
}SpielMode;
