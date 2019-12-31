# -*- coding: mbcs -*-
# Created by makepy.py version 0.5.01
# By python version 3.6.2 (v3.6.2:5fd33b5, Jul  8 2017, 04:14:34) [MSC v.1900 32 bit (Intel)]
# From type library 'ScriptingSupport.8li'
# On Mon Feb  5 17:02:38 2018
'Adobe Photoshop CC 2018 Object Library'
makepy_version = '0.5.01'
python_version = 0x30602f0

import win32com.client.CLSIDToClass, pythoncom, pywintypes
import win32com.client.util
from pywintypes import IID
from win32com.client import Dispatch

# The following 3 lines may need tweaking for the particular server
# Candidates are pythoncom.Missing, .Empty and .ArgNotFound
defaultNamedOptArg=pythoncom.Empty
defaultNamedNotOptArg=pythoncom.Empty
defaultUnnamedArg=pythoncom.Empty

CLSID = IID('{E891EE9A-D0AE-4CB4-8871-F92C0109F18E}')
MajorVersion = 1
MinorVersion = 0
LibraryFlags = 8
LCID = 0x0

class constants:
	psAbsolute                    =2          # from enum PsAdjustmentReference
	psRelative                    =1          # from enum PsAdjustmentReference
	psBottomCenter                =8          # from enum PsAnchorPosition
	psBottomLeft                  =7          # from enum PsAnchorPosition
	psBottomRight                 =9          # from enum PsAnchorPosition
	psMiddleCenter                =5          # from enum PsAnchorPosition
	psMiddleLeft                  =4          # from enum PsAnchorPosition
	psMiddleRight                 =6          # from enum PsAnchorPosition
	psTopCenter                   =2          # from enum PsAnchorPosition
	psTopLeft                     =1          # from enum PsAnchorPosition
	psTopRight                    =3          # from enum PsAnchorPosition
	psCrisp                       =3          # from enum PsAntiAlias
	psNoAntialias                 =1          # from enum PsAntiAlias
	psSharp                       =2          # from enum PsAntiAlias
	psSmooth                      =5          # from enum PsAntiAlias
	psStrong                      =4          # from enum PsAntiAlias
	psManual                      =1          # from enum PsAutoKernType
	psMetrics                     =2          # from enum PsAutoKernType
	psOptical                     =3          # from enum PsAutoKernType
	psBMP16Bits                   =16         # from enum PsBMPDepthType
	psBMP1Bit                     =1          # from enum PsBMPDepthType
	psBMP24Bits                   =24         # from enum PsBMPDepthType
	psBMP32Bits                   =32         # from enum PsBMPDepthType
	psBMP4Bits                    =4          # from enum PsBMPDepthType
	psBMP8Bits                    =8          # from enum PsBMPDepthType
	psBMP_A1R5G5B5                =61         # from enum PsBMPDepthType
	psBMP_A4R4G4B4                =64         # from enum PsBMPDepthType
	psBMP_A8R8G8B8                =67         # from enum PsBMPDepthType
	psBMP_R5G6B5                  =62         # from enum PsBMPDepthType
	psBMP_R8G8B8                  =65         # from enum PsBMPDepthType
	psBMP_X1R5G5B5                =60         # from enum PsBMPDepthType
	psBMP_X4R4G4B4                =63         # from enum PsBMPDepthType
	psBMP_X8R8G8B8                =66         # from enum PsBMPDepthType
	psFolder                      =3          # from enum PsBatchDestinationType
	psNoDestination               =1          # from enum PsBatchDestinationType
	psSaveAndClose                =2          # from enum PsBatchDestinationType
	psCustomPattern               =5          # from enum PsBitmapConversionType
	psDiffusionDither             =3          # from enum PsBitmapConversionType
	psHalfThreshold               =1          # from enum PsBitmapConversionType
	psHalftoneScreen              =4          # from enum PsBitmapConversionType
	psPatternDither               =2          # from enum PsBitmapConversionType
	psHalftoneCross               =6          # from enum PsBitmapHalfToneType
	psHalftoneDiamond             =2          # from enum PsBitmapHalfToneType
	psHalftoneEllipse             =3          # from enum PsBitmapHalfToneType
	psHalftoneLine                =4          # from enum PsBitmapHalfToneType
	psHalftoneRound               =1          # from enum PsBitmapHalfToneType
	psHalftoneSquare              =5          # from enum PsBitmapHalfToneType
	psDocument16Bits              =16         # from enum PsBitsPerChannelType
	psDocument1Bit                =1          # from enum PsBitsPerChannelType
	psDocument32Bits              =32         # from enum PsBitsPerChannelType
	psDocument8Bits               =8          # from enum PsBitsPerChannelType
	psColorBlend                  =22         # from enum PsBlendMode
	psColorBurn                   =6          # from enum PsBlendMode
	psColorDodge                  =10         # from enum PsBlendMode
	psDarken                      =4          # from enum PsBlendMode
	psDarkerColor                 =28         # from enum PsBlendMode
	psDifference                  =18         # from enum PsBlendMode
	psDissolve                    =3          # from enum PsBlendMode
	psDivide                      =30         # from enum PsBlendMode
	psExclusion                   =19         # from enum PsBlendMode
	psHardLight                   =14         # from enum PsBlendMode
	psHardMix                     =26         # from enum PsBlendMode
	psHue                         =20         # from enum PsBlendMode
	psLighten                     =8          # from enum PsBlendMode
	psLighterColor                =27         # from enum PsBlendMode
	psLinearBurn                  =7          # from enum PsBlendMode
	psLinearDodge                 =11         # from enum PsBlendMode
	psLinearLight                 =16         # from enum PsBlendMode
	psLuminosity                  =23         # from enum PsBlendMode
	psMultiply                    =5          # from enum PsBlendMode
	psNormalBlend                 =2          # from enum PsBlendMode
	psOverlay                     =12         # from enum PsBlendMode
	psPassThrough                 =1          # from enum PsBlendMode
	psPinLight                    =17         # from enum PsBlendMode
	psSaturationBlend             =21         # from enum PsBlendMode
	psScreen                      =9          # from enum PsBlendMode
	psSoftLight                   =13         # from enum PsBlendMode
	psSubtract                    =29         # from enum PsBlendMode
	psVividLight                  =15         # from enum PsBlendMode
	psIBMByteOrder                =1          # from enum PsByteOrderType
	psMacOSByteOrder              =2          # from enum PsByteOrderType
	psCameraDefault               =0          # from enum PsCameraRAWSettingsType
	psCustomSettings              =2          # from enum PsCameraRAWSettingsType
	psSelectedImage               =1          # from enum PsCameraRAWSettingsType
	psExtraLargeCameraRAW         =4          # from enum PsCameraRAWSize
	psLargeCameraRAW              =3          # from enum PsCameraRAWSize
	psMaximumCameraRAW            =5          # from enum PsCameraRAWSize
	psMediumCameraRAW             =2          # from enum PsCameraRAWSize
	psMinimumCameraRAW            =0          # from enum PsCameraRAWSize
	psSmallCameraRAW              =1          # from enum PsCameraRAWSize
	psAllCaps                     =2          # from enum PsCase
	psNormalCase                  =1          # from enum PsCase
	psSmallCaps                   =3          # from enum PsCase
	psConvertToBitmap             =5          # from enum PsChangeMode
	psConvertToCMYK               =3          # from enum PsChangeMode
	psConvertToGrayscale          =1          # from enum PsChangeMode
	psConvertToIndexedColor       =6          # from enum PsChangeMode
	psConvertToLab                =4          # from enum PsChangeMode
	psConvertToMultiChannel       =7          # from enum PsChangeMode
	psConvertToRGB                =2          # from enum PsChangeMode
	psComponentChannel            =1          # from enum PsChannelType
	psMaskedAreaAlphaChannel      =2          # from enum PsChannelType
	psSelectedAreaAlphaChannel    =3          # from enum PsChannelType
	psSpotColorChannel            =4          # from enum PsChannelType
	PsColorBlendMode              =22         # from enum PsColorBlendMode
	psBehindBlend                 =24         # from enum PsColorBlendMode
	psClearBlend                  =25         # from enum PsColorBlendMode
	psColorBurnBlend              =6          # from enum PsColorBlendMode
	psColorDodgeBlend             =10         # from enum PsColorBlendMode
	psDarkenBlend                 =4          # from enum PsColorBlendMode
	psDarkerColorBlend            =28         # from enum PsColorBlendMode
	psDifferenceBlend             =18         # from enum PsColorBlendMode
	psDissolveBlend               =3          # from enum PsColorBlendMode
	psDivideBlend                 =30         # from enum PsColorBlendMode
	psExclusionBlend              =19         # from enum PsColorBlendMode
	psHardLightBlend              =14         # from enum PsColorBlendMode
	psHardMixBlend                =26         # from enum PsColorBlendMode
	psHueBlend                    =20         # from enum PsColorBlendMode
	psLightenBlend                =8          # from enum PsColorBlendMode
	psLighterColorBlend           =27         # from enum PsColorBlendMode
	psLinearBurnBlend             =7          # from enum PsColorBlendMode
	psLinearDodgeBlend            =11         # from enum PsColorBlendMode
	psLinearLightBlend            =16         # from enum PsColorBlendMode
	psLuminosityBlend             =23         # from enum PsColorBlendMode
	psMultiplyBlend               =5          # from enum PsColorBlendMode
	psNormalBlendColor            =2          # from enum PsColorBlendMode
	psOverlayBlend                =12         # from enum PsColorBlendMode
	psPinLightBlend               =17         # from enum PsColorBlendMode
	psSaturationBlendColor        =21         # from enum PsColorBlendMode
	psScreenBlend                 =9          # from enum PsColorBlendMode
	psSoftLightBlend              =13         # from enum PsColorBlendMode
	psSubtractBlend               =29         # from enum PsColorBlendMode
	psVividLightBlend             =15         # from enum PsColorBlendMode
	psCMYKModel                   =3          # from enum PsColorModel
	psGrayscaleModel              =1          # from enum PsColorModel
	psHSBModel                    =5          # from enum PsColorModel
	psLabModel                    =4          # from enum PsColorModel
	psNoModel                     =50         # from enum PsColorModel
	psRGBModel                    =2          # from enum PsColorModel
	psAdobeColorPicker            =1          # from enum PsColorPicker
	psAppleColorPicker            =2          # from enum PsColorPicker
	psPlugInColorPicker           =4          # from enum PsColorPicker
	psWindowsColorPicker          =3          # from enum PsColorPicker
	psCustom                      =3          # from enum PsColorProfileType
	psNo                          =1          # from enum PsColorProfileType
	psWorking                     =2          # from enum PsColorProfileType
	psAdaptive                    =2          # from enum PsColorReductionType
	psBlackWhiteReduction         =5          # from enum PsColorReductionType
	psCustomReduction             =4          # from enum PsColorReductionType
	psMacintoshColors             =7          # from enum PsColorReductionType
	psPerceptualReduction         =0          # from enum PsColorReductionType
	psRestrictive                 =3          # from enum PsColorReductionType
	psSFWGrayscale                =6          # from enum PsColorReductionType
	psSelective                   =1          # from enum PsColorReductionType
	psWindowsColors               =8          # from enum PsColorReductionType
	psAdobeRGB                    =0          # from enum PsColorSpaceType
	psColorMatchRGB               =1          # from enum PsColorSpaceType
	psProPhotoRGB                 =2          # from enum PsColorSpaceType
	psSRGB                        =3          # from enum PsColorSpaceType
	psCopyrightedWork             =1          # from enum PsCopyrightedType
	psPublicDomain                =2          # from enum PsCopyrightedType
	psUnmarked                    =3          # from enum PsCopyrightedType
	psDuplication                 =1          # from enum PsCreateFields
	psInterpolation               =2          # from enum PsCreateFields
	psArtBox                      =5          # from enum PsCropToType
	psBleedBox                    =3          # from enum PsCropToType
	psBoundingBox                 =0          # from enum PsCropToType
	psCropBox                     =2          # from enum PsCropToType
	psMediaBox                    =1          # from enum PsCropToType
	psTrimBox                     =4          # from enum PsCropToType
	psColorComposite              =3          # from enum PsDCSType
	psGrayscaleComposite          =2          # from enum PsDCSType
	psNoComposite                 =1          # from enum PsDCSType
	psImageHighlight              =4          # from enum PsDepthMapSource
	psLayerMask                   =3          # from enum PsDepthMapSource
	psNoSource                    =1          # from enum PsDepthMapSource
	psTransparencyChannel         =2          # from enum PsDepthMapSource
	psAliasType                   =11         # from enum PsDescValueType
	psBooleanType                 =5          # from enum PsDescValueType
	psClassType                   =10         # from enum PsDescValueType
	psDoubleType                  =2          # from enum PsDescValueType
	psEnumeratedType              =8          # from enum PsDescValueType
	psIntegerType                 =1          # from enum PsDescValueType
	psLargeIntegerType            =13         # from enum PsDescValueType
	psListType                    =6          # from enum PsDescValueType
	psObjectType                  =7          # from enum PsDescValueType
	psRawType                     =12         # from enum PsDescValueType
	psReferenceType               =9          # from enum PsDescValueType
	psStringType                  =4          # from enum PsDescValueType
	psUnitDoubleType              =3          # from enum PsDescValueType
	psDisplayAllDialogs           =1          # from enum PsDialogModes
	psDisplayErrorDialogs         =2          # from enum PsDialogModes
	psDisplayNoDialogs            =3          # from enum PsDialogModes
	psHorizontal                  =1          # from enum PsDirection
	psVertical                    =2          # from enum PsDirection
	psStretchToFit                =1          # from enum PsDisplacementMapType
	psTile                        =2          # from enum PsDisplacementMapType
	psDiffusion                   =2          # from enum PsDitherType
	psNoDither                    =1          # from enum PsDitherType
	psNoise                       =4          # from enum PsDitherType
	psPattern                     =3          # from enum PsDitherType
	psBackgroundColor             =2          # from enum PsDocumentFill
	psTransparent                 =3          # from enum PsDocumentFill
	psWhite                       =1          # from enum PsDocumentFill
	psBitmap                      =5          # from enum PsDocumentMode
	psCMYK                        =3          # from enum PsDocumentMode
	psDuotone                     =8          # from enum PsDocumentMode
	psGrayscale                   =1          # from enum PsDocumentMode
	psIndexedColor                =6          # from enum PsDocumentMode
	psLab                         =4          # from enum PsDocumentMode
	psMultiChannel                =7          # from enum PsDocumentMode
	psRGB                         =2          # from enum PsDocumentMode
	psConcise                     =2          # from enum PsEditLogItemsType
	psDetailed                    =3          # from enum PsEditLogItemsType
	psSessionOnly                 =1          # from enum PsEditLogItemsType
	psPlaceAfter                  =4          # from enum PsElementPlacement
	psPlaceAtBeginning            =1          # from enum PsElementPlacement
	psPlaceAtEnd                  =2          # from enum PsElementPlacement
	psPlaceBefore                 =3          # from enum PsElementPlacement
	psPlaceInside                 =0          # from enum PsElementPlacement
	psEvenFields                  =2          # from enum PsEliminateFields
	psOddFields                   =1          # from enum PsEliminateFields
	psIllustratorPaths            =1          # from enum PsExportType
	psSaveForWeb                  =2          # from enum PsExportType
	psLowercase                   =2          # from enum PsExtensionType
	psUppercase                   =3          # from enum PsExtensionType
	psDdmm                        =16         # from enum PsFileNamingType
	psDdmmyy                      =15         # from enum PsFileNamingType
	psDocumentNameLower           =2          # from enum PsFileNamingType
	psDocumentNameMixed           =1          # from enum PsFileNamingType
	psDocumentNameUpper           =3          # from enum PsFileNamingType
	psExtensionLower              =17         # from enum PsFileNamingType
	psExtensionUpper              =18         # from enum PsFileNamingType
	psMmdd                        =11         # from enum PsFileNamingType
	psMmddyy                      =10         # from enum PsFileNamingType
	psSerialLetterLower           =8          # from enum PsFileNamingType
	psSerialLetterUpper           =9          # from enum PsFileNamingType
	psSerialNumber1               =4          # from enum PsFileNamingType
	psSerialNumber2               =5          # from enum PsFileNamingType
	psSerialNumber3               =6          # from enum PsFileNamingType
	psSerialNumber4               =7          # from enum PsFileNamingType
	psYyddmm                      =14         # from enum PsFileNamingType
	psYymmdd                      =13         # from enum PsFileNamingType
	psYyyymmdd                    =12         # from enum PsFileNamingType
	psFontPreviewExtraLarge       =4          # from enum PsFontPreviewType
	psFontPreviewHuge             =5          # from enum PsFontPreviewType
	psFontPreviewLarge            =3          # from enum PsFontPreviewType
	psFontPreviewMedium           =2          # from enum PsFontPreviewType
	psFontPreviewNone             =0          # from enum PsFontPreviewType
	psFontPreviewSmall            =1          # from enum PsFontPreviewType
	psBlackWhite                  =2          # from enum PsForcedColors
	psNoForced                    =1          # from enum PsForcedColors
	psPrimaries                   =3          # from enum PsForcedColors
	psWeb                         =4          # from enum PsForcedColors
	psOptimizedBaseline           =2          # from enum PsFormatOptionsType
	psProgressive                 =3          # from enum PsFormatOptionsType
	psStandardBaseline            =1          # from enum PsFormatOptionsType
	psConstrainBoth               =3          # from enum PsGalleryConstrainType
	psConstrainHeight             =2          # from enum PsGalleryConstrainType
	psConstrainWidth              =1          # from enum PsGalleryConstrainType
	psArial                       =1          # from enum PsGalleryFontType
	psCourierNew                  =2          # from enum PsGalleryFontType
	psHelvetica                   =3          # from enum PsGalleryFontType
	psTimesNewRoman               =4          # from enum PsGalleryFontType
	psBlackText                   =1          # from enum PsGallerySecurityTextColorType
	psCustomText                  =3          # from enum PsGallerySecurityTextColorType
	psWhiteText                   =2          # from enum PsGallerySecurityTextColorType
	psCentered                    =1          # from enum PsGallerySecurityTextPositionType
	psLowerLeft                   =3          # from enum PsGallerySecurityTextPositionType
	psLowerRight                  =5          # from enum PsGallerySecurityTextPositionType
	psUpperLeft                   =2          # from enum PsGallerySecurityTextPositionType
	psUpperRight                  =4          # from enum PsGallerySecurityTextPositionType
	psClockwise45                 =2          # from enum PsGallerySecurityTextRotateType
	psClockwise90                 =3          # from enum PsGallerySecurityTextRotateType
	psCounterClockwise45          =4          # from enum PsGallerySecurityTextRotateType
	psCounterClockwise90          =5          # from enum PsGallerySecurityTextRotateType
	psZero                        =1          # from enum PsGallerySecurityTextRotateType
	psCaption                     =5          # from enum PsGallerySecurityType
	psCopyright                   =4          # from enum PsGallerySecurityType
	psCredit                      =6          # from enum PsGallerySecurityType
	psCustomSecurityText          =2          # from enum PsGallerySecurityType
	psFilename                    =3          # from enum PsGallerySecurityType
	psNoSecurity                  =1          # from enum PsGallerySecurityType
	psTitle                       =7          # from enum PsGallerySecurityType
	psCustomThumbnail             =4          # from enum PsGalleryThumbSizeType
	psLarge                       =3          # from enum PsGalleryThumbSizeType
	psMedium                      =2          # from enum PsGalleryThumbSizeType
	psSmall                       =1          # from enum PsGalleryThumbSizeType
	psHeptagon                    =4          # from enum PsGeometry
	psHexagon                     =2          # from enum PsGeometry
	psOctagon                     =5          # from enum PsGeometry
	psPentagon                    =1          # from enum PsGeometry
	psSquareGeometry              =3          # from enum PsGeometry
	psTriangle                    =0          # from enum PsGeometry
	psGridDashedLine              =2          # from enum PsGridLineStyle
	psGridDottedLine              =3          # from enum PsGridLineStyle
	psGridSolidLine               =1          # from enum PsGridLineStyle
	psLargeGrid                   =4          # from enum PsGridSize
	psMediumGrid                  =3          # from enum PsGridSize
	psNoGrid                      =1          # from enum PsGridSize
	psSmallGrid                   =2          # from enum PsGridSize
	psGuideDashedLine             =2          # from enum PsGuideLineStyle
	psGuideSolidLine              =1          # from enum PsGuideLineStyle
	psAllPaths                    =2          # from enum PsIllustratorPathType
	psDocumentBounds              =1          # from enum PsIllustratorPathType
	psNamedPath                   =3          # from enum PsIllustratorPathType
	psAbsoluteColorimetric        =4          # from enum PsIntent
	psPerceptual                  =1          # from enum PsIntent
	psRelativeColorimetric        =3          # from enum PsIntent
	psSaturation                  =2          # from enum PsIntent
	psBeforeRunning               =3          # from enum PsJavaScriptExecutionMode
	psDebuggerOnError             =2          # from enum PsJavaScriptExecutionMode
	psNeverShowDebugger           =1          # from enum PsJavaScriptExecutionMode
	psCenter                      =2          # from enum PsJustification
	psCenterJustified             =5          # from enum PsJustification
	psFullyJustified              =7          # from enum PsJustification
	psLeft                        =1          # from enum PsJustification
	psLeftJustified               =4          # from enum PsJustification
	psRight                       =3          # from enum PsJustification
	psRightJustified              =6          # from enum PsJustification
	psBrazillianPortuguese        =13         # from enum PsLanguage
	psCanadianFrench              =4          # from enum PsLanguage
	psDanish                      =17         # from enum PsLanguage
	psDutch                       =16         # from enum PsLanguage
	psEnglishUK                   =2          # from enum PsLanguage
	psEnglishUSA                  =1          # from enum PsLanguage
	psFinnish                     =5          # from enum PsLanguage
	psFrench                      =3          # from enum PsLanguage
	psGerman                      =6          # from enum PsLanguage
	psItalian                     =9          # from enum PsLanguage
	psNorwegian                   =10         # from enum PsLanguage
	psNynorskNorwegian            =11         # from enum PsLanguage
	psOldGerman                   =7          # from enum PsLanguage
	psPortuguese                  =12         # from enum PsLanguage
	psSpanish                     =14         # from enum PsLanguage
	psSwedish                     =15         # from enum PsLanguage
	psSwissGerman                 =8          # from enum PsLanguage
	psRLELayerCompression         =1          # from enum PsLayerCompressionType
	psZIPLayerCompression         =2          # from enum PsLayerCompressionType
	psBlackAndWhiteLayer          =22         # from enum PsLayerKind
	psBrightnessContrastLayer     =9          # from enum PsLayerKind
	psChannelMixerLayer           =12         # from enum PsLayerKind
	psColorBalanceLayer           =8          # from enum PsLayerKind
	psColorLookup                 =24         # from enum PsLayerKind
	psCurvesLayer                 =7          # from enum PsLayerKind
	psExposureLayer               =19         # from enum PsLayerKind
	psGradientFillLayer           =4          # from enum PsLayerKind
	psGradientMapLayer            =13         # from enum PsLayerKind
	psHueSaturationLayer          =10         # from enum PsLayerKind
	psInversionLayer              =14         # from enum PsLayerKind
	psLayer3D                     =20         # from enum PsLayerKind
	psLevelsLayer                 =6          # from enum PsLayerKind
	psNormalLayer                 =1          # from enum PsLayerKind
	psPatternFillLayer            =5          # from enum PsLayerKind
	psPhotoFilterLayer            =18         # from enum PsLayerKind
	psPosterizeLayer              =16         # from enum PsLayerKind
	psSelectiveColorLayer         =11         # from enum PsLayerKind
	psSmartObjectLayer            =17         # from enum PsLayerKind
	psSolidFillLayer              =3          # from enum PsLayerKind
	psTextLayer                   =2          # from enum PsLayerKind
	psThresholdLayer              =15         # from enum PsLayerKind
	psVibrance                    =23         # from enum PsLayerKind
	psVideoLayer                  =21         # from enum PsLayerKind
	psArtLayer                    =1          # from enum PsLayerType
	psLayerSet                    =2          # from enum PsLayerType
	psMoviePrime                  =5          # from enum PsLensType
	psPrime105                    =3          # from enum PsLensType
	psPrime35                     =2          # from enum PsLensType
	psZoomLens                    =1          # from enum PsLensType
	psActualSize                  =0          # from enum PsMagnificationType
	psFitPage                     =1          # from enum PsMagnificationType
	psBackgroundColorMatte        =3          # from enum PsMatteType
	psBlackMatte                  =5          # from enum PsMatteType
	psForegroundColorMatte        =2          # from enum PsMatteType
	psNetscapeGrayMatte           =7          # from enum PsMatteType
	psNoMatte                     =1          # from enum PsMatteType
	psSemiGray                    =6          # from enum PsMatteType
	psWhiteMatte                  =4          # from enum PsMatteType
	psActiveMeasurements          =2          # from enum PsMeasurementRange
	psAllMeasurements             =1          # from enum PsMeasurementRange
	psMeasureCountTool            =2          # from enum PsMeasurementSource
	psMeasureRulerTool            =3          # from enum PsMeasurementSource
	psMeasureSelection            =1          # from enum PsMeasurementSource
	psNewBitmap                   =5          # from enum PsNewDocumentMode
	psNewCMYK                     =3          # from enum PsNewDocumentMode
	psNewGray                     =1          # from enum PsNewDocumentMode
	psNewLab                      =4          # from enum PsNewDocumentMode
	psNewRGB                      =2          # from enum PsNewDocumentMode
	psGaussianNoise               =2          # from enum PsNoiseDistribution
	psUniformNoise                =1          # from enum PsNoiseDistribution
	psOffsetRepeatEdgePixels      =3          # from enum PsOffsetUndefinedAreas
	psOffsetSetToLayerFill        =1          # from enum PsOffsetUndefinedAreas
	psOffsetWrapAround            =2          # from enum PsOffsetUndefinedAreas
	psOpenCMYK                    =3          # from enum PsOpenDocumentMode
	psOpenGray                    =1          # from enum PsOpenDocumentMode
	psOpenLab                     =4          # from enum PsOpenDocumentMode
	psOpenRGB                     =2          # from enum PsOpenDocumentMode
	psAliasPIXOpen                =25         # from enum PsOpenDocumentType
	psBMPOpen                     =2          # from enum PsOpenDocumentType
	psCameraRAWOpen               =32         # from enum PsOpenDocumentType
	psCompuServeGIFOpen           =3          # from enum PsOpenDocumentType
	psDICOMOpen                   =33         # from enum PsOpenDocumentType
	psEPSOpen                     =22         # from enum PsOpenDocumentType
	psEPSPICTPreviewOpen          =23         # from enum PsOpenDocumentType
	psEPSTIFFPreviewOpen          =24         # from enum PsOpenDocumentType
	psElectricImageOpen           =26         # from enum PsOpenDocumentType
	psFilmstripOpen               =5          # from enum PsOpenDocumentType
	psJPEGOpen                    =6          # from enum PsOpenDocumentType
	psPCXOpen                     =7          # from enum PsOpenDocumentType
	psPDFOpen                     =21         # from enum PsOpenDocumentType
	psPICTFileFormatOpen          =10         # from enum PsOpenDocumentType
	psPICTResourceFormatOpen      =11         # from enum PsOpenDocumentType
	psPNGOpen                     =13         # from enum PsOpenDocumentType
	psPhotoCDOpen                 =9          # from enum PsOpenDocumentType
	psPhotoshopDCS_1Open          =18         # from enum PsOpenDocumentType
	psPhotoshopDCS_2Open          =19         # from enum PsOpenDocumentType
	psPhotoshopEPSOpen            =4          # from enum PsOpenDocumentType
	psPhotoshopOpen               =1          # from enum PsOpenDocumentType
	psPhotoshopPDFOpen            =8          # from enum PsOpenDocumentType
	psPixarOpen                   =12         # from enum PsOpenDocumentType
	psPortableBitmapOpen          =27         # from enum PsOpenDocumentType
	psRawOpen                     =14         # from enum PsOpenDocumentType
	psSGIRGBOpen                  =29         # from enum PsOpenDocumentType
	psScitexCTOpen                =15         # from enum PsOpenDocumentType
	psSoftImageOpen               =30         # from enum PsOpenDocumentType
	psTIFFOpen                    =17         # from enum PsOpenDocumentType
	psTargaOpen                   =16         # from enum PsOpenDocumentType
	psWavefrontRLAOpen            =28         # from enum PsOpenDocumentType
	psWirelessBitmapOpen          =31         # from enum PsOpenDocumentType
	psOS2                         =1          # from enum PsOperatingSystem
	psWindows                     =2          # from enum PsOperatingSystem
	psLandscape                   =1          # from enum PsOrientation
	psPortrait                    =2          # from enum PsOrientation
	psPreciseOther                =2          # from enum PsOtherPaintingCursors
	psStandardOther               =1          # from enum PsOtherPaintingCursors
	psPDF13                       =1          # from enum PsPDFCompatibilityType
	psPDF14                       =2          # from enum PsPDFCompatibilityType
	psPDF15                       =3          # from enum PsPDFCompatibilityType
	psPDF16                       =4          # from enum PsPDFCompatibilityType
	psPDF17                       =5          # from enum PsPDFCompatibilityType
	psPDFJPEG                     =2          # from enum PsPDFEncodingType
	psPDFJPEG2000HIGH             =9          # from enum PsPDFEncodingType
	psPDFJPEG2000LOSSLESS         =14         # from enum PsPDFEncodingType
	psPDFJPEG2000LOW              =13         # from enum PsPDFEncodingType
	psPDFJPEG2000MED              =11         # from enum PsPDFEncodingType
	psPDFJPEG2000MEDHIGH          =10         # from enum PsPDFEncodingType
	psPDFJPEG2000MEDLOW           =12         # from enum PsPDFEncodingType
	psPDFJPEGHIGH                 =4          # from enum PsPDFEncodingType
	psPDFJPEGLOW                  =8          # from enum PsPDFEncodingType
	psPDFJPEGMED                  =6          # from enum PsPDFEncodingType
	psPDFJPEGMEDHIGH              =5          # from enum PsPDFEncodingType
	psPDFJPEGMEDLOW               =7          # from enum PsPDFEncodingType
	psPDFNone                     =0          # from enum PsPDFEncodingType
	psPDFZip                      =1          # from enum PsPDFEncodingType
	psPDFZip4Bit                  =3          # from enum PsPDFEncodingType
	psNoResample                  =0          # from enum PsPDFResampleType
	psPDFAverage                  =1          # from enum PsPDFResampleType
	psPDFBicubic                  =3          # from enum PsPDFResampleType
	psPDFSubSample                =2          # from enum PsPDFResampleType
	psNoStandard                  =0          # from enum PsPDFStandardType
	psPDFX1A2001                  =1          # from enum PsPDFStandardType
	psPDFX1A2003                  =2          # from enum PsPDFStandardType
	psPDFX32002                   =3          # from enum PsPDFStandardType
	psPDFX32003                   =4          # from enum PsPDFStandardType
	psPDFX42008                   =5          # from enum PsPDFStandardType
	psPICT16Bits                  =16         # from enum PsPICTBitsPerPixels
	psPICT2Bits                   =2          # from enum PsPICTBitsPerPixels
	psPICT32Bits                  =32         # from enum PsPICTBitsPerPixels
	psPICT4Bits                   =4          # from enum PsPICTBitsPerPixels
	psPICT8Bits                   =8          # from enum PsPICTBitsPerPixels
	psJPEGHighPICT                =5          # from enum PsPICTCompression
	psJPEGLowPICT                 =2          # from enum PsPICTCompression
	psJPEGMaximumPICT             =6          # from enum PsPICTCompression
	psJPEGMediumPICT              =4          # from enum PsPICTCompression
	psNoPICTCompression           =1          # from enum PsPICTCompression
	psBrushSize                   =3          # from enum PsPaintingCursors
	psPrecise                     =2          # from enum PsPaintingCursors
	psStandard                    =1          # from enum PsPaintingCursors
	psExact                       =1          # from enum PsPaletteType
	psLocalAdaptive               =8          # from enum PsPaletteType
	psLocalPerceptual             =6          # from enum PsPaletteType
	psLocalSelective              =7          # from enum PsPaletteType
	psMacOSPalette                =2          # from enum PsPaletteType
	psMasterAdaptive              =11         # from enum PsPaletteType
	psMasterPerceptual            =9          # from enum PsPaletteType
	psMasterSelective             =10         # from enum PsPaletteType
	psPreviousPalette             =12         # from enum PsPaletteType
	psUniform                     =5          # from enum PsPaletteType
	psWebPalette                  =4          # from enum PsPaletteType
	psWindowsPalette              =3          # from enum PsPaletteType
	psClippingPath                =2          # from enum PsPathKind
	psNormalPath                  =1          # from enum PsPathKind
	psTextMask                    =5          # from enum PsPathKind
	psVectorMask                  =4          # from enum PsPathKind
	psWorkPath                    =3          # from enum PsPathKind
	psLab16                       =4          # from enum PsPhotoCDColorSpace
	psLab8                        =3          # from enum PsPhotoCDColorSpace
	psRGB16                       =2          # from enum PsPhotoCDColorSpace
	psRGB8                        =1          # from enum PsPhotoCDColorSpace
	psExtraLargePhotoCD           =5          # from enum PsPhotoCDSize
	psLargePhotoCD                =4          # from enum PsPhotoCDSize
	psMaximumPhotoCD              =6          # from enum PsPhotoCDSize
	psMediumPhotoCD               =3          # from enum PsPhotoCDSize
	psMinimumPhotoCD              =1          # from enum PsPhotoCDSize
	psSmallPhotoCD                =2          # from enum PsPhotoCDSize
	psCaptionText                 =5          # from enum PsPicturePackageTextType
	psCopyrightText               =4          # from enum PsPicturePackageTextType
	psCreditText                  =6          # from enum PsPicturePackageTextType
	psFilenameText                =3          # from enum PsPicturePackageTextType
	psNoText                      =1          # from enum PsPicturePackageTextType
	psOriginText                  =7          # from enum PsPicturePackageTextType
	psUserText                    =2          # from enum PsPicturePackageTextType
	psCornerPoint                 =2          # from enum PsPointKind
	psSmoothPoint                 =1          # from enum PsPointKind
	psPostScriptPoints            =1          # from enum PsPointType
	psTraditionalPoints           =2          # from enum PsPointType
	psPolarToRectangular          =2          # from enum PsPolarConversionType
	psRectangularToPolar          =1          # from enum PsPolarConversionType
	psEightBitTIFF                =3          # from enum PsPreviewType
	psMonochromeTIFF              =2          # from enum PsPreviewType
	psNoPreview                   =1          # from enum PsPreviewType
	psAllCaches                   =4          # from enum PsPurgeTarget
	psClipboardCache              =3          # from enum PsPurgeTarget
	psHistoryCaches               =2          # from enum PsPurgeTarget
	psUndoCaches                  =1          # from enum PsPurgeTarget
	psAlways                      =1          # from enum PsQueryStateType
	psAsk                         =2          # from enum PsQueryStateType
	psNever                       =3          # from enum PsQueryStateType
	psSpin                        =1          # from enum PsRadialBlurMethod
	psZoom                        =2          # from enum PsRadialBlurMethod
	psRadialBlurBest              =3          # from enum PsRadialBlurQuality
	psRadialBlurDraft             =1          # from enum PsRadialBlurQuality
	psRadialBlurGood              =2          # from enum PsRadialBlurQuality
	psEntireLayer                 =5          # from enum PsRasterizeType
	psFillContent                 =3          # from enum PsRasterizeType
	psLayerClippingPath           =4          # from enum PsRasterizeType
	psLinkedLayers                =6          # from enum PsRasterizeType
	psShape                       =2          # from enum PsRasterizeType
	psTextContents                =1          # from enum PsRasterizeType
	psReferenceClassType          =7          # from enum PsReferenceFormType
	psReferenceEnumeratedType     =5          # from enum PsReferenceFormType
	psReferenceIdentifierType     =3          # from enum PsReferenceFormType
	psReferenceIndexType          =2          # from enum PsReferenceFormType
	psReferenceNameType           =1          # from enum PsReferenceFormType
	psReferenceOffsetType         =4          # from enum PsReferenceFormType
	psReferencePropertyType       =6          # from enum PsReferenceFormType
	psAutomatic                   =8          # from enum PsResampleMethod
	psBicubic                     =4          # from enum PsResampleMethod
	psBicubicAutomatic            =7          # from enum PsResampleMethod
	psBicubicSharper              =5          # from enum PsResampleMethod
	psBicubicSmoother             =6          # from enum PsResampleMethod
	psBilinear                    =3          # from enum PsResampleMethod
	psNearestNeighbor             =2          # from enum PsResampleMethod
	psNoResampling                =1          # from enum PsResampleMethod
	psPreserveDetails             =9          # from enum PsResampleMethod
	psAllTools                    =2          # from enum PsResetTarget
	psAllWarnings                 =1          # from enum PsResetTarget
	psEverything                  =3          # from enum PsResetTarget
	psLargeRipple                 =3          # from enum PsRippleSize
	psMediumRipple                =2          # from enum PsRippleSize
	psSmallRipple                 =1          # from enum PsRippleSize
	psAlwaysSave                  =2          # from enum PsSaveBehavior
	psAskWhenSaving               =3          # from enum PsSaveBehavior
	psNeverSave                   =1          # from enum PsSaveBehavior
	psAliasPIXSave                =25         # from enum PsSaveDocumentType
	psBMPSave                     =2          # from enum PsSaveDocumentType
	psCompuServeGIFSave           =3          # from enum PsSaveDocumentType
	psElectricImageSave           =26         # from enum PsSaveDocumentType
	psJPEGSave                    =6          # from enum PsSaveDocumentType
	psPCXSave                     =7          # from enum PsSaveDocumentType
	psPICTFileFormatSave          =10         # from enum PsSaveDocumentType
	psPICTResourceFormatSave      =11         # from enum PsSaveDocumentType
	psPNGSave                     =13         # from enum PsSaveDocumentType
	psPhotoshopDCS_1Save          =18         # from enum PsSaveDocumentType
	psPhotoshopDCS_2Save          =19         # from enum PsSaveDocumentType
	psPhotoshopEPSSave            =4          # from enum PsSaveDocumentType
	psPhotoshopPDFSave            =8          # from enum PsSaveDocumentType
	psPhotoshopSave               =1          # from enum PsSaveDocumentType
	psPixarSave                   =12         # from enum PsSaveDocumentType
	psPortableBitmapSave          =27         # from enum PsSaveDocumentType
	psRawSave                     =14         # from enum PsSaveDocumentType
	psSGIRGBSave                  =29         # from enum PsSaveDocumentType
	psScitexCTSave                =15         # from enum PsSaveDocumentType
	psSoftImageSave               =30         # from enum PsSaveDocumentType
	psTIFFSave                    =17         # from enum PsSaveDocumentType
	psTargaSave                   =16         # from enum PsSaveDocumentType
	psWavefrontRLASave            =28         # from enum PsSaveDocumentType
	psWirelessBitmapSave          =31         # from enum PsSaveDocumentType
	psAscii                       =3          # from enum PsSaveEncoding
	psBinary                      =1          # from enum PsSaveEncoding
	psJPEGHigh                    =5          # from enum PsSaveEncoding
	psJPEGLow                     =2          # from enum PsSaveEncoding
	psJPEGMaximum                 =6          # from enum PsSaveEncoding
	psJPEGMedium                  =4          # from enum PsSaveEncoding
	psLogFile                     =2          # from enum PsSaveLogItemsType
	psLogFileAndMetadata          =3          # from enum PsSaveLogItemsType
	psMetadata                    =1          # from enum PsSaveLogItemsType
	psDoNotSaveChanges            =2          # from enum PsSaveOptions
	psPromptToSaveChanges         =3          # from enum PsSaveOptions
	psSaveChanges                 =1          # from enum PsSaveOptions
	psDiminishSelection           =3          # from enum PsSelectionType
	psExtendSelection             =2          # from enum PsSelectionType
	psIntersectSelection          =4          # from enum PsSelectionType
	psReplaceSelection            =1          # from enum PsSelectionType
	psShapeAdd                    =1          # from enum PsShapeOperation
	psShapeIntersect              =3          # from enum PsShapeOperation
	psShapeSubtract               =4          # from enum PsShapeOperation
	psShapeXOR                    =2          # from enum PsShapeOperation
	psSmartBlurEdgeOnly           =2          # from enum PsSmartBlurMode
	psSmartBlurNormal             =1          # from enum PsSmartBlurMode
	psSmartBlurOverlayEdge        =3          # from enum PsSmartBlurMode
	psSmartBlurHigh               =3          # from enum PsSmartBlurQuality
	psSmartBlurLow                =1          # from enum PsSmartBlurQuality
	psSmartBlurMedium             =2          # from enum PsSmartBlurQuality
	psDocumentSpace               =1          # from enum PsSourceSpaceType
	psProofSpace                  =2          # from enum PsSourceSpaceType
	psHorizontalSpherize          =2          # from enum PsSpherizeMode
	psNormalSpherize              =1          # from enum PsSpherizeMode
	psVerticalSpherize            =3          # from enum PsSpherizeMode
	psStrikeBox                   =3          # from enum PsStrikeThruType
	psStrikeHeight                =2          # from enum PsStrikeThruType
	psStrikeOff                   =1          # from enum PsStrikeThruType
	psCenterStroke                =2          # from enum PsStrokeLocation
	psInsideStroke                =1          # from enum PsStrokeLocation
	psOutsideStroke               =3          # from enum PsStrokeLocation
	psTarga16Bits                 =16         # from enum PsTargaBitsPerPixels
	psTarga24Bits                 =24         # from enum PsTargaBitsPerPixels
	psTarga32Bits                 =32         # from enum PsTargaBitsPerPixels
	psAdobeEveryLine              =2          # from enum PsTextComposer
	psAdobeSingleLine             =1          # from enum PsTextComposer
	psParagraphText               =2          # from enum PsTextType
	psPointText                   =1          # from enum PsTextType
	psBlocksTexture               =1          # from enum PsTextureType
	psCanvasTexture               =2          # from enum PsTextureType
	psFrostedTexture              =3          # from enum PsTextureType
	psTextureFile                 =5          # from enum PsTextureType
	psTinyLensTexture             =4          # from enum PsTextureType
	psNoTIFFCompression           =1          # from enum PsTiffEncodingType
	psTiffJPEG                    =3          # from enum PsTiffEncodingType
	psTiffLZW                     =2          # from enum PsTiffEncodingType
	psTiffZIP                     =4          # from enum PsTiffEncodingType
	psArtHistoryBrush             =9          # from enum PsToolType
	psBackgroundEraser            =4          # from enum PsToolType
	psBlur                        =11         # from enum PsToolType
	psBrush                       =2          # from enum PsToolType
	psBurn                        =14         # from enum PsToolType
	psCloneStamp                  =5          # from enum PsToolType
	psColorReplacementTool        =16         # from enum PsToolType
	psDodge                       =13         # from enum PsToolType
	psEraser                      =3          # from enum PsToolType
	psHealingBrush                =7          # from enum PsToolType
	psHistoryBrush                =8          # from enum PsToolType
	psPatternStamp                =6          # from enum PsToolType
	psPencil                      =1          # from enum PsToolType
	psSharpen                     =12         # from enum PsToolType
	psSmudge                      =10         # from enum PsToolType
	psSponge                      =15         # from enum PsToolType
	psBlindsHorizontal            =1          # from enum PsTransitionType
	psBlindsVertical              =2          # from enum PsTransitionType
	psBoxIn                       =4          # from enum PsTransitionType
	psBoxOut                      =5          # from enum PsTransitionType
	psDissolveTransition          =3          # from enum PsTransitionType
	psGlitterDown                 =6          # from enum PsTransitionType
	psGlitterRight                =7          # from enum PsTransitionType
	psGlitterRightDown            =8          # from enum PsTransitionType
	psNoTrasition                 =9          # from enum PsTransitionType
	psRandom                      =10         # from enum PsTransitionType
	psSplitHorizontalIn           =11         # from enum PsTransitionType
	psSplitHorizontalOut          =12         # from enum PsTransitionType
	psSplitVerticalIn             =13         # from enum PsTransitionType
	psSplitVerticalOut            =14         # from enum PsTransitionType
	psWipeDown                    =15         # from enum PsTransitionType
	psWipeLeft                    =16         # from enum PsTransitionType
	psWipeRight                   =17         # from enum PsTransitionType
	psWipeUp                      =18         # from enum PsTransitionType
	psBottomRightPixel            =9          # from enum PsTrimType
	psTopLeftPixel                =1          # from enum PsTrimType
	psTransparentPixels           =0          # from enum PsTrimType
	psTypeMM                      =4          # from enum PsTypeUnits
	psTypePixels                  =1          # from enum PsTypeUnits
	psTypePoints                  =5          # from enum PsTypeUnits
	psRepeatEdgePixels            =2          # from enum PsUndefinedAreas
	psWrapAround                  =1          # from enum PsUndefinedAreas
	psUnderlineLeft               =3          # from enum PsUnderlineType
	psUnderlineOff                =1          # from enum PsUnderlineType
	psUnderlineRight              =2          # from enum PsUnderlineType
	psCM                          =3          # from enum PsUnits
	psInches                      =2          # from enum PsUnits
	psMM                          =4          # from enum PsUnits
	psPercent                     =7          # from enum PsUnits
	psPicas                       =6          # from enum PsUnits
	psPixels                      =1          # from enum PsUnits
	psPoints                      =5          # from enum PsUnits
	psFour                        =4          # from enum PsUrgency
	psHigh                        =8          # from enum PsUrgency
	psLow                         =1          # from enum PsUrgency
	psNone                        =0          # from enum PsUrgency
	psNormal                      =5          # from enum PsUrgency
	psSeven                       =7          # from enum PsUrgency
	psSix                         =6          # from enum PsUrgency
	psThree                       =3          # from enum PsUrgency
	psTwo                         =2          # from enum PsUrgency
	psArc                         =2          # from enum PsWarpStyle
	psArcLower                    =3          # from enum PsWarpStyle
	psArcUpper                    =4          # from enum PsWarpStyle
	psArch                        =5          # from enum PsWarpStyle
	psBulge                       =6          # from enum PsWarpStyle
	psFish                        =11         # from enum PsWarpStyle
	psFishEye                     =13         # from enum PsWarpStyle
	psFlag                        =9          # from enum PsWarpStyle
	psInflate                     =14         # from enum PsWarpStyle
	psNoWarp                      =1          # from enum PsWarpStyle
	psRise                        =12         # from enum PsWarpStyle
	psShellLower                  =7          # from enum PsWarpStyle
	psShellUpper                  =8          # from enum PsWarpStyle
	psSqueeze                     =15         # from enum PsWarpStyle
	psTwist                       =16         # from enum PsWarpStyle
	psWave                        =10         # from enum PsWarpStyle
	psSine                        =1          # from enum PsWaveType
	psSquare                      =3          # from enum PsWaveType
	psTriangular                  =2          # from enum PsWaveType
	psAsShot                      =0          # from enum PsWhiteBalanceType
	psAuto                        =1          # from enum PsWhiteBalanceType
	psCloudy                      =3          # from enum PsWhiteBalanceType
	psCustomCameraSettings        =8          # from enum PsWhiteBalanceType
	psDaylight                    =2          # from enum PsWhiteBalanceType
	psFlash                       =7          # from enum PsWhiteBalanceType
	psFluorescent                 =6          # from enum PsWhiteBalanceType
	psShade                       =4          # from enum PsWhiteBalanceType
	psTungsten                    =5          # from enum PsWhiteBalanceType
	psAroundCenter                =1          # from enum PsZigZagType
	psOutFromCenter               =2          # from enum PsZigZagType
	psPondRipples                 =3          # from enum PsZigZagType

from win32com.client import DispatchBaseClass
class ArtLayer(DispatchBaseClass):
	'any layer that can contain data'
	CLSID = IID('{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
	coclass_clsid = None

	def AdjustBrightnessContrast(self, Brightness=defaultNamedNotOptArg, Contrast=defaultNamedNotOptArg):
		'adjust brightness and constrast'
		return self._oleobj_.InvokeTypes(1097084980, LCID, 1, (24, 0), ((3, 1), (3, 1)),Brightness
			, Contrast)

	def AdjustColorBalance(self, Shadows=defaultNamedOptArg, Midtones=defaultNamedOptArg, Highlights=defaultNamedOptArg, PreserveLuminosity=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1097084981, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17)),Shadows
			, Midtones, Highlights, PreserveLuminosity)

	def AdjustCurves(self, CurveShape=defaultNamedNotOptArg):
		'adjust curves of the selected channels'
		return self._oleobj_.InvokeTypes(1097084979, LCID, 1, (24, 0), ((12, 1),),CurveShape
			)

	def AdjustLevels(self, InputRangeStart=defaultNamedNotOptArg, InputRangeEnd=defaultNamedNotOptArg, InputRangeGamma=defaultNamedNotOptArg, OutputRangeStart=defaultNamedNotOptArg
			, OutputRangeEnd=defaultNamedNotOptArg):
		'adjust levels of the selected channels'
		return self._oleobj_.InvokeTypes(1097084977, LCID, 1, (24, 0), ((3, 1), (3, 1), (5, 1), (3, 1), (3, 1)),InputRangeStart
			, InputRangeEnd, InputRangeGamma, OutputRangeStart, OutputRangeEnd)

	def ApplyAddNoise(self, Amount=defaultNamedNotOptArg, Distribution=defaultNamedNotOptArg, Monochromatic=defaultNamedNotOptArg):
		'apply the add noise filter'
		return self._oleobj_.InvokeTypes(1177563448, LCID, 1, (24, 0), ((5, 1), (3, 1), (11, 1)),Amount
			, Distribution, Monochromatic)

	def ApplyAverage(self):
		'apply the average filter'
		return self._oleobj_.InvokeTypes(1177563959, LCID, 1, (24, 0), (),)

	def ApplyBlur(self):
		'apply the blur filter'
		return self._oleobj_.InvokeTypes(1177563185, LCID, 1, (24, 0), (),)

	def ApplyBlurMore(self):
		'apply the blur more filter'
		return self._oleobj_.InvokeTypes(1177563186, LCID, 1, (24, 0), (),)

	def ApplyClouds(self):
		'apply the clouds filter'
		return self._oleobj_.InvokeTypes(1177563953, LCID, 1, (24, 0), (),)

	def ApplyCustomFilter(self, Characteristics=defaultNamedNotOptArg, Scale=defaultNamedNotOptArg, Offset=defaultNamedNotOptArg):
		'apply the custom filter'
		return self._oleobj_.InvokeTypes(1177563702, LCID, 1, (24, 0), ((12, 1), (3, 1), (3, 1)),Characteristics
			, Scale, Offset)

	def ApplyDeInterlace(self, EliminateFields=defaultNamedNotOptArg, CreateFields=defaultNamedNotOptArg):
		'apply the de-interlace filter'
		return self._oleobj_.InvokeTypes(1177563957, LCID, 1, (24, 0), ((3, 1), (3, 1)),EliminateFields
			, CreateFields)

	def ApplyDespeckle(self):
		'apply the despeckle filter'
		return self._oleobj_.InvokeTypes(1177563449, LCID, 1, (24, 0), (),)

	def ApplyDifferenceClouds(self):
		'apply the difference clouds filter'
		return self._oleobj_.InvokeTypes(1177563954, LCID, 1, (24, 0), (),)

	def ApplyDiffuseGlow(self, Graininess=defaultNamedNotOptArg, GlowAmount=defaultNamedNotOptArg, ClearAmount=defaultNamedNotOptArg):
		'apply the diffuse glow filter'
		return self._oleobj_.InvokeTypes(1177563190, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1)),Graininess
			, GlowAmount, ClearAmount)

	def ApplyDisplace(self, HorizontalScale=defaultNamedNotOptArg, VerticalScale=defaultNamedNotOptArg, DisplacementType=defaultNamedNotOptArg, UndefinedAreas=defaultNamedNotOptArg
			, DisplacementMapFile=defaultNamedNotOptArg):
		'apply the displace filter'
		return self._oleobj_.InvokeTypes(1177563445, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1), (3, 1), (8, 1)),HorizontalScale
			, VerticalScale, DisplacementType, UndefinedAreas, DisplacementMapFile)

	def ApplyDustAndScratches(self, Radius=defaultNamedNotOptArg, Threshold=defaultNamedNotOptArg):
		'apply the dust and scratches filter'
		return self._oleobj_.InvokeTypes(1177563696, LCID, 1, (24, 0), ((3, 1), (3, 1)),Radius
			, Threshold)

	def ApplyGaussianBlur(self, Radius=defaultNamedNotOptArg):
		'apply the gaussian blur filter'
		return self._oleobj_.InvokeTypes(1195535474, LCID, 1, (24, 0), ((5, 1),),Radius
			)

	def ApplyGlassEffect(self, Distortion=defaultNamedNotOptArg, Smoothness=defaultNamedNotOptArg, Scaling=defaultNamedNotOptArg, Invert=defaultNamedOptArg
			, Texture=defaultNamedOptArg, TextureFile=defaultNamedOptArg):
		'apply the glass filter'
		return self._oleobj_.InvokeTypes(1177563191, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1), (12, 17), (12, 17), (12, 17)),Distortion
			, Smoothness, Scaling, Invert, Texture, TextureFile
			)

	def ApplyHighPass(self, Radius=defaultNamedNotOptArg):
		'apply the high pass filter'
		return self._oleobj_.InvokeTypes(1177563952, LCID, 1, (24, 0), ((5, 1),),Radius
			)

	def ApplyLensBlur(self, Source=defaultNamedOptArg, FocalDistance=defaultNamedOptArg, InvertDepthMap=defaultNamedOptArg, Shape=defaultNamedOptArg
			, Radius=defaultNamedOptArg, BladeCurvature=defaultNamedOptArg, Rotation=defaultNamedOptArg, Brightness=defaultNamedOptArg, Threshold=defaultNamedOptArg
			, Amount=defaultNamedOptArg, Distribution=defaultNamedOptArg, Monochromatic=defaultNamedOptArg):
		'apply the lens blur filter'
		return self._oleobj_.InvokeTypes(1282294380, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),Source
			, FocalDistance, InvertDepthMap, Shape, Radius, BladeCurvature
			, Rotation, Brightness, Threshold, Amount, Distribution
			, Monochromatic)

	def ApplyLensFlare(self, Brightness=defaultNamedNotOptArg, FlareCenter=defaultNamedNotOptArg, LensType=defaultNamedNotOptArg):
		'apply the lens flare filter'
		return self._oleobj_.InvokeTypes(1177563955, LCID, 1, (24, 0), ((3, 1), (12, 1), (3, 1)),Brightness
			, FlareCenter, LensType)

	def ApplyMaximum(self, Radius=defaultNamedNotOptArg):
		'apply the maximum filter'
		return self._oleobj_.InvokeTypes(1177563703, LCID, 1, (24, 0), ((5, 1),),Radius
			)

	def ApplyMedianNoise(self, Radius=defaultNamedNotOptArg):
		'apply the median noise filter'
		return self._oleobj_.InvokeTypes(1177563697, LCID, 1, (24, 0), ((5, 1),),Radius
			)

	def ApplyMinimum(self, Radius=defaultNamedNotOptArg):
		'apply the minimum filter'
		return self._oleobj_.InvokeTypes(1177563704, LCID, 1, (24, 0), ((5, 1),),Radius
			)

	def ApplyMotionBlur(self, Angle=defaultNamedNotOptArg, Radius=defaultNamedNotOptArg):
		'apply the motion blur filter'
		return self._oleobj_.InvokeTypes(1177563187, LCID, 1, (24, 0), ((3, 1), (5, 1)),Angle
			, Radius)

	def ApplyNTSC(self):
		'apply the NTSC colors filter'
		return self._oleobj_.InvokeTypes(1177563958, LCID, 1, (24, 0), (),)

	def ApplyOceanRipple(self, Size=defaultNamedNotOptArg, Magnitude=defaultNamedNotOptArg):
		'apply the ocean ripple filter'
		return self._oleobj_.InvokeTypes(1177563192, LCID, 1, (24, 0), ((3, 1), (3, 1)),Size
			, Magnitude)

	def ApplyOffset(self, Horizontal=defaultNamedNotOptArg, Vertical=defaultNamedNotOptArg, UndefinedAreas=defaultNamedNotOptArg):
		'apply the offset filter'
		return self._oleobj_.InvokeTypes(1177563705, LCID, 1, (24, 0), ((5, 1), (5, 1), (3, 1)),Horizontal
			, Vertical, UndefinedAreas)

	def ApplyPinch(self, Amount=defaultNamedNotOptArg):
		'apply the pinch filter'
		return self._oleobj_.InvokeTypes(1177563193, LCID, 1, (24, 0), ((3, 1),),Amount
			)

	def ApplyPolarCoordinates(self, Conversion=defaultNamedNotOptArg):
		'apply the polar coordinates filter'
		return self._oleobj_.InvokeTypes(1177563440, LCID, 1, (24, 0), ((3, 1),),Conversion
			)

	def ApplyRadialBlur(self, Amount=defaultNamedNotOptArg, BlurMethod=defaultNamedNotOptArg, BlurQuality=defaultNamedNotOptArg, BlurCenter=defaultNamedOptArg):
		'apply the radial blur filter'
		return self._oleobj_.InvokeTypes(1177563188, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1), (12, 17)),Amount
			, BlurMethod, BlurQuality, BlurCenter)

	def ApplyRipple(self, Amount=defaultNamedNotOptArg, Size=defaultNamedNotOptArg):
		'apply the ripple filter'
		return self._oleobj_.InvokeTypes(1177563441, LCID, 1, (24, 0), ((3, 1), (3, 1)),Amount
			, Size)

	def ApplySharpen(self):
		'apply the sharpen filter'
		return self._oleobj_.InvokeTypes(1177563698, LCID, 1, (24, 0), (),)

	def ApplySharpenEdges(self):
		'apply the sharpen edges filter'
		return self._oleobj_.InvokeTypes(1177563699, LCID, 1, (24, 0), (),)

	def ApplySharpenMore(self):
		'apply the sharpen more filter'
		return self._oleobj_.InvokeTypes(1177563700, LCID, 1, (24, 0), (),)

	def ApplyShear(self, Curve=defaultNamedNotOptArg, UndefinedAreas=defaultNamedNotOptArg):
		'apply the shear filter'
		return self._oleobj_.InvokeTypes(1177563442, LCID, 1, (24, 0), ((12, 1), (3, 1)),Curve
			, UndefinedAreas)

	def ApplySmartBlur(self, Radius=defaultNamedNotOptArg, Threshold=defaultNamedNotOptArg, BlurQuality=defaultNamedNotOptArg, Mode=defaultNamedNotOptArg):
		'apply the smart blur filter'
		return self._oleobj_.InvokeTypes(1177563189, LCID, 1, (24, 0), ((5, 1), (5, 1), (3, 1), (3, 1)),Radius
			, Threshold, BlurQuality, Mode)

	def ApplySpherize(self, Amount=defaultNamedNotOptArg, Mode=defaultNamedNotOptArg):
		'apply the spherize filter'
		return self._oleobj_.InvokeTypes(1177563443, LCID, 1, (24, 0), ((3, 1), (3, 1)),Amount
			, Mode)

	def ApplyStyle(self, StyleName=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1097878643, LCID, 1, (24, 0), ((8, 1),),StyleName
			)

	def ApplyTextureFill(self, TextureFile=defaultNamedNotOptArg):
		'apply the texture fill filter'
		return self._oleobj_.InvokeTypes(1177563956, LCID, 1, (24, 0), ((8, 1),),TextureFile
			)

	def ApplyTwirl(self, Angle=defaultNamedNotOptArg):
		'apply the twirl filter'
		return self._oleobj_.InvokeTypes(1177563444, LCID, 1, (24, 0), ((3, 1),),Angle
			)

	def ApplyUnSharpMask(self, Amount=defaultNamedNotOptArg, Radius=defaultNamedNotOptArg, Threshold=defaultNamedNotOptArg):
		'apply the unsharp mask filter'
		return self._oleobj_.InvokeTypes(1177563701, LCID, 1, (24, 0), ((5, 1), (5, 1), (3, 1)),Amount
			, Radius, Threshold)

	def ApplyWave(self, GeneratorNumber=defaultNamedNotOptArg, MinimumWavelength=defaultNamedNotOptArg, MaximumWavelength=defaultNamedNotOptArg, MinimumAmplitude=defaultNamedNotOptArg
			, MaximumAmplitude=defaultNamedNotOptArg, HorizontalScale=defaultNamedNotOptArg, VerticalScale=defaultNamedNotOptArg, WaveType=defaultNamedNotOptArg, UndefinedAreas=defaultNamedNotOptArg
			, RandomSeed=defaultNamedNotOptArg):
		'apply the wave filter'
		return self._oleobj_.InvokeTypes(1177563446, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1), (3, 1), (3, 1), (3, 1), (3, 1), (3, 1), (3, 1), (3, 1)),GeneratorNumber
			, MinimumWavelength, MaximumWavelength, MinimumAmplitude, MaximumAmplitude, HorizontalScale
			, VerticalScale, WaveType, UndefinedAreas, RandomSeed)

	def ApplyZigZag(self, Amount=defaultNamedNotOptArg, Ridges=defaultNamedNotOptArg, Style=defaultNamedNotOptArg):
		'apply the zigzag filter'
		return self._oleobj_.InvokeTypes(1177563447, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1)),Amount
			, Ridges, Style)

	def AutoContrast(self):
		'adjust contrast of the selected channels automatically'
		return self._oleobj_.InvokeTypes(1097084978, LCID, 1, (24, 0), (),)

	def AutoLevels(self):
		'adjust levels of the selected channels using auto levels option'
		return self._oleobj_.InvokeTypes(1094856753, LCID, 1, (24, 0), (),)

	def Clear(self):
		return self._oleobj_.InvokeTypes(1296117809, LCID, 1, (24, 0), (),)

	def Copy(self, Merge=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1668247673, LCID, 1, (24, 0), ((12, 17),),Merge
			)

	def Cut(self):
		return self._oleobj_.InvokeTypes(1668641824, LCID, 1, (24, 0), (),)

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	def Desaturate(self):
		return self._oleobj_.InvokeTypes(1097084982, LCID, 1, (24, 0), (),)

	def Duplicate(self, RelativeObject=defaultNamedOptArg, InsertionLocation=defaultNamedOptArg):
		'create a duplicate of the object'
		ret = self._oleobj_.InvokeTypes(1668050798, LCID, 1, (9, 0), ((12, 17), (12, 17)),RelativeObject
			, InsertionLocation)
		if ret is not None:
			ret = Dispatch(ret, 'Duplicate', None)
		return ret

	def Equalize(self):
		'equalize the levels'
		return self._oleobj_.InvokeTypes(1097084985, LCID, 1, (24, 0), (),)

	def Invert(self):
		'inverts the currently selected layer or channels'
		return self._oleobj_.InvokeTypes(1767272302, LCID, 1, (24, 0), (),)

	def Link(self, With=defaultNamedNotOptArg):
		'link the layer with another layer'
		return self._oleobj_.InvokeTypes(1818973295, LCID, 1, (24, 0), ((9, 1),),With
			)

	# Result is of type ArtLayer
	def Merge(self):
		'merges the layer down. This will remove the layer from the document. The method returns a reference to the art layer that this layer is merged into'
		ret = self._oleobj_.InvokeTypes(1298615386, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'Merge', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def MixChannels(self, OutputChannels=defaultNamedNotOptArg, Monochrome=defaultNamedOptArg):
		'only valid for RGB or CMYK documents'
		return self._oleobj_.InvokeTypes(1097084984, LCID, 1, (24, 0), ((12, 1), (12, 17)),OutputChannels
			, Monochrome)

	def Move(self, RelativeObject=defaultNamedNotOptArg, InsertionLocation=defaultNamedNotOptArg):
		'move the object'
		return self._oleobj_.InvokeTypes(1836021349, LCID, 1, (24, 0), ((9, 1), (3, 1)),RelativeObject
			, InsertionLocation)

	def MoveAfter(self, RelativeObject=defaultNamedNotOptArg):
		'Move the PageItem in behind object'
		return self._oleobj_.InvokeTypes(1299596641, LCID, 1, (24, 0), ((9, 1),),RelativeObject
			)

	def MoveBefore(self, RelativeObject=defaultNamedNotOptArg):
		'Move the PageItem in front of object'
		return self._oleobj_.InvokeTypes(1299596642, LCID, 1, (24, 0), ((9, 1),),RelativeObject
			)

	def MoveToBeginning(self, Container=defaultNamedNotOptArg):
		'Move the PageItem to beginning of container'
		return self._oleobj_.InvokeTypes(1299596646, LCID, 1, (24, 0), ((9, 1),),Container
			)

	def MoveToEnd(self, Container=defaultNamedNotOptArg):
		'Move the PageItem to end of container'
		return self._oleobj_.InvokeTypes(1299596645, LCID, 1, (24, 0), ((9, 1),),Container
			)

	def PhotoFilter(self, FillColor=defaultNamedOptArg, Density=defaultNamedOptArg, PreserveLuminosity=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1097085234, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),FillColor
			, Density, PreserveLuminosity)

	def Posterize(self, Levels=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1097085232, LCID, 1, (24, 0), ((3, 1),),Levels
			)

	def Rasterize(self, Target=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1383298162, LCID, 1, (24, 0), ((3, 1),),Target
			)

	def Resize(self, Horizontal=defaultNamedOptArg, Vertical=defaultNamedOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1399024741, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Horizontal
			, Vertical, Anchor)

	def Rotate(self, Angle=defaultNamedNotOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1383036001, LCID, 1, (24, 0), ((5, 1), (12, 17)),Angle
			, Anchor)

	def SelectiveColor(self, SelectionMethod=defaultNamedNotOptArg, Reds=defaultNamedOptArg, Yellows=defaultNamedOptArg, Greens=defaultNamedOptArg
			, Cyans=defaultNamedOptArg, Blues=defaultNamedOptArg, Magentas=defaultNamedOptArg, Whites=defaultNamedOptArg, Neutrals=defaultNamedOptArg
			, Blacks=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1097084983, LCID, 1, (24, 0), ((3, 1), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),SelectionMethod
			, Reds, Yellows, Greens, Cyans, Blues
			, Magentas, Whites, Neutrals, Blacks)

	def ShadowHighlight(self, ShadowAmount=defaultNamedOptArg, ShadowWidth=defaultNamedOptArg, ShadowRaduis=defaultNamedOptArg, HighlightAmount=defaultNamedOptArg
			, HighlightWidth=defaultNamedOptArg, HighlightRaduis=defaultNamedOptArg, ColorCorrection=defaultNamedOptArg, MidtoneContrast=defaultNamedOptArg, BlackClip=defaultNamedOptArg
			, WhiteClip=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1397239857, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),ShadowAmount
			, ShadowWidth, ShadowRaduis, HighlightAmount, HighlightWidth, HighlightRaduis
			, ColorCorrection, MidtoneContrast, BlackClip, WhiteClip)

	def Threshold(self, Level=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1097085233, LCID, 1, (24, 0), ((3, 1),),Level
			)

	def Translate(self, DeltaX=defaultNamedOptArg, DeltaY=defaultNamedOptArg):
		'moves the position relative to its current position'
		return self._oleobj_.InvokeTypes(1299599475, LCID, 1, (24, 0), ((12, 17), (12, 17)),DeltaX
			, DeltaY)

	def Unlink(self):
		'unlink the layer'
		return self._oleobj_.InvokeTypes(1433169515, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		"AllLocked": (1097616483, 2, (11, 0), (), "AllLocked", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		# Method 'ArtLayer' returns object of type 'ArtLayer'
		"ArtLayer": (1279358028, 2, (9, 0), (), "ArtLayer", '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}'),
		"BlendMode": (1114393956, 2, (3, 0), (), "BlendMode", None),
		"Bounds": (1114530931, 2, (12, 0), (), "Bounds", None),
		"FillOpacity": (1179611235, 2, (5, 0), (), "FillOpacity", None),
		"Grouped": (1883731792, 2, (11, 0), (), "Grouped", None),
		"IsBackgroundLayer": (1147292786, 2, (11, 0), (), "IsBackgroundLayer", None),
		"ItemIndex": (1886603640, 2, (3, 0), (), "ItemIndex", None),
		"Kind": (1265200740, 2, (3, 0), (), "Kind", None),
		"Layer": (1396927603, 2, (9, 0), (), "Layer", None),
		# Method 'LayerSet' returns object of type 'LayerSet'
		"LayerSet": (1279358042, 2, (9, 0), (), "LayerSet", '{C1C35524-2AA4-4630-80B9-011EFE3D5779}'),
		"LayerType": (1954115685, 2, (3, 0), (), "LayerType", None),
		"LinkedLayers": (1282106724, 2, (12, 0), (), "LinkedLayers", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Opacity": (1332765556, 2, (5, 0), (), "Opacity", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"PixelsLocked": (1350061155, 2, (11, 0), (), "PixelsLocked", None),
		"PositionLocked": (1349799011, 2, (11, 0), (), "PositionLocked", None),
		# Method 'TextItem' returns object of type 'TextItem'
		"TextItem": (1884058196, 2, (9, 0), (), "TextItem", '{E7A940CD-9AC7-4D76-975D-24D6BA0FDD16}'),
		"TransparentPixelsLocked": (1416645731, 2, (11, 0), (), "TransparentPixelsLocked", None),
		"Visible": (1884705634, 2, (11, 0), (), "Visible", None),
		"id": (1229201440, 2, (3, 0), (), "id", None),
	}
	_prop_map_put_ = {
		"AllLocked": ((1097616483, LCID, 4, 0),()),
		"BlendMode": ((1114393956, LCID, 4, 0),()),
		"FillOpacity": ((1179611235, LCID, 4, 0),()),
		"Grouped": ((1883731792, LCID, 4, 0),()),
		"IsBackgroundLayer": ((1147292786, LCID, 4, 0),()),
		"Kind": ((1265200740, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
		"Opacity": ((1332765556, LCID, 4, 0),()),
		"PixelsLocked": ((1350061155, LCID, 4, 0),()),
		"PositionLocked": ((1349799011, LCID, 4, 0),()),
		"TransparentPixelsLocked": ((1416645731, LCID, 4, 0),()),
		"Visible": ((1884705634, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class ArtLayers(DispatchBaseClass):
	CLSID = IID('{EC6A366C-F901-488D-A2C3-9E2E78B72DC6}')
	coclass_clsid = None

	# Result is of type ArtLayer
	def Add(self):
		'create a new object'
		ret = self._oleobj_.InvokeTypes(1665354858, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type ArtLayer
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def Remove(self, Item=defaultNamedNotOptArg):
		'Delete an element from the collection'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), ((9, 1),),Item
			)

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class Channel(DispatchBaseClass):
	'A channel in a document. Can be either a component channel representing a color of the document color model or an alpha channel'
	CLSID = IID('{4B9E6B85-0613-4873-8AB7-575CD2226768}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	# Result is of type Channel
	def Duplicate(self, TargetDocument=defaultNamedOptArg):
		'duplicate the channel'
		ret = self._oleobj_.InvokeTypes(1148207976, LCID, 1, (9, 0), ((12, 17),),TargetDocument
			)
		if ret is not None:
			ret = Dispatch(ret, 'Duplicate', '{4B9E6B85-0613-4873-8AB7-575CD2226768}')
		return ret

	def Merge(self):
		'merge a spot channel into the component channels'
		return self._oleobj_.InvokeTypes(1296849475, LCID, 1, (24, 0), (),)

	def SetColor(self, arg0=defaultUnnamedArg):
		'color of the channel (not valid for component channels)'
		return self._oleobj_.InvokeTypes(1883456323, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		# Method 'Color' returns object of type '_SolidColor'
		"Color": (1883456323, 2, (9, 0), (), "Color", '{D2D1665E-C1B9-4CA0-8AC9-529F6A3D9002}'),
		"Histogram": (1214870388, 2, (12, 0), (), "Histogram", None),
		"Kind": (1265200740, 2, (3, 0), (), "Kind", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Opacity": (1332765556, 2, (5, 0), (), "Opacity", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Visible": (1884705634, 2, (11, 0), (), "Visible", None),
	}
	_prop_map_put_ = {
		"Color": ((1883456323, LCID, 4, 0),()),
		"Kind": ((1265200740, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
		"Opacity": ((1332765556, LCID, 4, 0),()),
		"Visible": ((1884705634, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class Channels(DispatchBaseClass):
	'Channels of the document'
	CLSID = IID('{2DC64F97-8C69-4016-A8EB-89A00217291F}')
	coclass_clsid = None

	# Result is of type Channel
	def Add(self):
		'create a new object'
		ret = self._oleobj_.InvokeTypes(1665353838, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{4B9E6B85-0613-4873-8AB7-575CD2226768}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type Channel
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{4B9E6B85-0613-4873-8AB7-575CD2226768}')
		return ret

	def Remove(self, Item=defaultNamedNotOptArg):
		'Delete an element from the collection'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), ((9, 1),),Item
			)

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{4B9E6B85-0613-4873-8AB7-575CD2226768}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{4B9E6B85-0613-4873-8AB7-575CD2226768}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class ColorSampler(DispatchBaseClass):
	'A color sampler in a document. See the color sampler tool.'
	CLSID = IID('{B125A66B-4C94-4E55-AF2F-57EC4DCB484B}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	def Move(self, Position=defaultNamedNotOptArg):
		'move the color sampler to a new location'
		return self._oleobj_.InvokeTypes(1129534261, LCID, 1, (24, 0), ((12, 1),),Position
			)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		# Method 'Color' returns object of type '_SolidColor'
		"Color": (1883456323, 2, (9, 0), (), "Color", '{D2D1665E-C1B9-4CA0-8AC9-529F6A3D9002}'),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Position": (1332897646, 2, (12, 0), (), "Position", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class ColorSamplers(DispatchBaseClass):
	'A collection of color samplers'
	CLSID = IID('{97C81476-3F5D-4934-8CAA-1ED0242105B0}')
	coclass_clsid = None

	# Result is of type ColorSampler
	def Add(self, Position=defaultNamedNotOptArg):
		'a color sampler'
		ret = self._oleobj_.InvokeTypes(1129534256, LCID, 1, (9, 0), ((12, 1),),Position
			)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{B125A66B-4C94-4E55-AF2F-57EC4DCB484B}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type ColorSampler
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{B125A66B-4C94-4E55-AF2F-57EC4DCB484B}')
		return ret

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{B125A66B-4C94-4E55-AF2F-57EC4DCB484B}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{B125A66B-4C94-4E55-AF2F-57EC4DCB484B}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class CountItem(DispatchBaseClass):
	'A counted item in a document. See the counting tool.'
	CLSID = IID('{66869370-9672-492D-93AC-0ADD62F427F1}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Position": (1332897646, 2, (12, 0), (), "Position", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class CountItems(DispatchBaseClass):
	'A collection of count items'
	CLSID = IID('{9E01C1DA-DF69-4C2C-85EC-616370DF1CF0}')
	coclass_clsid = None

	# Result is of type CountItem
	def Add(self, Position=defaultNamedNotOptArg):
		'a count item'
		ret = self._oleobj_.InvokeTypes(1129590835, LCID, 1, (9, 0), ((12, 1),),Position
			)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{66869370-9672-492D-93AC-0ADD62F427F1}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type CountItem
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{66869370-9672-492D-93AC-0ADD62F427F1}')
		return ret

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{66869370-9672-492D-93AC-0ADD62F427F1}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{66869370-9672-492D-93AC-0ADD62F427F1}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class Document(DispatchBaseClass):
	'A document'
	CLSID = IID('{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
	coclass_clsid = None

	def AutoCount(self, Channel=defaultNamedNotOptArg, Threshold=defaultNamedNotOptArg):
		'automatically counts the objects in an image'
		return self._oleobj_.InvokeTypes(1129590837, LCID, 1, (24, 0), ((9, 1), (3, 1)),Channel
			, Threshold)

	def ChangeMode(self, DestinationMode=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'change the mode of the document'
		return self._oleobj_.InvokeTypes(1130906483, LCID, 1, (24, 0), ((3, 1), (12, 17)),DestinationMode
			, Options)

	def Close(self, Saving=defaultNamedOptArg):
		'close the document'
		return self._oleobj_.InvokeTypes(1668050803, LCID, 1, (24, 0), ((12, 17),),Saving
			)

	def ConvertProfile(self, DestinationProfile=defaultNamedNotOptArg, Intent=defaultNamedNotOptArg, BlackPointCompensation=defaultNamedOptArg, Dither=defaultNamedOptArg):
		'convert the document from using one color profile to using an other'
		return self._oleobj_.InvokeTypes(1131827314, LCID, 1, (24, 0), ((8, 1), (3, 1), (12, 17), (12, 17)),DestinationProfile
			, Intent, BlackPointCompensation, Dither)

	def Crop(self, Bounds=defaultNamedNotOptArg, Angle=defaultNamedOptArg, Width=defaultNamedOptArg, Height=defaultNamedOptArg):
		'crop the document'
		return self._oleobj_.InvokeTypes(1131573104, LCID, 1, (24, 0), ((12, 1), (12, 17), (12, 17), (12, 17)),Bounds
			, Angle, Width, Height)

	# Result is of type Document
	def Duplicate(self, Name=defaultNamedOptArg, MergeLayersOnly=defaultNamedOptArg):
		'duplicate this document with parameters'
		ret = self._oleobj_.InvokeTypes(1684235381, LCID, 1, (9, 0), ((12, 17), (12, 17)),Name
			, MergeLayersOnly)
		if ret is not None:
			ret = Dispatch(ret, 'Duplicate', '{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
		return ret

	def Export(self, ExportIn=defaultNamedNotOptArg, ExportAs=defaultNamedOptArg, Options=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1165521010, LCID, 1, (24, 0), ((8, 1), (12, 17), (12, 17)),ExportIn
			, ExportAs, Options)

	def Flatten(self):
		'Flattens all visible layers in the document.'
		return self._oleobj_.InvokeTypes(1181512814, LCID, 1, (24, 0), (),)

	def FlipCanvas(self, Direction=defaultNamedNotOptArg):
		'flip the canvas horizontally or vertically'
		return self._oleobj_.InvokeTypes(1181500278, LCID, 1, (24, 0), ((3, 1),),Direction
			)

	def ImportAnnotations(self, File=defaultNamedNotOptArg):
		'import annotations into the document'
		return self._oleobj_.InvokeTypes(1232093550, LCID, 1, (24, 0), ((8, 1),),File
			)

	def MergeVisibleLayers(self):
		'flatten all visible layers in the document'
		return self._oleobj_.InvokeTypes(1299608418, LCID, 1, (24, 0), (),)

	# Result is of type ArtLayer
	def Paste(self, IntoSelection=defaultNamedOptArg):
		'paste contents of clipboard into the document'
		ret = self._oleobj_.InvokeTypes(1885434740, LCID, 1, (9, 0), ((12, 17),),IntoSelection
			)
		if ret is not None:
			ret = Dispatch(ret, 'Paste', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def PrintOut(self, SourceSpace=defaultNamedOptArg, PrintSpace=defaultNamedOptArg, Intent=defaultNamedOptArg, BlackPointCompensation=defaultNamedOptArg):
		'print the document'
		return self._oleobj_.InvokeTypes(1349731152, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17)),SourceSpace
			, PrintSpace, Intent, BlackPointCompensation)

	def RasterizeAllLayers(self):
		'rasterize all layers'
		return self._oleobj_.InvokeTypes(1383743852, LCID, 1, (24, 0), (),)

	def RecordMeasurements(self, Source=defaultNamedOptArg, DataPoints=defaultNamedOptArg):
		'record measurements of document'
		return self._oleobj_.InvokeTypes(1296379956, LCID, 1, (24, 0), ((12, 17), (12, 17)),Source
			, DataPoints)

	def ResizeCanvas(self, Width=defaultNamedOptArg, Height=defaultNamedOptArg, Anchor=defaultNamedOptArg):
		'change the size of the canvas'
		return self._oleobj_.InvokeTypes(1383744374, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Width
			, Height, Anchor)

	def ResizeImage(self, Width=defaultNamedOptArg, Height=defaultNamedOptArg, Resolution=defaultNamedOptArg, ResampleMethod=defaultNamedOptArg
			, Amount=defaultNamedOptArg):
		'change the size of the image'
		return self._oleobj_.InvokeTypes(1383745901, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),Width
			, Height, Resolution, ResampleMethod, Amount)

	def RevealAll(self):
		'expand document to show clipped sections'
		return self._oleobj_.InvokeTypes(1383481708, LCID, 1, (24, 0), (),)

	def RotateCanvas(self, Angle=defaultNamedNotOptArg):
		'rotate canvas of document'
		return self._oleobj_.InvokeTypes(1383351158, LCID, 1, (24, 0), ((5, 1),),Angle
			)

	def Save(self):
		'save the document'
		return self._oleobj_.InvokeTypes(1346589558, LCID, 1, (24, 0), (),)

	def SaveAs(self, SaveIn=defaultNamedNotOptArg, Options=defaultNamedOptArg, AsCopy=defaultNamedOptArg, ExtensionType=defaultNamedOptArg):
		'save the document with specific save options'
		return self._oleobj_.InvokeTypes(1400258931, LCID, 1, (24, 0), ((8, 1), (12, 17), (12, 17), (12, 17)),SaveIn
			, Options, AsCopy, ExtensionType)

	def SplitChannels(self):
		'split channels of the document'
		return self._ApplyTypes_(1399866216, 1, (12, 0), (), 'SplitChannels', None,)

	def Trap(self, Width=defaultNamedNotOptArg):
		'apply trap to a CMYK document'
		return self._oleobj_.InvokeTypes(1416782192, LCID, 1, (24, 0), ((3, 1),),Width
			)

	def Trim(self, Type=defaultNamedOptArg, Top=defaultNamedOptArg, Left=defaultNamedOptArg, Bottom=defaultNamedOptArg
			, Right=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1416784237, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),Type
			, Top, Left, Bottom, Right)

	_prop_map_get_ = {
		"ActiveChannels": (1145269868, 2, (12, 0), (), "ActiveChannels", None),
		# Method 'ActiveHistoryBrushSource' returns object of type 'HistoryState'
		"ActiveHistoryBrushSource": (1145266802, 2, (9, 0), (), "ActiveHistoryBrushSource", '{EDC373C3-FE30-40BA-A31C-0251CA7456F1}'),
		# Method 'ActiveHistoryState' returns object of type 'HistoryState'
		"ActiveHistoryState": (1145268339, 2, (9, 0), (), "ActiveHistoryState", '{EDC373C3-FE30-40BA-A31C-0251CA7456F1}'),
		"ActiveLayer": (1668435058, 2, (9, 0), (), "ActiveLayer", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		# Method 'ArtLayers' returns object of type 'ArtLayers'
		"ArtLayers": (1665354866, 2, (9, 0), (), "ArtLayers", '{EC6A366C-F901-488D-A2C3-9E2E78B72DC6}'),
		# Method 'BackgroundLayer' returns object of type 'ArtLayer'
		"BackgroundLayer": (1147292786, 2, (9, 0), (), "BackgroundLayer", '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}'),
		"BitsPerChannel": (1145201512, 2, (3, 0), (), "BitsPerChannel", None),
		# Method 'Channels' returns object of type 'Channels'
		"Channels": (1665353838, 2, (9, 0), (), "Channels", '{2DC64F97-8C69-4016-A8EB-89A00217291F}'),
		"ColorProfileName": (1147367502, 2, (8, 0), (), "ColorProfileName", None),
		"ColorProfileType": (1147367508, 2, (3, 0), (), "ColorProfileType", None),
		# Method 'ColorSamplers' returns object of type 'ColorSamplers'
		"ColorSamplers": (1129534256, 2, (9, 0), (), "ColorSamplers", '{97C81476-3F5D-4934-8CAA-1ED0242105B0}'),
		"ComponentChannels": (1128493171, 2, (12, 0), (), "ComponentChannels", None),
		# Method 'CountItems' returns object of type 'CountItems'
		"CountItems": (1129590835, 2, (9, 0), (), "CountItems", '{9E01C1DA-DF69-4C2C-85EC-616370DF1CF0}'),
		"FullName": (1148220520, 2, (8, 0), (), "FullName", None),
		"Height": (1214736500, 2, (5, 0), (), "Height", None),
		"Histogram": (1214870388, 2, (12, 0), (), "Histogram", None),
		# Method 'HistoryStates' returns object of type 'HistoryStates'
		"HistoryStates": (1665692532, 2, (9, 0), (), "HistoryStates", '{69172A3F-E06E-42E6-B733-4DC36E2AC948}'),
		# Method 'Info' returns object of type 'DocumentInfo'
		"Info": (1147760230, 2, (9, 0), (), "Info", '{746FEF90-A182-4BD0-A4F6-BB6BBAE87A78}'),
		# Method 'LayerComps' returns object of type 'LayerComps'
		"LayerComps": (1279471665, 2, (9, 0), (), "LayerComps", '{726B458C-74B0-47AE-B390-99753B55DF2E}'),
		# Method 'LayerSets' returns object of type 'LayerSets'
		"LayerSets": (1665948276, 2, (9, 0), (), "LayerSets", '{323DD2BC-0205-4A44-9F8E-0CF2556F00DF}'),
		# Method 'Layers' returns object of type 'Layers'
		"Layers": (1665956210, 2, (9, 0), (), "Layers", '{DDA16C46-15B2-472D-A659-41AA7BFDC4FD}'),
		"Managed": (1682794340, 2, (11, 0), (), "Managed", None),
		# Method 'MeasurementScale' returns object of type 'MeasurementScale'
		"MeasurementScale": (1666012003, 2, (9, 0), (), "MeasurementScale", '{632F36B3-1D76-48BE-ADC3-D7FB62A0C2FB}'),
		"Mode": (1330472037, 2, (3, 0), (), "Mode", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Path": (1146123368, 2, (8, 0), (), "Path", None),
		# Method 'PathItems' returns object of type 'PathItems'
		"PathItems": (1347694643, 2, (9, 0), (), "PathItems", '{91B5F8AE-3CC5-4775-BCD3-FF1E0724BB01}'),
		"PixelAspectRatio": (1147744822, 2, (5, 0), (), "PixelAspectRatio", None),
		"QuickMaskMode": (1364020580, 2, (11, 0), (), "QuickMaskMode", None),
		"Resolution": (1382380364, 2, (5, 0), (), "Resolution", None),
		"Saved": (1146320484, 2, (11, 0), (), "Saved", None),
		# Method 'Selection' returns object of type 'Selection'
		"Selection": (1936026725, 2, (9, 0), (), "Selection", '{09DA6B10-9684-44EE-A575-01F54660BDDC}'),
		"Width": (1466201192, 2, (5, 0), (), "Width", None),
		# Method 'XMPMetadata' returns object of type 'XMPMetadata'
		"XMPMetadata": (1666731364, 2, (9, 0), (), "XMPMetadata", '{DC865034-A587-4CC4-8A5A-453032562BE4}'),
		"id": (1229201440, 2, (3, 0), (), "id", None),
	}
	_prop_map_put_ = {
		"ActiveChannels": ((1145269868, LCID, 4, 0),()),
		"ActiveHistoryBrushSource": ((1145266802, LCID, 4, 0),()),
		"ActiveHistoryState": ((1145268339, LCID, 4, 0),()),
		"ActiveLayer": ((1668435058, LCID, 4, 0),()),
		"BitsPerChannel": ((1145201512, LCID, 4, 0),()),
		"ColorProfileName": ((1147367502, LCID, 4, 0),()),
		"ColorProfileType": ((1147367508, LCID, 4, 0),()),
		"PixelAspectRatio": ((1147744822, LCID, 4, 0),()),
		"QuickMaskMode": ((1364020580, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class DocumentInfo(DispatchBaseClass):
	'Document information'
	CLSID = IID('{746FEF90-A182-4BD0-A4F6-BB6BBAE87A78}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Author": (1147744817, 2, (8, 0), (), "Author", None),
		"AuthorPosition": (1147744819, 2, (8, 0), (), "AuthorPosition", None),
		"Caption": (1147744305, 2, (8, 0), (), "Caption", None),
		"CaptionWriter": (1147744306, 2, (8, 0), (), "CaptionWriter", None),
		"Category": (1147744310, 2, (8, 0), (), "Category", None),
		"City": (1147744565, 2, (8, 0), (), "City", None),
		"CopyrightNotice": (1147744816, 2, (8, 0), (), "CopyrightNotice", None),
		"Copyrighted": (1147744569, 2, (3, 0), (), "Copyrighted", None),
		"Country": (1147744567, 2, (8, 0), (), "Country", None),
		"CreationDate": (1147744564, 2, (8, 0), (), "CreationDate", None),
		"Credit": (1147744561, 2, (8, 0), (), "Credit", None),
		"EXIF": (1147744821, 2, (12, 0), (), "EXIF", None),
		"Headline": (1147744307, 2, (8, 0), (), "Headline", None),
		"Instructions": (1147744308, 2, (8, 0), (), "Instructions", None),
		"JobName": (1147744820, 2, (8, 0), (), "JobName", None),
		"Keywords": (1147744309, 2, (12, 0), (), "Keywords", None),
		"OwnerUrl": (1884648044, 2, (8, 0), (), "OwnerUrl", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"ProvinceState": (1147744566, 2, (8, 0), (), "ProvinceState", None),
		"Source": (1147744562, 2, (8, 0), (), "Source", None),
		"SupplementalCategories": (1147744311, 2, (12, 0), (), "SupplementalCategories", None),
		"Title": (1147744818, 2, (8, 0), (), "Title", None),
		"TransmissionReference": (1147744568, 2, (8, 0), (), "TransmissionReference", None),
		"Urgency": (1147744312, 2, (3, 0), (), "Urgency", None),
	}
	_prop_map_put_ = {
		"Author": ((1147744817, LCID, 4, 0),()),
		"AuthorPosition": ((1147744819, LCID, 4, 0),()),
		"Caption": ((1147744305, LCID, 4, 0),()),
		"CaptionWriter": ((1147744306, LCID, 4, 0),()),
		"Category": ((1147744310, LCID, 4, 0),()),
		"City": ((1147744565, LCID, 4, 0),()),
		"CopyrightNotice": ((1147744816, LCID, 4, 0),()),
		"Copyrighted": ((1147744569, LCID, 4, 0),()),
		"Country": ((1147744567, LCID, 4, 0),()),
		"CreationDate": ((1147744564, LCID, 4, 0),()),
		"Credit": ((1147744561, LCID, 4, 0),()),
		"Headline": ((1147744307, LCID, 4, 0),()),
		"Instructions": ((1147744308, LCID, 4, 0),()),
		"JobName": ((1147744820, LCID, 4, 0),()),
		"Keywords": ((1147744309, LCID, 4, 0),()),
		"OwnerUrl": ((1884648044, LCID, 4, 0),()),
		"ProvinceState": ((1147744566, LCID, 4, 0),()),
		"Source": ((1147744562, LCID, 4, 0),()),
		"SupplementalCategories": ((1147744311, LCID, 4, 0),()),
		"Title": ((1147744818, LCID, 4, 0),()),
		"TransmissionReference": ((1147744568, LCID, 4, 0),()),
		"Urgency": ((1147744312, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class Documents(DispatchBaseClass):
	'A collection of documents'
	CLSID = IID('{662506C7-6AAE-4422-ACA4-C63627CB1868}')
	coclass_clsid = None

	# Result is of type Document
	def Add(self, Width=defaultNamedOptArg, Height=defaultNamedOptArg, Resolution=defaultNamedOptArg, Name=defaultNamedOptArg
			, Mode=defaultNamedOptArg, InitialFill=defaultNamedOptArg, PixelAspectRatio=defaultNamedOptArg, BitsPerChannel=defaultNamedOptArg, ColorProfileName=defaultNamedOptArg):
		'a document'
		ret = self._oleobj_.InvokeTypes(1685021557, LCID, 1, (9, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),Width
			, Height, Resolution, Name, Mode, InitialFill
			, PixelAspectRatio, BitsPerChannel, ColorProfileName)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type Document
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
		return ret

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{B1ADEFB6-C536-42D6-8A83-397354A769F8}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class HistoryState(DispatchBaseClass):
	'A history state for the document'
	CLSID = IID('{EDC373C3-FE30-40BA-A31C-0251CA7456F1}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Snapshot": (1213425780, 2, (11, 0), (), "Snapshot", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class HistoryStates(DispatchBaseClass):
	'History states associated with the document'
	CLSID = IID('{69172A3F-E06E-42E6-B733-4DC36E2AC948}')
	coclass_clsid = None

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type HistoryState
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{EDC373C3-FE30-40BA-A31C-0251CA7456F1}')
		return ret

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{EDC373C3-FE30-40BA-A31C-0251CA7456F1}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{EDC373C3-FE30-40BA-A31C-0251CA7456F1}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class LayerComp(DispatchBaseClass):
	'A layer composition in a document'
	CLSID = IID('{9A37A0AC-E951-4B16-A548-886B77338DE0}')
	coclass_clsid = None

	def Apply(self):
		'apply the layer comp to the document'
		return self._oleobj_.InvokeTypes(1346842673, LCID, 1, (24, 0), (),)

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	def Recapture(self):
		'recapture the current layer state(s) for this layer comp'
		return self._oleobj_.InvokeTypes(1346842674, LCID, 1, (24, 0), (),)

	def ResetFromComp(self):
		'reset the layer comp state to the document state'
		return self._oleobj_.InvokeTypes(1346844210, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		"Appearance": (1279471667, 2, (11, 0), (), "Appearance", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Comment": (1279471666, 2, (12, 0), (), "Comment", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Position": (1332897646, 2, (11, 0), (), "Position", None),
		"Selected": (1279471670, 2, (11, 0), (), "Selected", None),
		"Visibility": (1279471669, 2, (11, 0), (), "Visibility", None),
	}
	_prop_map_put_ = {
		"Appearance": ((1279471667, LCID, 4, 0),()),
		"Comment": ((1279471666, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
		"Position": ((1332897646, LCID, 4, 0),()),
		"Visibility": ((1279471669, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class LayerComps(DispatchBaseClass):
	'Layer compositions associated with the document'
	CLSID = IID('{726B458C-74B0-47AE-B390-99753B55DF2E}')
	coclass_clsid = None

	# Result is of type LayerComp
	def Add(self, Name=defaultNamedNotOptArg, Comment=defaultNamedOptArg, Appearance=defaultNamedOptArg, Position=defaultNamedOptArg
			, Visibility=defaultNamedOptArg):
		'a layer comp'
		ret = self._oleobj_.InvokeTypes(1279471665, LCID, 1, (9, 0), ((8, 1), (12, 17), (12, 17), (12, 17), (12, 17)),Name
			, Comment, Appearance, Position, Visibility)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{9A37A0AC-E951-4B16-A548-886B77338DE0}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type LayerComp
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{9A37A0AC-E951-4B16-A548-886B77338DE0}')
		return ret

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{9A37A0AC-E951-4B16-A548-886B77338DE0}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{9A37A0AC-E951-4B16-A548-886B77338DE0}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class LayerSet(DispatchBaseClass):
	'Layer set'
	CLSID = IID('{C1C35524-2AA4-4630-80B9-011EFE3D5779}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	def Duplicate(self, RelativeObject=defaultNamedOptArg, InsertionLocation=defaultNamedOptArg):
		'create a duplicate of the object'
		ret = self._oleobj_.InvokeTypes(1668050798, LCID, 1, (9, 0), ((12, 17), (12, 17)),RelativeObject
			, InsertionLocation)
		if ret is not None:
			ret = Dispatch(ret, 'Duplicate', None)
		return ret

	def Link(self, With=defaultNamedNotOptArg):
		'link the layer with another layer'
		return self._oleobj_.InvokeTypes(1818973295, LCID, 1, (24, 0), ((9, 1),),With
			)

	# Result is of type ArtLayer
	def Merge(self):
		'merge layerset. Returns a reference to the art layer that is created by this method'
		ret = self._oleobj_.InvokeTypes(1298615386, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'Merge', '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}')
		return ret

	def Move(self, RelativeObject=defaultNamedNotOptArg, InsertionLocation=defaultNamedNotOptArg):
		'move the object'
		return self._oleobj_.InvokeTypes(1836021349, LCID, 1, (24, 0), ((9, 1), (3, 1)),RelativeObject
			, InsertionLocation)

	def MoveAfter(self, RelativeObject=defaultNamedNotOptArg):
		'Move the PageItem in behind object'
		return self._oleobj_.InvokeTypes(1299596641, LCID, 1, (24, 0), ((9, 1),),RelativeObject
			)

	def MoveBefore(self, RelativeObject=defaultNamedNotOptArg):
		'Move the PageItem in front of object'
		return self._oleobj_.InvokeTypes(1299596642, LCID, 1, (24, 0), ((9, 1),),RelativeObject
			)

	def MoveToBeginning(self, Container=defaultNamedNotOptArg):
		'Move the PageItem to beginning of container'
		return self._oleobj_.InvokeTypes(1299596646, LCID, 1, (24, 0), ((9, 1),),Container
			)

	def MoveToEnd(self, Container=defaultNamedNotOptArg):
		'Move the PageItem to end of container'
		return self._oleobj_.InvokeTypes(1299596645, LCID, 1, (24, 0), ((9, 1),),Container
			)

	def Resize(self, Horizontal=defaultNamedOptArg, Vertical=defaultNamedOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1399024741, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Horizontal
			, Vertical, Anchor)

	def Rotate(self, Angle=defaultNamedNotOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1383036001, LCID, 1, (24, 0), ((5, 1), (12, 17)),Angle
			, Anchor)

	def Translate(self, DeltaX=defaultNamedOptArg, DeltaY=defaultNamedOptArg):
		'moves the position relative to its current position'
		return self._oleobj_.InvokeTypes(1299599475, LCID, 1, (24, 0), ((12, 17), (12, 17)),DeltaX
			, DeltaY)

	def Unlink(self):
		'unlink the layer'
		return self._oleobj_.InvokeTypes(1433169515, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		"AllLocked": (1097616483, 2, (11, 0), (), "AllLocked", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		# Method 'ArtLayer' returns object of type 'ArtLayer'
		"ArtLayer": (1279358028, 2, (9, 0), (), "ArtLayer", '{16BE80A3-57B1-4871-83AC-7F844EEEB1CA}'),
		# Method 'ArtLayers' returns object of type 'ArtLayers'
		"ArtLayers": (1665354866, 2, (9, 0), (), "ArtLayers", '{EC6A366C-F901-488D-A2C3-9E2E78B72DC6}'),
		"BlendMode": (1114393956, 2, (3, 0), (), "BlendMode", None),
		"Bounds": (1114530931, 2, (12, 0), (), "Bounds", None),
		"EnabledChannels": (1164854120, 2, (12, 0), (), "EnabledChannels", None),
		"ItemIndex": (1886603640, 2, (3, 0), (), "ItemIndex", None),
		"Layer": (1396927603, 2, (9, 0), (), "Layer", None),
		# Method 'LayerSet' returns object of type 'LayerSet'
		"LayerSet": (1279358042, 2, (9, 0), (), "LayerSet", '{C1C35524-2AA4-4630-80B9-011EFE3D5779}'),
		# Method 'LayerSets' returns object of type 'LayerSets'
		"LayerSets": (1665948276, 2, (9, 0), (), "LayerSets", '{323DD2BC-0205-4A44-9F8E-0CF2556F00DF}'),
		"LayerType": (1954115685, 2, (3, 0), (), "LayerType", None),
		# Method 'Layers' returns object of type 'Layers'
		"Layers": (1665956210, 2, (9, 0), (), "Layers", '{DDA16C46-15B2-472D-A659-41AA7BFDC4FD}'),
		"LinkedLayers": (1282106724, 2, (12, 0), (), "LinkedLayers", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Opacity": (1332765556, 2, (5, 0), (), "Opacity", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Visible": (1884705634, 2, (11, 0), (), "Visible", None),
		"id": (1229201440, 2, (3, 0), (), "id", None),
	}
	_prop_map_put_ = {
		"AllLocked": ((1097616483, LCID, 4, 0),()),
		"BlendMode": ((1114393956, LCID, 4, 0),()),
		"EnabledChannels": ((1164854120, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
		"Opacity": ((1332765556, LCID, 4, 0),()),
		"Visible": ((1884705634, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class LayerSets(DispatchBaseClass):
	CLSID = IID('{323DD2BC-0205-4A44-9F8E-0CF2556F00DF}')
	coclass_clsid = None

	# Result is of type LayerSet
	def Add(self):
		'create a new object'
		ret = self._oleobj_.InvokeTypes(1665948266, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{C1C35524-2AA4-4630-80B9-011EFE3D5779}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type LayerSet
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{C1C35524-2AA4-4630-80B9-011EFE3D5779}')
		return ret

	def Remove(self, Item=defaultNamedNotOptArg):
		'Delete an element from the collection'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), ((9, 1),),Item
			)

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{C1C35524-2AA4-4630-80B9-011EFE3D5779}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{C1C35524-2AA4-4630-80B9-011EFE3D5779}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class Layers(DispatchBaseClass):
	CLSID = IID('{DDA16C46-15B2-472D-A659-41AA7BFDC4FD}')
	coclass_clsid = None

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', None)
		return ret

	def Remove(self, Item=defaultNamedNotOptArg):
		'Delete an element from the collection'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), ((9, 1),),Item
			)

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', None)
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class MeasurementLog(DispatchBaseClass):
	'the log of measurements taken'
	CLSID = IID('{84ADBF06-8354-4B5C-9CB1-EA2565B66C7C}')
	coclass_clsid = None

	def DeleteMeasurements(self, Range=defaultNamedOptArg):
		'delete measurements'
		return self._oleobj_.InvokeTypes(1296838710, LCID, 1, (24, 0), ((12, 17),),Range
			)

	def ExportMeasurements(self, File=defaultNamedNotOptArg, Range=defaultNamedOptArg, DataPoints=defaultNamedOptArg):
		'export measurements'
		return self._oleobj_.InvokeTypes(1296838709, LCID, 1, (24, 0), ((8, 1), (12, 17), (12, 17)),File
			, Range, DataPoints)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class MeasurementScale(DispatchBaseClass):
	'Document Measurement Scale'
	CLSID = IID('{632F36B3-1D76-48BE-ADC3-D7FB62A0C2FB}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"LogicalLength": (1836280940, 2, (5, 0), (), "LogicalLength", None),
		"LogicalUnits": (1836280949, 2, (8, 0), (), "LogicalUnits", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"PixelLength": (1836281964, 2, (3, 0), (), "PixelLength", None),
	}
	_prop_map_put_ = {
		"LogicalLength": ((1836280940, LCID, 4, 0),()),
		"LogicalUnits": ((1836280949, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
		"PixelLength": ((1836281964, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class Notifier(DispatchBaseClass):
	'The parameters of the notifie'
	CLSID = IID('{8B4F1F1E-4ED7-4291-AE61-76ADF4D1D50B}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Event": (1162752052, 2, (8, 0), (), "Event", None),
		"EventClass": (1162752055, 2, (8, 0), (), "EventClass", None),
		"EventFile": (1162752053, 2, (8, 0), (), "EventFile", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class Notifiers(DispatchBaseClass):
	'A collection of notifiers'
	CLSID = IID('{861C9290-2A0C-4614-8606-706B31BFD45B}')
	coclass_clsid = None

	# Result is of type Notifier
	def Add(self, Event=defaultNamedNotOptArg, EventFile=defaultNamedNotOptArg, EventClass=defaultNamedOptArg):
		'a notifier'
		ret = self._oleobj_.InvokeTypes(1162752050, LCID, 1, (9, 0), ((8, 1), (8, 1), (12, 17)),Event
			, EventFile, EventClass)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{8B4F1F1E-4ED7-4291-AE61-76ADF4D1D50B}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type Notifier
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{8B4F1F1E-4ED7-4291-AE61-76ADF4D1D50B}')
		return ret

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{8B4F1F1E-4ED7-4291-AE61-76ADF4D1D50B}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{8B4F1F1E-4ED7-4291-AE61-76ADF4D1D50B}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class PathItem(DispatchBaseClass):
	'An artwork path item'
	CLSID = IID('{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
	coclass_clsid = None

	def Delete(self):
		'delete the object'
		return self._oleobj_.InvokeTypes(1684368495, LCID, 1, (24, 0), (),)

	def Deselect(self):
		'unselect this path item, no paths items are selected'
		return self._oleobj_.InvokeTypes(1148415092, LCID, 1, (24, 0), (),)

	# Result is of type PathItem
	def Duplicate(self, Name=defaultNamedOptArg):
		'duplicate this path'
		ret = self._oleobj_.InvokeTypes(1668050798, LCID, 1, (9, 0), ((12, 17),),Name
			)
		if ret is not None:
			ret = Dispatch(ret, 'Duplicate', '{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
		return ret

	def FillPath(self, FillColor=defaultNamedOptArg, Mode=defaultNamedOptArg, Opacity=defaultNamedOptArg, PreserveTransparency=defaultNamedOptArg
			, Feather=defaultNamedOptArg, AntiAlias=defaultNamedOptArg, WholePath=defaultNamedOptArg):
		'fill the path with the following information'
		return self._oleobj_.InvokeTypes(1347694900, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17), (12, 17)),FillColor
			, Mode, Opacity, PreserveTransparency, Feather, AntiAlias
			, WholePath)

	def MakeClippingPath(self, Flatness=defaultNamedOptArg):
		'make this path item the clipping path for this document'
		return self._oleobj_.InvokeTypes(1347694903, LCID, 1, (24, 0), ((12, 17),),Flatness
			)

	def MakeSelection(self, Feather=defaultNamedOptArg, AntiAlias=defaultNamedOptArg, Operation=defaultNamedOptArg):
		'make a selection from this path'
		return self._oleobj_.InvokeTypes(1347694899, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Feather
			, AntiAlias, Operation)

	def Select(self):
		'make this path item the active or selected path item'
		return self._oleobj_.InvokeTypes(1936483188, LCID, 1, (24, 0), (),)

	def StrokePath(self, Tool=defaultNamedOptArg, SimulatePressure=defaultNamedOptArg):
		'stroke the path with the following information'
		return self._oleobj_.InvokeTypes(1347694901, LCID, 1, (24, 0), ((12, 17), (12, 17)),Tool
			, SimulatePressure)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Kind": (1265200740, 2, (3, 0), (), "Kind", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		# Method 'SubPathItems' returns object of type 'SubPathItems'
		"SubPathItems": (1347695667, 2, (9, 0), (), "SubPathItems", '{B7283EEC-23B1-49A6-B151-0E97E4AF353C}'),
	}
	_prop_map_put_ = {
		"Kind": ((1265200740, LCID, 4, 0),()),
		"Name": ((1886282093, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class PathItems(DispatchBaseClass):
	'art paths associated with this document'
	CLSID = IID('{91B5F8AE-3CC5-4775-BCD3-FF1E0724BB01}')
	coclass_clsid = None

	# Result is of type PathItem
	def Add(self, Name=defaultNamedNotOptArg, EntirePath=defaultNamedNotOptArg):
		'create a new path item'
		ret = self._oleobj_.InvokeTypes(1347694643, LCID, 1, (9, 0), ((8, 1), (12, 1)),Name
			, EntirePath)
		if ret is not None:
			ret = Dispatch(ret, 'Add', '{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
		return ret

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type PathItem
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
		return ret

	def RemoveAll(self):
		return self._oleobj_.InvokeTypes(1380009324, LCID, 1, (24, 0), (),)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{8B0CB532-4ACC-4BF3-9E42-0949B679D120}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class PathPoint(DispatchBaseClass):
	'A point on a path'
	CLSID = IID('{7D14BA29-1672-482F-8F48-9DA1E94800FD}')
	coclass_clsid = None

	_prop_map_get_ = {
		"Anchor": (1347694904, 2, (12, 0), (), "Anchor", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Kind": (1265200740, 2, (3, 0), (), "Kind", None),
		"LeftDirection": (1347694905, 2, (12, 0), (), "LeftDirection", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"RightDirection": (1347695152, 2, (12, 0), (), "RightDirection", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class PathPoints(DispatchBaseClass):
	'A collection of path points'
	CLSID = IID('{8214A53C-0E67-49D4-A65A-D56F07B17D37}')
	coclass_clsid = None

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type PathPoint
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{7D14BA29-1672-482F-8F48-9DA1E94800FD}')
		return ret

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{7D14BA29-1672-482F-8F48-9DA1E94800FD}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{7D14BA29-1672-482F-8F48-9DA1E94800FD}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class Preferences(DispatchBaseClass):
	'Preferences for Photoshop'
	CLSID = IID('{288BC58E-AB6A-467C-B244-D225349E3EB3}')
	coclass_clsid = None

	_prop_map_get_ = {
		"AdditionalPluginFolder": (1349661493, 2, (8, 0), (), "AdditionalPluginFolder", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"AskBeforeSavingLayeredTIFF": (1349660980, 2, (11, 0), (), "AskBeforeSavingLayeredTIFF", None),
		"AutoUpdateOpenDocuments": (1349660724, 2, (11, 0), (), "AutoUpdateOpenDocuments", None),
		"BeepWhenDone": (1349660726, 2, (11, 0), (), "BeepWhenDone", None),
		"ColorChannelsInColor": (1349660982, 2, (11, 0), (), "ColorChannelsInColor", None),
		"ColorPicker": (1129343858, 2, (3, 0), (), "ColorPicker", None),
		"ColumnGutter": (1349661240, 2, (5, 0), (), "ColumnGutter", None),
		"ColumnWidth": (1349661239, 2, (5, 0), (), "ColumnWidth", None),
		"CreateFirstSnapshot": (1349661497, 2, (11, 0), (), "CreateFirstSnapshot", None),
		"DynamicColorSliders": (1349660727, 2, (11, 0), (), "DynamicColorSliders", None),
		"EditLogItems": (1349661751, 2, (3, 0), (), "EditLogItems", None),
		"ExportClipboard": (1349660721, 2, (11, 0), (), "ExportClipboard", None),
		"FontPreviewSize": (1179660340, 2, (3, 0), (), "FontPreviewSize", None),
		"GamutWarningOpacity": (1349661236, 2, (5, 0), (), "GamutWarningOpacity", None),
		"GridSize": (1349661233, 2, (3, 0), (), "GridSize", None),
		"GridStyle": (1349661489, 2, (3, 0), (), "GridStyle", None),
		"GridSubDivisions": (1349661491, 2, (3, 0), (), "GridSubDivisions", None),
		"GuideStyle": (1349661488, 2, (3, 0), (), "GuideStyle", None),
		"ImageCacheForHistograms": (1349661496, 2, (11, 0), (), "ImageCacheForHistograms", None),
		"ImageCacheLevels": (1349661495, 2, (3, 0), (), "ImageCacheLevels", None),
		"ImagePreviews": (1349660978, 2, (3, 0), (), "ImagePreviews", None),
		"Interpolation": (1232104545, 2, (3, 0), (), "Interpolation", None),
		"KeyboardZoomResizesWindows": (1349661747, 2, (11, 0), (), "KeyboardZoomResizesWindows", None),
		"MaxRAMuse": (1349661748, 2, (3, 0), (), "MaxRAMuse", None),
		"MaximizeCompatibility": (1884125251, 2, (3, 0), (), "MaximizeCompatibility", None),
		"NonLinearHistory": (1349661744, 2, (11, 0), (), "NonLinearHistory", None),
		"NumberOfHistoryStates": (1349660977, 2, (3, 0), (), "NumberOfHistoryStates", None),
		"OtherCursors": (1349661232, 2, (3, 0), (), "OtherCursors", None),
		"PaintingCursors": (1349660985, 2, (3, 0), (), "PaintingCursors", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"PixelDoubling": (1349660984, 2, (11, 0), (), "PixelDoubling", None),
		"PointSize": (1349661241, 2, (3, 0), (), "PointSize", None),
		"RecentFileListLength": (1349660981, 2, (3, 0), (), "RecentFileListLength", None),
		"RulerUnits": (1349661237, 2, (3, 0), (), "RulerUnits", None),
		"SaveLogItems": (1349661750, 2, (3, 0), (), "SaveLogItems", None),
		"SaveLogItemsFile": (1349661752, 2, (8, 0), (), "SaveLogItemsFile", None),
		"SavePaletteLocations": (1349660728, 2, (11, 0), (), "SavePaletteLocations", None),
		"ShowAsianTextOptions": (1349660725, 2, (11, 0), (), "ShowAsianTextOptions", None),
		"ShowEnglishFontNames": (1349660729, 2, (11, 0), (), "ShowEnglishFontNames", None),
		"ShowSliceNumber": (1349661492, 2, (11, 0), (), "ShowSliceNumber", None),
		"ShowToolTips": (1349660723, 2, (11, 0), (), "ShowToolTips", None),
		"SmartQuotes": (1349661745, 2, (11, 0), (), "SmartQuotes", None),
		"TypeUnits": (1349661238, 2, (3, 0), (), "TypeUnits", None),
		"UseAdditionalPluginFolder": (1349661746, 2, (11, 0), (), "UseAdditionalPluginFolder", None),
		"UseDiffusionDither": (1349660983, 2, (11, 0), (), "UseDiffusionDither", None),
		"UseHistoryLog": (1349661749, 2, (11, 0), (), "UseHistoryLog", None),
		"UseLowerCaseExtension": (1884507235, 2, (11, 0), (), "UseLowerCaseExtension", None),
		"UseShiftKeyForToolSwitch": (1349660976, 2, (11, 0), (), "UseShiftKeyForToolSwitch", None),
		"UseVideoAlpha": (1349661235, 2, (11, 0), (), "UseVideoAlpha", None),
	}
	_prop_map_put_ = {
		"AdditionalPluginFolder": ((1349661493, LCID, 4, 0),()),
		"AskBeforeSavingLayeredTIFF": ((1349660980, LCID, 4, 0),()),
		"AutoUpdateOpenDocuments": ((1349660724, LCID, 4, 0),()),
		"BeepWhenDone": ((1349660726, LCID, 4, 0),()),
		"ColorChannelsInColor": ((1349660982, LCID, 4, 0),()),
		"ColorPicker": ((1129343858, LCID, 4, 0),()),
		"ColumnGutter": ((1349661240, LCID, 4, 0),()),
		"ColumnWidth": ((1349661239, LCID, 4, 0),()),
		"CreateFirstSnapshot": ((1349661497, LCID, 4, 0),()),
		"DynamicColorSliders": ((1349660727, LCID, 4, 0),()),
		"EditLogItems": ((1349661751, LCID, 4, 0),()),
		"ExportClipboard": ((1349660721, LCID, 4, 0),()),
		"FontPreviewSize": ((1179660340, LCID, 4, 0),()),
		"GamutWarningOpacity": ((1349661236, LCID, 4, 0),()),
		"GridSize": ((1349661233, LCID, 4, 0),()),
		"GridStyle": ((1349661489, LCID, 4, 0),()),
		"GridSubDivisions": ((1349661491, LCID, 4, 0),()),
		"GuideStyle": ((1349661488, LCID, 4, 0),()),
		"ImageCacheForHistograms": ((1349661496, LCID, 4, 0),()),
		"ImageCacheLevels": ((1349661495, LCID, 4, 0),()),
		"ImagePreviews": ((1349660978, LCID, 4, 0),()),
		"Interpolation": ((1232104545, LCID, 4, 0),()),
		"KeyboardZoomResizesWindows": ((1349661747, LCID, 4, 0),()),
		"MaxRAMuse": ((1349661748, LCID, 4, 0),()),
		"MaximizeCompatibility": ((1884125251, LCID, 4, 0),()),
		"NonLinearHistory": ((1349661744, LCID, 4, 0),()),
		"NumberOfHistoryStates": ((1349660977, LCID, 4, 0),()),
		"OtherCursors": ((1349661232, LCID, 4, 0),()),
		"PaintingCursors": ((1349660985, LCID, 4, 0),()),
		"PixelDoubling": ((1349660984, LCID, 4, 0),()),
		"PointSize": ((1349661241, LCID, 4, 0),()),
		"RecentFileListLength": ((1349660981, LCID, 4, 0),()),
		"RulerUnits": ((1349661237, LCID, 4, 0),()),
		"SaveLogItems": ((1349661750, LCID, 4, 0),()),
		"SaveLogItemsFile": ((1349661752, LCID, 4, 0),()),
		"SavePaletteLocations": ((1349660728, LCID, 4, 0),()),
		"ShowAsianTextOptions": ((1349660725, LCID, 4, 0),()),
		"ShowEnglishFontNames": ((1349660729, LCID, 4, 0),()),
		"ShowSliceNumber": ((1349661492, LCID, 4, 0),()),
		"ShowToolTips": ((1349660723, LCID, 4, 0),()),
		"SmartQuotes": ((1349661745, LCID, 4, 0),()),
		"TypeUnits": ((1349661238, LCID, 4, 0),()),
		"UseAdditionalPluginFolder": ((1349661746, LCID, 4, 0),()),
		"UseDiffusionDither": ((1349660983, LCID, 4, 0),()),
		"UseHistoryLog": ((1349661749, LCID, 4, 0),()),
		"UseLowerCaseExtension": ((1884507235, LCID, 4, 0),()),
		"UseShiftKeyForToolSwitch": ((1349660976, LCID, 4, 0),()),
		"UseVideoAlpha": ((1349661235, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class Selection(DispatchBaseClass):
	'The selection of the document'
	CLSID = IID('{09DA6B10-9684-44EE-A575-01F54660BDDC}')
	coclass_clsid = None

	def Clear(self):
		'clear selection'
		return self._oleobj_.InvokeTypes(1296117809, LCID, 1, (24, 0), (),)

	def Contract(self, By=defaultNamedNotOptArg):
		'contracts the selection'
		return self._oleobj_.InvokeTypes(1396929650, LCID, 1, (24, 0), ((5, 1),),By
			)

	def Copy(self, Merge=defaultNamedOptArg):
		'copy selection to the clipboard'
		return self._oleobj_.InvokeTypes(1668247673, LCID, 1, (24, 0), ((12, 17),),Merge
			)

	def Cut(self):
		'cut current selection to the clipboard'
		return self._oleobj_.InvokeTypes(1668641824, LCID, 1, (24, 0), (),)

	def Deselect(self):
		return self._oleobj_.InvokeTypes(1148415092, LCID, 1, (24, 0), (),)

	def Expand(self, By=defaultNamedNotOptArg):
		'expand selection'
		return self._oleobj_.InvokeTypes(1483763300, LCID, 1, (24, 0), ((5, 1),),By
			)

	def Feather(self, By=defaultNamedNotOptArg):
		'feather edges of selection'
		return self._oleobj_.InvokeTypes(1182034034, LCID, 1, (24, 0), ((5, 1),),By
			)

	def Fill(self, FillType=defaultNamedNotOptArg, Mode=defaultNamedOptArg, Opacity=defaultNamedOptArg, PreserveTransparency=defaultNamedOptArg):
		'fills the selection'
		return self._oleobj_.InvokeTypes(1181314156, LCID, 1, (24, 0), ((12, 1), (12, 17), (12, 17), (12, 17)),FillType
			, Mode, Opacity, PreserveTransparency)

	def Grow(self, Tolerance=defaultNamedNotOptArg, AntiAlias=defaultNamedNotOptArg):
		'grow selection to include all adjacent pixels falling within the specified tolerance range'
		return self._oleobj_.InvokeTypes(1198681975, LCID, 1, (24, 0), ((3, 1), (11, 1)),Tolerance
			, AntiAlias)

	def Invert(self):
		'invert the selection'
		return self._oleobj_.InvokeTypes(1232491372, LCID, 1, (24, 0), (),)

	def Load(self, From=defaultNamedNotOptArg, Combination=defaultNamedOptArg, Inverting=defaultNamedOptArg):
		'load the selection from a channel'
		return self._oleobj_.InvokeTypes(1281643372, LCID, 1, (24, 0), ((9, 1), (12, 17), (12, 17)),From
			, Combination, Inverting)

	def MakeWorkPath(self, Tolerance=defaultNamedOptArg):
		'make this selection item the work path for this document'
		return self._oleobj_.InvokeTypes(1347694902, LCID, 1, (24, 0), ((12, 17),),Tolerance
			)

	def Resize(self, Horizontal=defaultNamedOptArg, Vertical=defaultNamedOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1399024741, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Horizontal
			, Vertical, Anchor)

	def ResizeBoundary(self, Horizontal=defaultNamedOptArg, Vertical=defaultNamedOptArg, Anchor=defaultNamedOptArg):
		'scale the boundary of selection'
		return self._oleobj_.InvokeTypes(1399013988, LCID, 1, (24, 0), ((12, 17), (12, 17), (12, 17)),Horizontal
			, Vertical, Anchor)

	def Rotate(self, Angle=defaultNamedNotOptArg, Anchor=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1383036001, LCID, 1, (24, 0), ((5, 1), (12, 17)),Angle
			, Anchor)

	def RotateBoundary(self, Angle=defaultNamedNotOptArg, Anchor=defaultNamedOptArg):
		'rotates the boundary of selection'
		return self._oleobj_.InvokeTypes(1383035970, LCID, 1, (24, 0), ((5, 1), (12, 17)),Angle
			, Anchor)

	def Select(self, Region=defaultNamedNotOptArg, Type=defaultNamedOptArg, Feather=defaultNamedOptArg, AntiAlias=defaultNamedOptArg):
		return self._oleobj_.InvokeTypes(1936483188, LCID, 1, (24, 0), ((12, 1), (12, 17), (12, 17), (12, 17)),Region
			, Type, Feather, AntiAlias)

	def SelectAll(self):
		return self._oleobj_.InvokeTypes(1399013740, LCID, 1, (24, 0), (),)

	def SelectBorder(self, Width=defaultNamedNotOptArg):
		'select the border of the selection'
		return self._oleobj_.InvokeTypes(1114793074, LCID, 1, (24, 0), ((5, 1),),Width
			)

	def Similar(self, Tolerance=defaultNamedNotOptArg, AntiAlias=defaultNamedNotOptArg):
		'grow selection to include pixels throughout the image falling within the tolerance range'
		return self._oleobj_.InvokeTypes(1399680114, LCID, 1, (24, 0), ((3, 1), (11, 1)),Tolerance
			, AntiAlias)

	def Smooth(self, Radius=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1347646568, LCID, 1, (24, 0), ((3, 1),),Radius
			)

	def Store(self, Into=defaultNamedNotOptArg, Combination=defaultNamedOptArg):
		'save the selection as a channel'
		return self._oleobj_.InvokeTypes(1400263532, LCID, 1, (24, 0), ((9, 1), (12, 17)),Into
			, Combination)

	def Stroke(self, StrokeColor=defaultNamedNotOptArg, Width=defaultNamedNotOptArg, Location=defaultNamedOptArg, Mode=defaultNamedOptArg
			, Opacity=defaultNamedOptArg, PreserveTransparency=defaultNamedOptArg):
		'strokes the selection'
		return self._oleobj_.InvokeTypes(1400138597, LCID, 1, (24, 0), ((12, 1), (3, 1), (12, 17), (12, 17), (12, 17), (12, 17)),StrokeColor
			, Width, Location, Mode, Opacity, PreserveTransparency
			)

	def Translate(self, DeltaX=defaultNamedOptArg, DeltaY=defaultNamedOptArg):
		'moves the position relative to its current position'
		return self._oleobj_.InvokeTypes(1299599475, LCID, 1, (24, 0), ((12, 17), (12, 17)),DeltaX
			, DeltaY)

	def TranslateBoundary(self, DeltaX=defaultNamedOptArg, DeltaY=defaultNamedOptArg):
		'moves the boundary of selection relative to its current position'
		return self._oleobj_.InvokeTypes(1299595876, LCID, 1, (24, 0), ((12, 17), (12, 17)),DeltaX
			, DeltaY)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Bounds": (1114530931, 2, (12, 0), (), "Bounds", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Solid": (1399613796, 2, (11, 0), (), "Solid", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class SubPathItem(DispatchBaseClass):
	'An artwork sub path item'
	CLSID = IID('{B6D22EB9-EC6D-46DB-B52A-5561433A1217}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Closed": (1347695920, 2, (11, 0), (), "Closed", None),
		"Operation": (1347694647, 2, (3, 0), (), "Operation", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		# Method 'PathPoints' returns object of type 'PathPoints'
		"PathPoints": (1347694644, 2, (9, 0), (), "PathPoints", '{8214A53C-0E67-49D4-A65A-D56F07B17D37}'),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class SubPathItems(DispatchBaseClass):
	'art sub paths associated with the path item'
	CLSID = IID('{B7283EEC-23B1-49A6-B151-0E97E4AF353C}')
	coclass_clsid = None

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type SubPathItem
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{B6D22EB9-EC6D-46DB-B52A-5561433A1217}')
		return ret

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{B6D22EB9-EC6D-46DB-B52A-5561433A1217}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{B6D22EB9-EC6D-46DB-B52A-5561433A1217}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class TextFont(DispatchBaseClass):
	'An installed font'
	CLSID = IID('{C88838E3-5A82-4EE7-A66C-E0360C9B0356}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Family": (1883653710, 2, (8, 0), (), "Family", None),
		"Name": (1886282093, 2, (8, 0), (), "Name", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"PostScriptName": (1884312398, 2, (8, 0), (), "PostScriptName", None),
		"Style": (1400142188, 2, (8, 0), (), "Style", None),
	}
	_prop_map_put_ = {
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class TextFonts(DispatchBaseClass):
	'A collection of fonts'
	CLSID = IID('{BBCE52D6-5D4B-4691-99E3-62C174BD2855}')
	coclass_clsid = None

	def Index(self, ItemPtr=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1885955192, LCID, 1, (3, 0), ((9, 1),),ItemPtr
			)

	# Result is of type TextFont
	# The method Item is actually a property, but must be used as a method to correctly pass the arguments
	def Item(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, 'Item', '{C88838E3-5A82-4EE7-A66C-E0360C9B0356}')
		return ret

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1668183141, 2, (3, 0), (), "Count", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
	}
	_prop_map_put_ = {
	}
	# Default method for this class is 'Item'
	def __call__(self, ItemKey=defaultNamedNotOptArg):
		'get an element from the collection'
		ret = self._oleobj_.InvokeTypes(0, LCID, 2, (9, 0), ((12, 1),),ItemKey
			)
		if ret is not None:
			ret = Dispatch(ret, '__call__', '{C88838E3-5A82-4EE7-A66C-E0360C9B0356}')
		return ret

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,2,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, '{C88838E3-5A82-4EE7-A66C-E0360C9B0356}')
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1668183141, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class TextItem(DispatchBaseClass):
	'Text object contained in an art layer'
	CLSID = IID('{E7A940CD-9AC7-4D76-975D-24D6BA0FDD16}')
	coclass_clsid = None

	def ConvertToShape(self):
		'converts the text object and its containing layer to a fill layer with the text changed to a clipping path'
		return self._oleobj_.InvokeTypes(1131819635, LCID, 1, (24, 0), (),)

	def CreatePath(self):
		'creates a work path based on the text object'
		return self._oleobj_.InvokeTypes(1129803892, LCID, 1, (24, 0), (),)

	def SetColor(self, arg0=defaultUnnamedArg):
		'color of text'
		return self._oleobj_.InvokeTypes(1413704771, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	_prop_map_get_ = {
		"AlternateLigatures": (1095529587, 2, (11, 0), (), "AlternateLigatures", None),
		"AntiAliasMethod": (1094808688, 2, (3, 0), (), "AntiAliasMethod", None),
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"AutoKerning": (1097560686, 2, (3, 0), (), "AutoKerning", None),
		"AutoLeadingAmount": (1097621837, 2, (5, 0), (), "AutoLeadingAmount", None),
		"BaselineShift": (1114403688, 2, (5, 0), (), "BaselineShift", None),
		"Capitalization": (1130459251, 2, (3, 0), (), "Capitalization", None),
		# Method 'Color' returns object of type '_SolidColor'
		"Color": (1413704771, 2, (9, 0), (), "Color", '{D2D1665E-C1B9-4CA0-8AC9-529F6A3D9002}'),
		"Contents": (1885564532, 2, (8, 0), (), "Contents", None),
		"DesiredGlyphScaling": (1148405619, 2, (5, 0), (), "DesiredGlyphScaling", None),
		"DesiredLetterScaling": (1148406899, 2, (5, 0), (), "DesiredLetterScaling", None),
		"DesiredWordScaling": (1148409715, 2, (5, 0), (), "DesiredWordScaling", None),
		"Direction": (1413769586, 2, (3, 0), (), "Direction", None),
		"FauxBold": (1182286444, 2, (11, 0), (), "FauxBold", None),
		"FauxItalic": (1182288244, 2, (11, 0), (), "FauxItalic", None),
		"FirstLineIndent": (1413900644, 2, (5, 0), (), "FirstLineIndent", None),
		"Font": (1665560180, 2, (8, 0), (), "Font", None),
		"HangingPunctuation": (1213227875, 2, (11, 0), (), "HangingPunctuation", None),
		"HangingPuntuation": (1213227892, 2, (11, 0), (), "HangingPuntuation", None),
		"Height": (1214736500, 2, (5, 0), (), "Height", None),
		"HorizontalScale": (1215452003, 2, (3, 0), (), "HorizontalScale", None),
		"HyphenLimit": (1212968308, 2, (3, 0), (), "HyphenLimit", None),
		"HyphenateAfterFirst": (1212245620, 2, (3, 0), (), "HyphenateAfterFirst", None),
		"HyphenateBeforeLast": (1212311154, 2, (3, 0), (), "HyphenateBeforeLast", None),
		"HyphenateCapitalWords": (1212379251, 2, (11, 0), (), "HyphenateCapitalWords", None),
		"HyphenateWordsLongerThan": (1212970094, 2, (3, 0), (), "HyphenateWordsLongerThan", None),
		"Hyphenation": (1430810728, 2, (11, 0), (), "Hyphenation", None),
		"HyphenationZone": (1213886053, 2, (5, 0), (), "HyphenationZone", None),
		"Justification": (1886024564, 2, (3, 0), (), "Justification", None),
		"Kind": (1265200740, 2, (3, 0), (), "Kind", None),
		"Language": (1281453671, 2, (3, 0), (), "Language", None),
		"Leading": (1414292583, 2, (5, 0), (), "Leading", None),
		"LeftIndent": (1414293860, 2, (5, 0), (), "LeftIndent", None),
		"Ligatures": (1282699891, 2, (11, 0), (), "Ligatures", None),
		"MaximumGlyphScaling": (1299400563, 2, (5, 0), (), "MaximumGlyphScaling", None),
		"MaximumLetterScaling": (1298222195, 2, (5, 0), (), "MaximumLetterScaling", None),
		"MaximumWordScaling": (1298225011, 2, (5, 0), (), "MaximumWordScaling", None),
		"MinimumGlyphScaling": (1298745203, 2, (5, 0), (), "MinimumGlyphScaling", None),
		"MinimumLetterScaling": (1298746483, 2, (5, 0), (), "MinimumLetterScaling", None),
		"MinimumWordScaling": (1298749299, 2, (5, 0), (), "MinimumWordScaling", None),
		"NoBreak": (1315922539, 2, (11, 0), (), "NoBreak", None),
		"OldStyle": (1331975028, 2, (11, 0), (), "OldStyle", None),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"Position": (1332897646, 2, (12, 0), (), "Position", None),
		"RightIndent": (1414687076, 2, (5, 0), (), "RightIndent", None),
		"Size": (1886679930, 2, (5, 0), (), "Size", None),
		"SpaceAfter": (1414750566, 2, (5, 0), (), "SpaceAfter", None),
		"SpaceBefore": (1414742630, 2, (5, 0), (), "SpaceBefore", None),
		"StrikeThru": (1347711605, 2, (3, 0), (), "StrikeThru", None),
		"TextComposer": (1413705843, 2, (3, 0), (), "TextComposer", None),
		"Tracking": (1416784750, 2, (5, 0), (), "Tracking", None),
		"Underline": (1433168238, 2, (3, 0), (), "Underline", None),
		"UseAutoLeading": (1097622631, 2, (11, 0), (), "UseAutoLeading", None),
		"VerticalScale": (1450464099, 2, (3, 0), (), "VerticalScale", None),
		"WarpBend": (1463971428, 2, (5, 0), (), "WarpBend", None),
		"WarpDirection": (1464101234, 2, (3, 0), (), "WarpDirection", None),
		"WarpHorizontalDistortion": (1464353907, 2, (5, 0), (), "WarpHorizontalDistortion", None),
		"WarpStyle": (1465087084, 2, (3, 0), (), "WarpStyle", None),
		"WarpVerticalDistortion": (1465271411, 2, (5, 0), (), "WarpVerticalDistortion", None),
		"Width": (1466201192, 2, (5, 0), (), "Width", None),
	}
	_prop_map_put_ = {
		"AlternateLigatures": ((1095529587, LCID, 4, 0),()),
		"AntiAliasMethod": ((1094808688, LCID, 4, 0),()),
		"AutoKerning": ((1097560686, LCID, 4, 0),()),
		"AutoLeadingAmount": ((1097621837, LCID, 4, 0),()),
		"BaselineShift": ((1114403688, LCID, 4, 0),()),
		"Capitalization": ((1130459251, LCID, 4, 0),()),
		"Color": ((1413704771, LCID, 4, 0),()),
		"Contents": ((1885564532, LCID, 4, 0),()),
		"DesiredGlyphScaling": ((1148405619, LCID, 4, 0),()),
		"DesiredLetterScaling": ((1148406899, LCID, 4, 0),()),
		"DesiredWordScaling": ((1148409715, LCID, 4, 0),()),
		"Direction": ((1413769586, LCID, 4, 0),()),
		"FauxBold": ((1182286444, LCID, 4, 0),()),
		"FauxItalic": ((1182288244, LCID, 4, 0),()),
		"FirstLineIndent": ((1413900644, LCID, 4, 0),()),
		"Font": ((1665560180, LCID, 4, 0),()),
		"HangingPunctuation": ((1213227875, LCID, 4, 0),()),
		"HangingPuntuation": ((1213227892, LCID, 4, 0),()),
		"Height": ((1214736500, LCID, 4, 0),()),
		"HorizontalScale": ((1215452003, LCID, 4, 0),()),
		"HyphenLimit": ((1212968308, LCID, 4, 0),()),
		"HyphenateAfterFirst": ((1212245620, LCID, 4, 0),()),
		"HyphenateBeforeLast": ((1212311154, LCID, 4, 0),()),
		"HyphenateCapitalWords": ((1212379251, LCID, 4, 0),()),
		"HyphenateWordsLongerThan": ((1212970094, LCID, 4, 0),()),
		"Hyphenation": ((1430810728, LCID, 4, 0),()),
		"HyphenationZone": ((1213886053, LCID, 4, 0),()),
		"Justification": ((1886024564, LCID, 4, 0),()),
		"Kind": ((1265200740, LCID, 4, 0),()),
		"Language": ((1281453671, LCID, 4, 0),()),
		"Leading": ((1414292583, LCID, 4, 0),()),
		"LeftIndent": ((1414293860, LCID, 4, 0),()),
		"Ligatures": ((1282699891, LCID, 4, 0),()),
		"MaximumGlyphScaling": ((1299400563, LCID, 4, 0),()),
		"MaximumLetterScaling": ((1298222195, LCID, 4, 0),()),
		"MaximumWordScaling": ((1298225011, LCID, 4, 0),()),
		"MinimumGlyphScaling": ((1298745203, LCID, 4, 0),()),
		"MinimumLetterScaling": ((1298746483, LCID, 4, 0),()),
		"MinimumWordScaling": ((1298749299, LCID, 4, 0),()),
		"NoBreak": ((1315922539, LCID, 4, 0),()),
		"OldStyle": ((1331975028, LCID, 4, 0),()),
		"Position": ((1332897646, LCID, 4, 0),()),
		"RightIndent": ((1414687076, LCID, 4, 0),()),
		"Size": ((1886679930, LCID, 4, 0),()),
		"SpaceAfter": ((1414750566, LCID, 4, 0),()),
		"SpaceBefore": ((1414742630, LCID, 4, 0),()),
		"StrikeThru": ((1347711605, LCID, 4, 0),()),
		"TextComposer": ((1413705843, LCID, 4, 0),()),
		"Tracking": ((1416784750, LCID, 4, 0),()),
		"Underline": ((1433168238, LCID, 4, 0),()),
		"UseAutoLeading": ((1097622631, LCID, 4, 0),()),
		"VerticalScale": ((1450464099, LCID, 4, 0),()),
		"WarpBend": ((1463971428, LCID, 4, 0),()),
		"WarpDirection": ((1464101234, LCID, 4, 0),()),
		"WarpHorizontalDistortion": ((1464353907, LCID, 4, 0),()),
		"WarpStyle": ((1465087084, LCID, 4, 0),()),
		"WarpVerticalDistortion": ((1465271411, LCID, 4, 0),()),
		"Width": ((1466201192, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class XMPMetadata(DispatchBaseClass):
	CLSID = IID('{DC865034-A587-4CC4-8A5A-453032562BE4}')
	coclass_clsid = None

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Parent": (1668574834, 2, (9, 0), (), "Parent", None),
		"RawData": (1884441956, 2, (8, 0), (), "RawData", None),
	}
	_prop_map_put_ = {
		"RawData": ((1884441956, LCID, 4, 0),()),
	}
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class _ActionDescriptor(DispatchBaseClass):
	CLSID = IID('{70A60330-E866-46AA-A715-ABF418C41453}')
	coclass_clsid = IID('{04581B80-0023-46F3-BB7B-B75313B05185}')

	def Clear(self):
		'Clear the descriptor'
		return self._oleobj_.InvokeTypes(1296117809, LCID, 1, (24, 0), (),)

	def Erase(self, Key=defaultNamedNotOptArg):
		'Erase a key from the descriptor'
		return self._oleobj_.InvokeTypes(1296117810, LCID, 1, (24, 0), ((3, 1),),Key
			)

	def GetBoolean(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type boolean'
		return self._oleobj_.InvokeTypes(1296117811, LCID, 1, (11, 0), ((3, 1),),Key
			)

	def GetClass(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type class'
		return self._oleobj_.InvokeTypes(1296117812, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetDouble(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type double'
		return self._oleobj_.InvokeTypes(1296117814, LCID, 1, (5, 0), ((3, 1),),Key
			)

	def GetEnumerationType(self, Key=defaultNamedNotOptArg):
		'Get the enumeration type of a key'
		return self._oleobj_.InvokeTypes(1296117815, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetEnumerationValue(self, Key=defaultNamedNotOptArg):
		'Get the enumeration value of a key'
		return self._oleobj_.InvokeTypes(1296117816, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetInteger(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type integer'
		return self._oleobj_.InvokeTypes(1296117817, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetKey(self, Index=defaultNamedNotOptArg):
		'Get ID of the Nth key'
		return self._oleobj_.InvokeTypes(1296118064, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetLargeInteger(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type large integer'
		return self._oleobj_.InvokeTypes(1296119094, LCID, 1, (3, 0), ((3, 1),),Key
			)

	# Result is of type _ActionList
	def GetList(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type list'
		ret = self._oleobj_.InvokeTypes(1296118065, LCID, 1, (9, 0), ((3, 1),),Key
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetList', '{55031766-E456-4E54-A0D0-8E545601A2D8}')
		return ret

	def GetObjectType(self, Key=defaultNamedNotOptArg):
		'Get the class ID of an object in a key of type object'
		return self._oleobj_.InvokeTypes(1296118066, LCID, 1, (3, 0), ((3, 1),),Key
			)

	# Result is of type _ActionDescriptor
	def GetObjectValue(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type object'
		ret = self._oleobj_.InvokeTypes(1296118067, LCID, 1, (9, 0), ((3, 1),),Key
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetObjectValue', '{70A60330-E866-46AA-A715-ABF418C41453}')
		return ret

	def GetPath(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type Alias'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1296118068, LCID, 1, (8, 0), ((3, 1),),Key
			)

	# Result is of type _ActionReference
	def GetReference(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type ActionReference'
		ret = self._oleobj_.InvokeTypes(1296118069, LCID, 1, (9, 0), ((3, 1),),Key
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetReference', '{DFF407C7-3BCC-45AC-B6CC-EE6D52032D85}')
		return ret

	def GetString(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type string'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1296118070, LCID, 1, (8, 0), ((3, 1),),Key
			)

	def GetType(self, Key=defaultNamedNotOptArg):
		'Get the type of a key'
		return self._oleobj_.InvokeTypes(1296118071, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetUnitDoubleType(self, Key=defaultNamedNotOptArg):
		'Get the unit type of a key of type UnitDouble'
		return self._oleobj_.InvokeTypes(1296118072, LCID, 1, (3, 0), ((3, 1),),Key
			)

	def GetUnitDoubleValue(self, Key=defaultNamedNotOptArg):
		'Get the value of a key of type UnitDouble'
		return self._oleobj_.InvokeTypes(1296118073, LCID, 1, (5, 0), ((3, 1),),Key
			)

	def HasKey(self, Key=defaultNamedNotOptArg):
		'does the descriptor contain the provided key?'
		return self._oleobj_.InvokeTypes(1296118320, LCID, 1, (11, 0), ((3, 1),),Key
			)

	def IsEqual(self, OtherDesc=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118321, LCID, 1, (11, 0), ((9, 1),),OtherDesc
			)

	def PutBoolean(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118322, LCID, 1, (24, 0), ((3, 1), (11, 1)),Key
			, Value)

	def PutClass(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118323, LCID, 1, (24, 0), ((3, 1), (3, 1)),Key
			, Value)

	def PutDouble(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118324, LCID, 1, (24, 0), ((3, 1), (5, 1)),Key
			, Value)

	def PutEnumerated(self, Key=defaultNamedNotOptArg, EnumType=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118325, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1)),Key
			, EnumType, Value)

	def PutInteger(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118326, LCID, 1, (24, 0), ((3, 1), (3, 1)),Key
			, Value)

	def PutLargeInteger(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296119093, LCID, 1, (24, 0), ((3, 1), (3, 1)),Key
			, Value)

	def PutList(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118327, LCID, 1, (24, 0), ((3, 1), (9, 1)),Key
			, Value)

	def PutObject(self, Key=defaultNamedNotOptArg, ClassID=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118328, LCID, 1, (24, 0), ((3, 1), (3, 1), (9, 1)),Key
			, ClassID, Value)

	def PutPath(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118329, LCID, 1, (24, 0), ((3, 1), (8, 1)),Key
			, Value)

	def PutReference(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118576, LCID, 1, (24, 0), ((3, 1), (9, 1)),Key
			, Value)

	def PutString(self, Key=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118577, LCID, 1, (24, 0), ((3, 1), (8, 1)),Key
			, Value)

	def PutUnitDouble(self, Key=defaultNamedNotOptArg, UnitID=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118578, LCID, 1, (24, 0), ((3, 1), (3, 1), (5, 1)),Key
			, UnitID, Value)

	def SetObjectValue(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1346462580, 2, (3, 0), (), "Count", None),
	}
	_prop_map_put_ = {
		"ObjectValue": ((0, LCID, 4, 0),()),
	}
	# Default method for this class is 'ObjectValue'
	def __call__(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1346462580, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class _ActionList(DispatchBaseClass):
	CLSID = IID('{55031766-E456-4E54-A0D0-8E545601A2D8}')
	coclass_clsid = IID('{4BDD3D7A-5BAA-402B-B75D-B3A7913D4F60}')

	def Clear(self):
		'Clear the list'
		return self._oleobj_.InvokeTypes(1296117809, LCID, 1, (24, 0), (),)

	def GetBoolean(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type boolean'
		return self._oleobj_.InvokeTypes(1296117811, LCID, 1, (11, 0), ((3, 1),),Index
			)

	def GetClass(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type class'
		return self._oleobj_.InvokeTypes(1296117812, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetDouble(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type double'
		return self._oleobj_.InvokeTypes(1296117814, LCID, 1, (5, 0), ((3, 1),),Index
			)

	def GetEnumerationType(self, Index=defaultNamedNotOptArg):
		'Get the enumeration type of an item'
		return self._oleobj_.InvokeTypes(1296117815, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetEnumerationValue(self, Index=defaultNamedNotOptArg):
		'Get the enumeration value of an item'
		return self._oleobj_.InvokeTypes(1296117816, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetInteger(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type integer'
		return self._oleobj_.InvokeTypes(1296117817, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetLargeInteger(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type large integer'
		return self._oleobj_.InvokeTypes(1296119094, LCID, 1, (3, 0), ((3, 1),),Index
			)

	# Result is of type _ActionList
	def GetList(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type list'
		ret = self._oleobj_.InvokeTypes(1296118065, LCID, 1, (9, 0), ((3, 1),),Index
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetList', '{55031766-E456-4E54-A0D0-8E545601A2D8}')
		return ret

	def GetObjectType(self, Index=defaultNamedNotOptArg):
		'Get the class ID of an object in an item of type object'
		return self._oleobj_.InvokeTypes(1296118066, LCID, 1, (3, 0), ((3, 1),),Index
			)

	# Result is of type _ActionDescriptor
	def GetObjectValue(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type object'
		ret = self._oleobj_.InvokeTypes(1296118067, LCID, 1, (9, 0), ((3, 1),),Index
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetObjectValue', '{70A60330-E866-46AA-A715-ABF418C41453}')
		return ret

	def GetPath(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type Alias'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1296118068, LCID, 1, (8, 0), ((3, 1),),Index
			)

	# Result is of type _ActionReference
	def GetReference(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type ActionReference'
		ret = self._oleobj_.InvokeTypes(1296118069, LCID, 1, (9, 0), ((3, 1),),Index
			)
		if ret is not None:
			ret = Dispatch(ret, 'GetReference', '{DFF407C7-3BCC-45AC-B6CC-EE6D52032D85}')
		return ret

	def GetString(self, Index=defaultNamedNotOptArg):
		'Get the value of an item of type string'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1296118070, LCID, 1, (8, 0), ((3, 1),),Index
			)

	def GetType(self, Index=defaultNamedNotOptArg):
		'Get the type of an item'
		return self._oleobj_.InvokeTypes(1296118071, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetUnitDoubleType(self, Index=defaultNamedNotOptArg):
		'Get the unit type of an item of type UnitDouble'
		return self._oleobj_.InvokeTypes(1296118072, LCID, 1, (3, 0), ((3, 1),),Index
			)

	def GetUnitDoubleValue(self, Index=defaultNamedNotOptArg):
		'Get the value of anm item of type UnitDouble'
		return self._oleobj_.InvokeTypes(1296118073, LCID, 1, (5, 0), ((3, 1),),Index
			)

	def PutBoolean(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118322, LCID, 1, (24, 0), ((11, 1),),Value
			)

	def PutClass(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118323, LCID, 1, (24, 0), ((3, 1),),Value
			)

	def PutDouble(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118324, LCID, 1, (24, 0), ((5, 1),),Value
			)

	def PutEnumerated(self, EnumType=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118325, LCID, 1, (24, 0), ((3, 1), (3, 1)),EnumType
			, Value)

	def PutInteger(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118326, LCID, 1, (24, 0), ((3, 1),),Value
			)

	def PutLargeInteger(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296119093, LCID, 1, (24, 0), ((3, 1),),Value
			)

	def PutList(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118327, LCID, 1, (24, 0), ((9, 1),),Value
			)

	def PutObject(self, ClassID=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118328, LCID, 1, (24, 0), ((3, 1), (9, 1)),ClassID
			, Value)

	def PutPath(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118329, LCID, 1, (24, 0), ((8, 1),),Value
			)

	def PutReference(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118576, LCID, 1, (24, 0), ((9, 1),),Value
			)

	def PutString(self, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118577, LCID, 1, (24, 0), ((8, 1),),Value
			)

	def PutUnitDouble(self, UnitID=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118578, LCID, 1, (24, 0), ((3, 1), (5, 1)),UnitID
			, Value)

	def SetObjectValue(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
		"Count": (1346462580, 2, (3, 0), (), "Count", None),
	}
	_prop_map_put_ = {
		"ObjectValue": ((0, LCID, 4, 0),()),
	}
	# Default method for this class is 'ObjectValue'
	def __call__(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)
	#This class has Count() property - allow len(ob) to provide this
	def __len__(self):
		return self._ApplyTypes_(*(1346462580, 2, (3, 0), (), "Count", None))
	#This class has a __len__ - this is needed so 'if object:' always returns TRUE.
	def __nonzero__(self):
		return True

class _ActionReference(DispatchBaseClass):
	CLSID = IID('{DFF407C7-3BCC-45AC-B6CC-EE6D52032D85}')
	coclass_clsid = IID('{54B9B6A6-F8FE-4362-B3BF-01BAD3425898}')

	# Result is of type _ActionReference
	def GetContainer(self):
		ret = self._oleobj_.InvokeTypes(1296118579, LCID, 1, (9, 0), (),)
		if ret is not None:
			ret = Dispatch(ret, 'GetContainer', '{DFF407C7-3BCC-45AC-B6CC-EE6D52032D85}')
		return ret

	def GetDesiredClass(self):
		return self._oleobj_.InvokeTypes(1296118580, LCID, 1, (3, 0), (),)

	def GetEnumeratedType(self):
		"Get type of enumeration of an ActionReference whose form is 'Enumerated'"
		return self._oleobj_.InvokeTypes(1296118581, LCID, 1, (3, 0), (),)

	def GetEnumeratedValue(self):
		"Get value of enumeration of an ActionReference whose form is 'Enumerated'"
		return self._oleobj_.InvokeTypes(1296118582, LCID, 1, (3, 0), (),)

	def GetForm(self):
		'Get form of ActionReference'
		return self._oleobj_.InvokeTypes(1296118583, LCID, 1, (3, 0), (),)

	def GetIdentifier(self):
		"Get identifier value for an ActionReference whoxse form is 'Identifier'"
		return self._oleobj_.InvokeTypes(1296118584, LCID, 1, (3, 0), (),)

	def GetIndex(self):
		"Get index value for an ActionReference whoxse form is 'Index'"
		return self._oleobj_.InvokeTypes(1296118585, LCID, 1, (3, 0), (),)

	def GetName(self):
		"Get name value for an ActionReference whoxse form is 'Name'"
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1296118832, LCID, 1, (8, 0), (),)

	def GetOffset(self):
		"Get offset value for an ActionReference whoxse form is 'Offset'"
		return self._oleobj_.InvokeTypes(1296118833, LCID, 1, (3, 0), (),)

	def GetProperty(self):
		"Get property ID value for an ActionReference whoxse form is 'Property'"
		return self._oleobj_.InvokeTypes(1296118834, LCID, 1, (3, 0), (),)

	def PutClass(self, DesiredClass=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118835, LCID, 1, (24, 0), ((3, 1),),DesiredClass
			)

	def PutEnumerated(self, DesiredClass=defaultNamedNotOptArg, EnumType=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118836, LCID, 1, (24, 0), ((3, 1), (3, 1), (3, 1)),DesiredClass
			, EnumType, Value)

	def PutIdentifier(self, DesiredClass=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118837, LCID, 1, (24, 0), ((3, 1), (3, 1)),DesiredClass
			, Value)

	def PutIndex(self, DesiredClass=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118838, LCID, 1, (24, 0), ((3, 1), (3, 1)),DesiredClass
			, Value)

	def PutName(self, DesiredClass=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118839, LCID, 1, (24, 0), ((3, 1), (8, 1)),DesiredClass
			, Value)

	def PutOffset(self, DesiredClass=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118840, LCID, 1, (24, 0), ((3, 1), (3, 1)),DesiredClass
			, Value)

	def PutProperty(self, DesiredClass=defaultNamedNotOptArg, Value=defaultNamedNotOptArg):
		return self._oleobj_.InvokeTypes(1296118841, LCID, 1, (24, 0), ((3, 1), (3, 1)),DesiredClass
			, Value)

	def SetObjectValue(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	_prop_map_get_ = {
		# Method 'Application' returns object of type '_Application'
		"Application": (1667330160, 2, (9, 0), (), "Application", '{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}'),
	}
	_prop_map_put_ = {
		"ObjectValue": ((0, LCID, 4, 0),()),
	}
	# Default method for this class is 'ObjectValue'
	def __call__(self, arg0=defaultUnnamedArg):
		return self._oleobj_.InvokeTypes(0, LCID, 8, (24, 0), ((9, 0),),arg0
			)

	def __str__(self, *args):
		return str(self.__call__(*args))
	def __int__(self, *args):
		return int(self.__call__(*args))
	def __iter__(self):
		"Return a Python iterator for this object"
		try:
			ob = self._oleobj_.InvokeTypes(-4,LCID,3,(13, 10),())
		except pythoncom.error:
			raise TypeError("This object does not support enumeration")
		return win32com.client.util.Iterator(ob, None)

class _Application(DispatchBaseClass):
	'The Adobe Photoshop application'
	CLSID = IID('{5DE90358-4D0B-4FA1-BA3E-C91BBA863F32}')
	coclass_clsid = IID('{03616384-72CF-4FE9-8838-58E590127F0B}')

	def Batch(self, InputFiles=defaultNamedNotOptArg, Action=defaultNamedNotOptArg, From=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'run the batch automation routine'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1112813617, LCID, 1, (8, 0), ((12, 1), (8, 1), (8, 1), (12, 17)),InputFiles
			, Action, From, Options)

	def ChangeColorSettings(self, Name=defaultNamedOptArg, File=defaultNamedOptArg):
		'set Color Settings to a named set or to the contents of a settings file'
		return self._oleobj_.InvokeTypes(1130906490, LCID, 1, (24, 0), ((12, 17), (12, 17)),Name
			, File)

	def CharIDToTypeID(self, CharID=defaultNamedNotOptArg):
		'convert from a four character code to a runtime ID'
		return self._oleobj_.InvokeTypes(1098002483, LCID, 1, (3, 0), ((8, 1),),CharID
			)

	def DoAction(self, Action=defaultNamedNotOptArg, From=defaultNamedNotOptArg):
		'play an action from the Actions Palette'
		return self._oleobj_.InvokeTypes(1148141923, LCID, 1, (24, 0), ((8, 1), (8, 1)),Action
			, From)

	def DoJavaScript(self, JavaScriptCode=defaultNamedNotOptArg, Arguments=defaultNamedOptArg, ExecutionMode=defaultNamedOptArg):
		'execute JavaScript code'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1147828311, LCID, 1, (8, 0), ((8, 1), (12, 17), (12, 17)),JavaScriptCode
			, Arguments, ExecutionMode)

	def DoJavaScriptFile(self, JavaScriptFile=defaultNamedNotOptArg, Arguments=defaultNamedOptArg, ExecutionMode=defaultNamedOptArg):
		'execute javascript file'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1147823703, LCID, 1, (8, 0), ((8, 1), (12, 17), (12, 17)),JavaScriptFile
			, Arguments, ExecutionMode)

	# Result is of type _ActionDescriptor
	def ExecuteAction(self, EventID=defaultNamedNotOptArg, Descriptor=defaultNamedOptArg, DisplayDialogs=defaultNamedOptArg):
		'play an ActionManager event'
		ret = self._oleobj_.InvokeTypes(1349280121, LCID, 1, (9, 0), ((3, 1), (12, 17), (12, 17)),EventID
			, Descriptor, DisplayDialogs)
		if ret is not None:
			ret = Dispatch(ret, 'ExecuteAction', '{70A60330-E866-46AA-A715-ABF418C41453}')
		return ret

	# Result is of type _ActionDescriptor
	def ExecuteActionGet(self, Reference=defaultNamedNotOptArg):
		'obtain an action descriptor'
		ret = self._oleobj_.InvokeTypes(1095198068, LCID, 1, (9, 0), ((9, 1),),Reference
			)
		if ret is not None:
			ret = Dispatch(ret, 'ExecuteActionGet', '{70A60330-E866-46AA-A715-ABF418C41453}')
		return ret

	def FeatureEnabled(self, Name=defaultNamedNotOptArg):
		'is the feature with the given name enabled?'
		return self._oleobj_.InvokeTypes(1718904174, LCID, 1, (11, 0), ((8, 1),),Name
			)

	def Load(self, Document=defaultNamedNotOptArg):
		'load a support document'
		return self._oleobj_.InvokeTypes(1281643372, LCID, 1, (24, 0), ((8, 1),),Document
			)

	def MakeContactSheet(self, InputFiles=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'create a contact sheet from multiple files'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1129599816, LCID, 1, (8, 0), ((12, 1), (12, 17)),InputFiles
			, Options)

	def MakePDFPresentation(self, InputFiles=defaultNamedNotOptArg, OutputFile=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'create a PDF presentation file'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1346651697, LCID, 1, (8, 0), ((12, 1), (8, 1), (12, 17)),InputFiles
			, OutputFile, Options)

	def MakePhotoGallery(self, InputFolder=defaultNamedNotOptArg, OutputFolder=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'Creates a web photo gallery'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(2004316263, LCID, 1, (8, 0), ((12, 1), (8, 1), (12, 17)),InputFolder
			, OutputFolder, Options)

	def MakePhotomerge(self, InputFiles=defaultNamedNotOptArg):
		'DEPRECATED. Merges multiple files into one, user interaction required.'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(1886678375, LCID, 1, (8, 0), ((12, 1),),InputFiles
			)

	def MakePicturePackage(self, InputFiles=defaultNamedNotOptArg, Options=defaultNamedOptArg):
		'create a picture package from multiple files'
		# Result is a Unicode object
		return self._oleobj_.InvokeTypes(13477028