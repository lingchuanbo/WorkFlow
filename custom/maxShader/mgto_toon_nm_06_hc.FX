
/***  Based on Code Snippets generated through Lumonix shaderFX  by: till 'rollin' maginot _ till.maginot.eu _ 03.2013   ***/ 

/*** Normalmap Toon/Comic Shader v0.60b ***/

// This FX shader was built to support 3ds Max's DXSAS shader compiler. 
//~ <no flag added> //3ds Max uses the default parser
//~ string ParamID = "0x000001"; //Max uses its first generation DXSAS parser, which is now outdated
//~ string ParamID = "0x002"; //Max uses the CgFX parser - use this if your shader is written in Cg instead of HLSL
string ParamID = "0x003"; //Max uses the newer version of the DXSAS parser

 



float4x4 world : World < string UIWidget = "None"; >;  
float4x4 worldI : WorldInverse < string UIWidget = "None"; >;  
float4x4 worldIT : WorldInverseTranspose < string UIWidget = "None"; >;  

float4x4 viewInv : ViewInverse < string UIWidget = "None"; >;  
float4x4 wvp : WorldViewProjection < string UIWidget = "None"; >;  







// Diffuse Map ##########################

bool useDiffuseMap
<
	string UIName = "Use DiffuseMap";
> = false;
 
texture diffuseMap : DiffuseMap
<
	string ResourceName = "human_ship_frigate_D.tga";
	string UIName = "  -DiffuseMap";
	string ResourceType = "2D";
>;
 
sampler2D diffuseMapSampler = sampler_state
{
	Texture = <diffuseMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
float3 diffuseColor
<
	string UIName = "  -DiffuseColor";
	string UIWidget = "Color";
> = {1.0f, 1.0f, 1.0f };



// Vertex Colors ##########################


bool useVertexColors
<
	string UIName = "Use VertexColors";
> = false;
 
//Vertex Color and Alpha in from Max 
int texcoord0 : Texcoord 
<
	int Texcoord = 0;
	int MapChannel = 1;
	string UIWidget = "None"; 
>;

int texcoord1 : Texcoord 
<
	int Texcoord = 1;
	int MapChannel = 2;
	string UIWidget = "None"; 
>;

int texcoord2 : Texcoord 
<
	int Texcoord = 2;
	int MapChannel = 3;
	string UIWidget = "None"; 
>;

int texcoord3 : Texcoord 
<
	int Texcoord = 3;
	int MapChannel = 0;
	string UIWidget = "None"; 
>;

int texcoord4 : Texcoord 
<
	int Texcoord = 4;
	int MapChannel = -2;
	string UIWidget = "None"; 
>;




// Opacity ##########################

bool useOpacityFromDiffuseAlpha
<
	string UIName = "Use OpacityFromDiffuseAlpha";
> = false;

bool useOpacityFromDiffuseColor
<
	string UIName = "Use OpacityFromDiffuseColor";
> = false;

//~ bool useOpacityMap
//~ <
	//~ string UIName = "Use OpacityMap.R";
//~ > = false;
 
//~ bool useOpacityMapAlpha
//~ <
	//~ string UIName = "Use OpacityMap.A";
//~ > = false;
 
//~ texture opacityMap
//~ <
	//~ string ResourceName = "darFly_body_A_01_test.tga";
	//~ string UIName = "  -OpacityMap";
	//~ string ResourceType = "2D";
//~ >;
 
//~ sampler2D opacityMapSampler = sampler_state
//~ {
	//~ Texture = <opacityMap>;
	//~ MinFilter = LINEAR;
	//~ MagFilter = LINEAR;
	//~ MipFilter = LINEAR;
	//~ AddressU = WRAP;
	//~ AddressV = WRAP;
//~ };
 
float opacityValue
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
	float UIStep = 0.1;
	string UIName = "  -Opacity";
> = 1.0;



// NORMAL MAP ##########################

bool useNormalmap
<
	string UIName = "Use Normalmap";
> = false;
 
 texture NormalMap : NormalMap
<
	string ResourceName = "N_tak.tga";
	string UIName = "  -NormalMap";
	string ResourceType = "2D";
>;
sampler2D NormalMapSampler = sampler_state
{
	Texture = <NormalMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};

bool invertRed
<
	string UIName = "  -InvertRed";
> = false;
 
bool invertGreen
<
	string UIName = "  -InvertGreen";
> = false;

float nmDepth
<
	string UIWidget = "Spinner";
	float UIMin = -100.0;
	float UIMax = 100.0;
	float UIStep = 0.1;
	string UIName = "  -NmDepth";
> = 1.0;















// Specularity ##########################

bool useSpecMap
<
	string UIName = "Use SpecMap";
> = false;

texture specMap : SpecularMap
<
	string ResourceName = "S_tak.tga";
	string UIName = "  -SpecMap ";
	string ResourceType = "2D";
>;
 
sampler2D specMapSampler = sampler_state
{
	Texture = <specMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
  
float specLevelMul
<
	string UIWidget = "Spinner";
	float UIMin = -200.0;
	float UIMax = 200.0;
	float UIStep = 0.01;
	string UIName = "  -SpecLevel (*)";
> = 2.0;
 
float specLevelAdd
<
	string UIWidget = "Spinner";
	float UIMin = -200.0;
	float UIMax = 200.0;
	float UIStep = 0.01;
	string UIName = "  -SpecLevel (+)";
> = 0.0;

float specOffset
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "  -SpecOffset";
> = 0.0;



// Glossiness 


bool useGlossMap
<
	string UIName = "Use GlossMap (spec map alpha)";
> = false;
 
//~ texture glossMap
//~ <
	//~ string ResourceName = "Gloss_tak.tga";
	//~ string UIName = "  -GlossMap";
	//~ string ResourceType = "2D";
//~ >;
 
//~ sampler2D glossMapSampler = sampler_state
//~ {
	//~ Texture = <glossMap>;
	//~ MinFilter = LINEAR;
	//~ MagFilter = LINEAR;
	//~ MipFilter = LINEAR;
	//~ AddressU = WRAP;
	//~ AddressV = WRAP;
//~ };
  
float glossLevel
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 500.0;
	float UIStep = 0.1;
	string UIName = "  -GlossLevel";
> = 1.0;

float glossOffset
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -GlossOffset";
> = 0.0;
 






// Self Illumination ##########################

bool useSelfilum
<
	string UIName = "Use SelfIllumMap";
> = false;
 
texture selfiluminationMap
<
	string ResourceName = "";
	string UIName = "  -SelfIllumMap";
	string ResourceType = "2D";
>;
 
sampler2D selfiluminationMapSampler = sampler_state
{
	Texture = <selfiluminationMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
float3 selfIlumColor
<
	string UIName = "  -SelfIllumColor";
	string UIWidget = "Color";
> = {0.0f, 0.0f, 0.0f };

 

// Rim Light ##########################

bool useRimlight
<
	string UIName = "Use Rimlight (Diffuse Fresnel)";
> = false;


float3 rimColor
<
	string UIName = "  -RimColor";
	string UIWidget = "Color";
> = {0.835294f, 0.952941f, 1.0f };

float rimFalloff
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -RimFallof";
> = 3.0;
 
 float rimPower
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -RimPower";
> = 1.0;

 float rimOffset
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -RimOffset";
> = 0.0;
  
bool disableNMforRim
<
	string UIName = "  -DisableNMforRimL";
> = false;
 



// Cube Map ##########################

bool useCubeMap
<
	string UIName = "Use CubeMap";
> = false;


 

texture cubeMap : environment
<
	string ResourceName = "sunol_cubemap.dds";
	string UIName = "  -CubeMap";
	string ResourceType = "Cube";
>;
 
samplerCUBE cubeMapSampler = sampler_state
{
	Texture = <cubeMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
};
 
float cubeMapStrength
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -CubeMapStrength";
> = 1.0;

bool useCubeMapMask
<
	string UIName = "  -Use Mask (spec value)";
> = false;

 
bool useCubeMapBlurMap
<
	string UIName = "  -Use Blur (gloss value)";
> = false;

//~ texture cubeMapMaskAndBlurMap
//~ <
	//~ string ResourceName = "";
	//~ string UIName = "  -Mask and Blur";
	//~ string ResourceType = "2D";
//~ >;
 
//~ sampler2D cubeMapMaskAndBlurMapSampler = sampler_state
//~ {
	//~ Texture = <cubeMapMaskAndBlurMap>;
	//~ MinFilter = LINEAR;
	//~ MagFilter = LINEAR;
	//~ MipFilter = LINEAR;
	//~ AddressU = WRAP;
	//~ AddressV = WRAP;
//~ };

float cubeMapBlur
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 100.0;
	float UIStep = 0.1;
	string UIName = "  -CubeMapBlur";
> = 0.0;
 


 




 
 
 
 // SSS ##########################
 
 
bool useSSS
<
	string UIName = "Use SSS";
> = false;
 

 
bool useSSSmask
<
	string UIName = "  -Use SSSMask";
> = false;
 
texture sssMap
<
	string ResourceName = "";
	string UIName = "  -SSSMask";
	string ResourceType = "2D";
>;
 
sampler2D sssMaskSampler = sampler_state
{
	Texture = <sssMap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};

 float3 sssColor
<
	string UIName = "  -SSSColor";
	string UIWidget = "Color";
> = {0.18f, 0.07f, 0.05f };

float sssFalloff
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "  -SSSFalloff";
> = 0.4;
 
float sssContrast
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "  -SSSContrast";
> = 0.8;
 

 


// Shading ##########################


bool useShading
<
	string UIName = "Use Shading";
> = true;
 
bool useRampedShading
<
	string UIName = "Use RampedShading";
> = false;
 
float rampRange
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.01;
	string UIName = "  -RampRange";
> = 3.0;
 
texture rampTexture
<
	string ResourceName = "ramp_hard1.jpg";
	string UIName = "  -RampTexture";
	string ResourceType = "2D";
>;
 
sampler2D rampTextureSampler = sampler_state
{
	Texture = <rampTexture>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
};
 
float rampTextureContrast
<
	string UIWidget = "Spinner";
	float UIMin = -100.0;
	float UIMax = 100.0;
	float UIStep = 0.01;
	string UIName = "  -RampTextureContrast";
> = 1.0;




 






// Lights ##########################


bool useLightAttenuation
<
	string UIName = "Use LightAttenuation";
> = false;
 
float Attenuation3
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10000.0;
	float UIStep = 0.1;
	string UIName = "  -Attenuation3";
> = 0.0;
 
float Attenuation2
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10000.0;
	float UIStep = 0.1;
	string UIName = "  -Attenuation2";
> = 1.0;
 
float Attenuation1
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10000.0;
	float UIStep = 0.1;
	string UIName = "  -Attenuation1";
> = 0.0;
 
float AttenuationScale
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 10000.0;
	float UIStep = 1.0;
	string UIName = "  -Attenuation Scale";
> = 1200.0;
 
float lightStrength
<
	string UIWidget = "Spinner";
	float UIMin = -10.0;
	float UIMax = 10.0;
	float UIStep = 0.1;
	string UIName = "LightStrength";
> = 1.0;
 
float3 ambientLight
<
	string UIName = "AmbientLightColor";
	string UIWidget = "Color";
> = {0.0f, 0.0f, 0.0f };
 












// this function does the different types of light attenuation 
float attenuation_func(int lightattenType, float4 lightAttenuation, float3 lightVec) 
{ 
	float att = 1.0; 
	return att; 
} 
	 
// this function does the different types of cone angle 
float coneangle_func(int lightconeType, float lightHotspot, float lightFalloff, float3 lightVec/*, float3 lightDir*/) 
{ 
	float cone = 1.0; 
	return cone; 
} 





/************** light info **************/ 

bool useLight1
<
	string UIName = "+   Use Light1";
> = true;
/*
float3 light1Dir : Direction 
< 
	string UIName = "Light 1 Direction"; 
	string Object = "TargetLight"; 
	string Space = "World"; 
		int refID = 1; 
> = {100.0f, 100.0f, 100.0f}; 
*/
float3 light1Pos : POSITION 
< 
	string UIName = "Light 1 Position"; 
	string Object = "PointLight"; 
	string Space = "World"; 
		int refID = 1; 
> = {100.0f, 100.0f, 100.0f}; 

float4 light1Color : LIGHTCOLOR <int LightRef = 1; string UIWidget = "None"; > = { 1.0f, 1.0f, 1.0f, 1.0f}; 
float4 light1Attenuation : Attenuation <int LightRef = 1; string UIWidget = "None"; > = {20.0f, 30.0f, 0.0f, 100.0f}; 
float light1Hotspot : HotSpot <int LightRef = 1; string UIWidget = "None"; > = { 43.0f }; 
float light1Falloff : FallOff <int LightRef = 1; string UIWidget = "None"; > = { 45.0f }; 

#define light1Type 1
#define light1attenType 0
#define light1coneType 0
#define light1CastShadows true

//---------------------------------- 

bool useLight2
<
	string UIName = "+   Use Light2";
> = false;

/*
float3 light2Dir : Direction 
< 
	string UIName = "Light 2 Direction"; 
	string Object = "TargetLight"; 
	string Space = "World"; 
		int refID = 2; 
> = {100.0f, 100.0f, 100.0f}; 
*/
float3 light2Pos : POSITION 
< 
	string UIName = "Light 2 Position"; 
	string Object = "PointLight"; 
	string Space = "World"; 
		int refID = 2; 
> = {100.0f, 100.0f, 100.0f}; 

float4 light2Color : LIGHTCOLOR <int LightRef = 2; string UIWidget = "None"; > = { 1.0f, 1.0f, 1.0f, 1.0f}; 
float4 light2Attenuation : Attenuation <int LightRef = 2; string UIWidget = "None"; > = {20.0f, 30.0f, 0.0f, 100.0f}; 
float light2Hotspot : HotSpot <int LightRef = 2; string UIWidget = "None"; > = { 43.0f }; 
float light2Falloff : FallOff <int LightRef = 2; string UIWidget = "None"; > = { 45.0f }; 

#define light2Type 1
#define light2attenType 0
#define light2coneType 0
#define light2CastShadows true

//---------------------------------- 

bool useLight3
<
	string UIName = "+   Use Light3";
> = false;
/*
float3 light3Dir : Direction 
< 
	string UIName = "Light 3 Direction"; 
	string Object = "TargetLight"; 
	string Space = "World"; 
		int refID = 3; 
> = {100.0f, 100.0f, 100.0f}; 
*/
float3 light3Pos : POSITION 
< 
	string UIName = "Light 3 Position"; 
	string Object = "PointLight"; 
	string Space = "World"; 
		int refID = 3; 
> = {100.0f, 100.0f, 100.0f}; 

float4 light3Color : LIGHTCOLOR <int LightRef = 3; string UIWidget = "None"; > = { 1.0f, 1.0f, 1.0f, 1.0f}; 
float4 light3Attenuation : Attenuation <int LightRef = 3; string UIWidget = "None"; > = {20.0f, 30.0f, 0.0f, 100.0f}; 
float light3Hotspot : HotSpot <int LightRef = 3; string UIWidget = "None"; > = { 43.0f }; 
float light3Falloff : FallOff <int LightRef = 3; string UIWidget = "None"; > = { 45.0f }; 

#define light3Type 1
#define light3attenType 0
#define light3coneType 0
#define light3CastShadows true

//---------------------------------- 










// these elements are required for projected shadows 
//#define useSoftshadow

#include <shadowMap.fxh> 
#ifdef useSoftshadow
SOFT_SHADOW_FUNCTOR(shadowTerm1, 000, true);
SOFT_SHADOW_FUNCTOR(shadowTerm2, 000, true);
//~ SOFT_SHADOW_FUNCTOR(shadowTerm3, 000, true);
#else
SHADOW_FUNCTOR(shadowTerm1); 
SHADOW_FUNCTOR(shadowTerm2); 
//~ SHADOW_FUNCTOR(shadowTerm3); 
#endif

float shadowTermUberFunction(float4 worldPos, int passCount)
{
	float shadow = 1.0;
	
	// !!! every shadowTerm needs 4 sampler
	
	if (passCount == 1) shadow = shadowTerm1(worldPos);
	else if (passCount == 2) shadow = shadowTerm2(worldPos);
	//~ else if (passCount == 3) shadow = shadowTerm3(worldPos); // sorry.. with a max of 16 sampler per pass and max stupid pass blendig bug we have to leave one shadow blank
	
	return shadow;
}





// LitSphere ##########################

bool useLitSphere
<
	string UIName = "Use LitSphere";
> = false;

texture LitSphere
<
	string ResourceName = "test.jpg";
	string UIName = "  -LitSphere";
	string ResourceType = "2D";
>;
 
sampler2D LitSphereSampler = sampler_state
{
	Texture = <LitSphere>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
float litSphereStrength
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "  -LitSphereStrength";
> = 1.0;






// create the light vector 
float3 lightVec_func(float3 worldSpacePos, float3 lightVector, float3x3 objTangentXf, int lightType) 
{ 
	float3 lightVec = mul(objTangentXf, (mul((lightVector - worldSpacePos), worldI).xyz)); 
	return lightVec; 
} 













// ##############################################################################################
//                                      LIGHTING METHODS
// ##############################################################################################

// lights & shadow
float3 getLightsAndShadows (float3 _LightColor, uniform bool lightCastShadows, float3 _L_vec_length, float4 _WPos, uniform int _ShadowPassCount)
{
	// -----------------------------------------------------------------------------------------------------------
	// Light Attenuation
	float finalLightAttenuation = 1.0f;
	if (1.0f == useLightAttenuation) 
		finalLightAttenuation = ((1.0f / ((((_L_vec_length * _L_vec_length) * Attenuation3) + (_L_vec_length * Attenuation2)) + Attenuation1)) * AttenuationScale); 
		
	float3 finalLight = (_LightColor * finalLightAttenuation) * lightStrength;
	
	// -----------------------------------------------------------------------------------------------------------
	// Shadows
	float finalShadow  = 1.0; 
	
	if ( true == lightCastShadows) 
		finalShadow  = shadowTermUberFunction(_WPos, _ShadowPassCount);		//fetch the shadow value from the shadow map  
	
	// -----------------------------------------------------------------------------------------------------------
	return finalLight * finalShadow; 
}

// (Ramped) Shading
float3 getShading(float _NDotL)
{
	// -----------------------------------------------------------------------------------------------------------
	// Ramped Shading
	float3 finalShading = float3(1,1,1);
	if (1.0f == useShading) 
	{
		float2 rampUV = float2( pow(((_NDotL * 0.5f) + 0.5f),rampRange), 1.0f);
		float4 rampTexture = tex2D(rampTextureSampler, rampUV.xy);
		float3 newRampTexture = float3(pow(rampTexture.r,rampTextureContrast), pow(rampTexture.g,rampTextureContrast), pow(rampTexture.b,rampTextureContrast));
		
		if (1.0f == useRampedShading) 
			finalShading = newRampTexture; 
		else 
			finalShading = _NDotL; 
	}
	return finalShading;
}

// Specularity (&Gloss)
float3 getSpec(float2 _TexCoord, float3 _NDotH)
{
	// -----------------------------------------------------------------------------------------------------------
	// Specularity
	float3 specMap = tex2D(specMapSampler, _TexCoord).rgb;
	float glossMap = tex2D(specMapSampler, _TexCoord).a;
	
	float finalGloss = (useGlossMap * glossMap) + glossOffset;
	float NdotH_pow_Glossiness = pow( _NDotH, ((255.0f * (finalGloss * finalGloss)) * glossLevel) );		//x to the power of y 
	
	return  ((specMap * useSpecMap) + specOffset) * NdotH_pow_Glossiness;
}

// sss
float3 getSSS(float2 _TexCoord, float3 _LDotN, float3 InvLDotN)
{
	// -----------------------------------------------------------------------------------------------------------
	// sss
	float sssMap = tex2D(sssMaskSampler, _TexCoord).r;
	float sssMask1 = 1.0f;
	
	if (1.0f == useSSSmask)
		sssMask1 = sssMap; 
	
	float sssMask2 = pow(((1.0 / (((_LDotN + InvLDotN) + 0.01) * sssFalloff)) * 0.1),sssContrast);		//x to the power of y 
	sssMask2 = clamp(sssMask2, 0.0f, 1.0f); 
	float3 finalSSS = float3(0,0,0);
	
	if (1.0f == useSSS) 
		finalSSS = (sssMask1 * (sssMask2 * sssColor.rgb)); 
	
	// remove it from areas in shadow
	finalSSS *= 1- saturate(pow((1.f + InvLDotN),2.f)  - 1.f)   ;
	
	return finalSSS;
}


// ##############################################################################################
//                                      AMBIENT METHODS
// ##############################################################################################

// diffuse 
float4 getDiffuseMulVertColor(float2 _TexCoord, float3 _Color)
{
	// -----------------------------------------------------------------------------------------------------------
	// Vertex Colors
	float3 finalVertColor = float3(1.0f, 1.0f, 1.0f);
	if (1.0f == useVertexColors) 
		finalVertColor = _Color; 
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Diffuse Map
	float4 diffuseMap = tex2D(diffuseMapSampler, _TexCoord);
	float3 finalDiffuse = diffuseColor;
	if (1.0f == useDiffuseMap) 
		finalDiffuse *= diffuseMap.rgb; 
	
	
	float4 diffuseMulVertColor = float4(1.0f, 1.0f, 1.0f, diffuseMap.a);
	diffuseMulVertColor.rgb = finalVertColor * finalDiffuse;
	
	return diffuseMulVertColor;
}

// normal
float3 getNormal(float2 _TexCoord)
{
	// -----------------------------------------------------------------------------------------------------------
	// Normal Map
	float4 NormalMap = tex2D(NormalMapSampler, _TexCoord);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	//NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	
	// invert red
	float newNormalRed;
	if (invertRed == 1.0f) 
		newNormalRed = (0.0f - NormalMap.r); 
	else 
		newNormalRed = NormalMap.r; 
	
	// invert green
	float newNormalGreen;
	if (invertGreen == 1.0f) 
		newNormalGreen = (0.0f - NormalMap.g); 
	else 
		newNormalGreen = NormalMap.g; 
	
	float3 finalNormal = normalize(float3(newNormalRed, newNormalGreen, NormalMap.b * (1.0 / nmDepth)));
	float3 Normal = float3(0,0,1);	//tangent space normal vector 
	
	if (1.0f != useNormalmap) 
		finalNormal = Normal; 
	
	return finalNormal;
}

// opacity
float getOpacity (float2 _TexCoord, float _DiffuseAlpha)
{
	// -----------------------------------------------------------------------------------------------------------
	// Opacity
	float4 opacityMap = tex2D(diffuseMapSampler, _TexCoord).a;
	float finalOpacity = opacityValue;
	
	if (1.0f == useOpacityFromDiffuseAlpha)
	{
		finalOpacity = _DiffuseAlpha;
	}
	//~ else
	//~ {
		//~ if (1.0f == useOpacityMap) 
			//~ finalOpacity = opacityMap.r; 
		//~ else if (1.0f == useOpacityMapAlpha)
		//~ {
			//~ finalOpacity = opacityMap.a; 
		//~ }
	//~ }
	return finalOpacity;
}


// Lit Sphere
float3 getLitSphere (float3 finalNormal_ws)
{
	// -----------------------------------------------------------------------------------------------------------
	// Lit Sphere
	if (useLitSphere)
	{
		float2 litSphereUV = (float2(0.5f,0.5f) + float2(0.5f, -0.5f) * float2(normalize(mul(viewInv, finalNormal_ws).xyz).xy));
		float4 LitSphere = tex2D(LitSphereSampler, litSphereUV.xy);
		return  (LitSphere.rgb * litSphereStrength);
	}
	else
		return float3(0,0,0);
}

// Self Ilumination
float3 getSelfIlumination(float2 _TexCoord)
{
	// -----------------------------------------------------------------------------------------------------------
	// Self Ilumination
	float4 selfiluminationMap = tex2D(selfiluminationMapSampler, _TexCoord);
	float3 finalSelfIlum = selfIlumColor.rgb;
	if (1.0f == useSelfilum) 
		finalSelfIlum *= selfiluminationMap.rgb; 
	return finalSelfIlum;
}

// RimLight
float3 getRimLight(float3 _V, float3 _Normal)
{
	// -----------------------------------------------------------------------------------------------------------
	// RimLight
	if (1.0f == useRimlight)
	{
		float3 rimNormal = _Normal;
		float3 bla = float3(0,0,1);
		
		if (1.0f == disableNMforRim) 
			rimNormal = bla; 
		
		float rimMask = saturate(dot(_V,rimNormal));
		
		if(rimMask < 0.1f)
			rimMask = 0.1f;
		
		// v1
		//float rimValue = pow((rimFalloff / rimMask ),rimPower) + rimOffset;	
		// v2
		float rimValue = pow((1- rimMask), rimFalloff) * rimPower + rimOffset;
		
		return  (rimValue * rimColor.rgb);
	}
	return float3(0,0,0);
}

// CubeMap	
float3 getCubeMap(float2 _TexCoord, float3 finalNormal_ws, float3 _ViewDir)
{
	// -----------------------------------------------------------------------------------------------------------
	// CubeMap	
	if (useCubeMap)
	{
		float4 reflectionDir = (0,0,0,0);
		
		//~ float2 cubeMapMaskAndBlurMap = tex2D(cubeMapMaskAndBlurMapSampler, _TexCoord).rg; // red == mask, green == blur
		float cubeMapMaskMap =  tex2D(specMapSampler, _TexCoord).r;
		float cubeMapBlurMap = tex2D(specMapSampler, _TexCoord).a;
		
		
		if (1.0f == useCubeMapBlurMap)
			reflectionDir.w = (1 - cubeMapBlurMap ) * 10.f + cubeMapBlur;
		else
			reflectionDir.w = cubeMapBlur;
		
		reflectionDir.xyz = reflect(_ViewDir, finalNormal_ws);		//Compute the reflection vector 
		
		#ifdef YUP 
		#else 
		reflectionDir.xyz = reflectionDir.xzy;  //swizzle required for Max 
		#endif 
		
		
		
		float4 cubeMap = texCUBElod(cubeMapSampler, reflectionDir);
		float cubeMapMask = 1.0f;
		if (1.0f == useCubeMapMask)
			cubeMapMask = cubeMapMaskMap;
		
		float3 finalCubeMap = cubeMapStrength * cubeMap.rgb * cubeMapMask;
		return saturate(finalCubeMap); 
	}
	else 
		return float3(0,0,0);
}



// ##############################################################################################
// ##############################################################################################
















// input from application 
struct a2v { 
	float4 position		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
	float4 tangent		: TANGENT; 
	float4 binormal		: BINORMAL; 
	float4 normal		: NORMAL; 
	float3 vertcol		: TEXCOORD3; 
	float vertalpha 		: TEXCOORD4; 

}; 





// ###################################
// One Pass Per Light


// output to fragment program 
struct v2f { 
        float4 position    		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
        float3 worldTangent  	: TEXCOORD1; 
        float3 worldBinormal 	: TEXCOORD2; 
        float3 worldNormal   	: TEXCOORD3; 
        float4 color    		: COLOR0; 
        float3 viewDir	    	: TEXCOORD4; 
        float3 lightVec    		: TEXCOORD5; 
        float3 eyeVec	    	: TEXCOORD6; 
        float4 wposition	    	: TEXCOORD7; 

}; 



// Ambient Pass Vertex Shader: 
v2f av(a2v In, uniform float3 lightPos, uniform int lightType/*, uniform float3 lightDir*/) 
{ 
	v2f Out = (v2f)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	In.texCoord += float2(0.0,1.0);		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
	//this code was added by the World Space Transform Node 
	Out.worldNormal = mul(In.normal, worldIT).xyz;		//compute world space normal 
	Out.worldBinormal = mul(In.binormal, worldIT).xyz;	//compute world space binormal 
	Out.worldTangent = mul(In.tangent, worldIT).xyz;		//compute world space tangent 
	//this code was added by the Vertex Color Node 
	Out.color = float4(In.vertcol.rgb, In.vertalpha.r); 

	//this code was added by the Eye Vector Node 
	float3x3 objTangentXf;								//build object to tangent space transform matrix 
	#ifdef YUP 
	objTangentXf[0] = In.tangent.xyz; 
	objTangentXf[1] = -In.binormal.xyz; 
	#else 
	objTangentXf[0] = In.binormal.xyz; 
	objTangentXf[1] = -In.tangent.xyz; 
	#endif 
	objTangentXf[2] = In.normal.xyz; 
	//these three lines were added by the Eye Vector Node 
	float4 osIPos = mul(viewInv[3], worldI);			//put world space eye position in object space 
	float3 osIVec = osIPos.xyz - In.position.xyz;		//object space eye vector 
	Out.eyeVec = mul(objTangentXf, osIVec);				//tangent space eye vector passed out 
	
	//this code was added by the World Space Transform Node 
	Out.viewDir = mul(In.position, world) - viewInv[3]; 

	return Out; 
} 

// Ambient Pass Pixel Shader: 
float4 af(v2f In, /*uniform float3 lightDir,*/ uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 
	float3 V = normalize(In.eyeVec.xyz);	//normalized eye vector 
	float3 black = float3(0.0f, 0.0f, 0.0f);
	float3 white = float3(1.0f, 1.0f, 1.0f);
	
	// -----------------------------------------------------------------------------------------------------------
	// Normal Map
	float3 finalNormal = getNormal( In.texCoord.xy);
	float3 Normal = float3(0,0,1);	//tangent space normal vector 
	
	// MATRIX
	// -----------------------------------------------------------------------------------------------------------
	//this code was added by the World Space Transform Node 
	float3 Nn = normalize(In.worldNormal); 		//input the vectors required for tangent to world space transform 
	float3 Tn = normalize(In.worldTangent); 
	float3 Bn = normalize(In.worldBinormal); 
	#ifdef YUP 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Tn ) + ( finalNormal.y * -Bn); 
	#else 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Bn ) + ( finalNormal.y * -Tn); 
	#endif 
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Lit Sphere
	float3 finalLitSphere = getLitSphere(finalNormal_ws);
	
	// -----------------------------------------------------------------------------------------------------------
	// Self Ilumination
	float3 finalSelfIlum = getSelfIlumination(In.texCoord.xy);
	
	// -----------------------------------------------------------------------------------------------------------
	// Diffuse Map +  Vertex Colors
	float4 diffuseMulVertColor = getDiffuseMulVertColor( In.texCoord.xy, In.color);
	
	// -----------------------------------------------------------------------------------------------------------
	// RimLight
	float3 finalRim = getRimLight(V, finalNormal);
	
	// -----------------------------------------------------------------------------------------------------------
	// CubeMap	
	float3 finalCubeMap = getCubeMap(In.texCoord.xy, finalNormal_ws, In.viewDir);
	
	// -----------------------------------------------------------------------------------------------------------
	// Opacity
	float finalOpacity = getOpacity(In.texCoord.xy, diffuseMulVertColor.a);
	
	
	
	// -----------------------------------------------------------------------------------------------------------
	// MIXING	
	float4 ret = float4(0,0,0,1); 
	
	ret.rgb = finalLitSphere + finalRim + finalCubeMap + (finalSelfIlum * diffuseMulVertColor)  + (diffuseMulVertColor * ambientLight.rgb); 
	
	ret.a = finalOpacity ; 
	
	
	
	
	
	
	// DEBUG
	//ret.rgba = float4(0,0,0,1); // debug :
	//ret.rgb = saturate(dot(V,float3(0,0,1)));
	
	
	
	
	return saturate(ret); 
} 




// Vertex Shader: 
v2f v(a2v In, uniform float3 lightPos, uniform int lightType/*, uniform float3 lightDir*/) 
{ 
	v2f Out = (v2f)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 
	Out.color = float4(In.vertcol.rgb, In.vertalpha.r); 		// vertexcolor

	In.texCoord += float2(0.0,1.0);					//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
	
	//this code was added by the Light Vector Node 
	float3x3 objTangentXf;							//build object to tangent space transform matrix 
	#ifdef YUP 
	objTangentXf[0] = In.tangent.xyz; 
	objTangentXf[1] = -In.binormal.xyz; 
	#else 
	objTangentXf[0] = In.binormal.xyz; 
	objTangentXf[1] = -In.tangent.xyz; 
	#endif 
	objTangentXf[2] = In.normal.xyz; 
	
	float3 wsLPos = mul(In.position, world).xyz;			//put the vert position in world space 
	float3 wsLVec = lightPos - wsLPos;    				//cast a ray to the light 
	float3 osLVec = mul(wsLVec, worldI).xyz;  			//transform the world space light vector to object space 
	Out.lightVec = mul(objTangentXf, osLVec);			//tangent space light vector passed out 
	
	//these three lines were added by the Eye Vector Node 
	float4 osIPos = mul(viewInv[3], worldI);				//put world space eye position in object space 
	float3 osIVec = osIPos.xyz - In.position.xyz;			//object space eye vector 
	Out.eyeVec = mul(objTangentXf, osIVec);			//tangent space eye vector passed out 
	Out.wposition = mul(In.position, world);				//world space vertex position passed out 

	return Out; 
} 

// Pixel Shader: 
float4 f(v2f In, /*uniform float3 lightDir,*/ uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 
	
	
	if (0.0f == useLight1 && shadowPassCount == 1)
		return float4(0,0,0,0);
	
	if (0.0f == useLight2 && shadowPassCount == 2)
		return float4(0,0,0,0);
	
	if (0.0f == useLight3 && shadowPassCount == 3)
		return float4(0,0,0,0);
	
	
	
	float3 L = normalize(In.lightVec.xyz);	//normalized light vector 
	float3 L_vec = In.lightVec.xyz;		//unnormalized light vector 
	float L_vec_length = length(L_vec);		//Measure the length of the vector 
	float3 V = normalize(In.eyeVec.xyz);	//normalized eye vector 
	float3 NormalizedHalfAngle = normalize((L + V));		//Normalize 
	
	
	float3 black = float3(0.0f, 0.0f, 0.0f );
	float3 white = float3(1.0f, 1.0f, 1.0f );
	
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Diffuse Map +  Vertex Colors
	float4 diffuseMulVertColor = getDiffuseMulVertColor( In.texCoord.xy, In.color);
	
	// -----------------------------------------------------------------------------------------------------------
	// Normal Map
	float3 finalNormal = getNormal( In.texCoord.xy);
	
	float finalNormalDotH = saturate(dot(NormalizedHalfAngle,finalNormal)); 		//clamped dot product
	float finalNormalDotL = saturate(dot(L,finalNormal));		//dot product 
	float ldotFinalNormal = saturate(dot(finalNormal,L)); 		//clamped dot product 
	float inLdotFinalNormal = saturate(dot(finalNormal,-L)); 		//clamped dot product 
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Ramped Shading
	float3 finalShading = getShading(finalNormalDotL);
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Specularity
	float3 finalSpec = getSpec(In.texCoord.xy, finalNormalDotH);
	
	
	// -----------------------------------------------------------------------------------------------------------
	// sss
	float3 finalSSS = getSSS(In.texCoord.xy, ldotFinalNormal, inLdotFinalNormal);
	
	/*
	// -----------------------------------------------------------------------------------------------------------
	// Shadows
	float finalShadow  = 1.0; 
	
	if ( true == lightCastShadows) 
		finalShadow  = shadowTermUberFunction(In.wposition, shadowPassCount);		//fetch the shadow value from the shadow map  
	
	
	float3 finalShadingAndLightAndShadow = finalLight * finalShadow; 
	*/
	float3 finalShadingAndLightAndShadow = getLightsAndShadows(lightColor.rgb, lightCastShadows,  L_vec_length, In.wposition, shadowPassCount);
	
	// -----------------------------------------------------------------------------------------------------------
	// Opacity
	float finalOpacity = getOpacity(In.texCoord.xy, diffuseMulVertColor.a);
	
	
	
	
	// -----------------------------------------------------------------------------------------------------------
	// MIXING
	float4 ret = float4(0,0,0,1); 
	
	// shading
	ret.rgb += diffuseMulVertColor ; 
	
	// spec
	ret.rgb += diffuseMulVertColor *  (finalSpec * specLevelMul);
	ret.rgb += finalSpec * specLevelAdd;
	
	// sss
	ret.rgb += (1+diffuseMulVertColor) * finalSSS;
	
	// light color & shadow
	ret.rgb *= finalShadingAndLightAndShadow * finalShading ;
	
	//ret.rgb *=   4.0f / shadowPassCount * 0.1f; // this would work but makes the shading 'stufenförmig'
	
	// opacity
	ret.a = finalOpacity; 
	
	
	
	
	// DEBUG
	//ret.rgb =  float3(0.5,0,0);
	//ret.rgb =	finalShading * 0.2f;
	//if (ret.r < 0.05f) ret.rgb = black;
	//ret.a = 0.0f / shadowPassCount;
	//if (ret.a < 0.5f) ret.a = 0.0f;
	//ret.a = 10.0f;	
	
	
	
	
	return saturate(ret); 
} 

// ###################################





// ###################################
// All Lights In One Pass


// output to fragment program 
struct v2f3L { 
        float2 texCoord		: TEXCOORD0;
	
	float4 position    		: POSITION; 
	float4 wposition	    	: TEXCOORD1; 
	
	float4 color    		: COLOR0;
	
	//float3 eyeVec	    	: TEXCOORD2;  // eye vector is written into light vectors
	float3 viewDir	    	: TEXCOORD3; 
	
        float4 light1Vec    		: TEXCOORD4; 
        float4 light2Vec    		: TEXCOORD5; 
        float4 light3Vec    		: TEXCOORD6; 
	
	float3 worldTangent  	: TEXCOORD7; 
        float3 worldBinormal 	: TEXCOORD8; 
        float3 worldNormal   	: TEXCOORD9;

}; 


// Vertex Shader: 
v2f3L v3L(a2v In) 
{ 
	v2f3L Out = (v2f3L)0; 
	
	//---------------------------------------
	// UVs
	In.texCoord += float2(0.0,1.0);					//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
	
	//---------------------------------------
	// Vertex Position
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 
	Out.wposition = mul(In.position, world);				//world space vertex position passed out 
	
	//---------------------------------------
	// Vertex Color
	Out.color = float4(In.vertcol.rgb, In.vertalpha.r); 		
	
	
	
	//this code was added by the Light Vector Node 
	float3x3 objTangentXf;								//build object to tangent space transform matrix 
	#ifdef YUP 
	objTangentXf[0] = In.tangent.xyz; 
	objTangentXf[1] = -In.binormal.xyz; 
	#else 
	objTangentXf[0] = In.binormal.xyz; 
	objTangentXf[1] = -In.tangent.xyz; 
	#endif 
	objTangentXf[2] = In.normal.xyz; 
	
	float3 wsLPos = mul(In.position, world).xyz;			//put the vert position in world space 
	
	//---------------------------------------
	// VIEW
	float4 osIPos = mul(viewInv[3], worldI);				//put world space eye position in object space 
	float3 osIVec = osIPos.xyz - In.position.xyz;			//object space eye vector 
	float3 eyeVec = mul(objTangentXf, osIVec);			//tangent space eye vector passed out 
	Out.light1Vec.w = eyeVec.x;
	Out.light2Vec.w = eyeVec.y;
	Out.light3Vec.w = eyeVec.z;
	Out.viewDir = mul(In.position, world) - viewInv[3]; 
	
	
	//---------------------------------------
	// LIGHTS
	float3 wsL1Vec = light1Pos - wsLPos;    				//cast a ray to the light 
	float3 osL1Vec = mul(wsL1Vec, worldI).xyz;  			//transform the world space light vector to object space 
	Out.light1Vec.xyz = mul(objTangentXf, osL1Vec);			//tangent space light vector passed out 
	
	float3 wsL2Vec = light2Pos - wsLPos;    				//cast a ray to the light 
	float3 osL2Vec = mul(wsL2Vec, worldI).xyz;  			//transform the world space light vector to object space 
	Out.light2Vec.xyz = mul(objTangentXf, osL2Vec);			//tangent space light vector passed out 
	
	float3 wsL3Vec = light3Pos - wsLPos;   				//cast a ray to the light 
	float3 osL3Vec = mul(wsL3Vec, worldI).xyz;  			//transform the world space light vector to object space 
	Out.light3Vec.xyz = mul(objTangentXf, osL3Vec);			//tangent space light vector passed out 
	
	
	Out.worldNormal = mul(In.normal, worldIT).xyz;		//compute world space normal 
	Out.worldBinormal = mul(In.binormal, worldIT).xyz;	//compute world space binormal 
	Out.worldTangent = mul(In.tangent, worldIT).xyz;		//compute world space tangent 
	

	return Out; 
} 

// Pixel Shader: 
float4 f3L(v2f3L In) : COLOR 
{ 
	const float3 black = float3(0.0f, 0.0f, 0.0f);
	const float3 white = float3(1.0f, 1.0f, 1.0f);
	
	// reconstruct eye vector
	const float3 InEyeVec = float3(In.light1Vec.w, In.light2Vec.w, In.light3Vec.w);
	const float3 V = normalize(InEyeVec);	//normalized eye vector 
	
	// -----------------------------------------------------------------------------------------------------------
	// Diffuse Map +  Vertex Colors
	float4 diffuseMulVertColor = (0,0,0,1);
	diffuseMulVertColor = getDiffuseMulVertColor( In.texCoord.xy, In.color);
	
	// -----------------------------------------------------------------------------------------------------------
	// Opacity
	float finalOpacity = 1.0f;
	finalOpacity = getOpacity(In.texCoord.xy, diffuseMulVertColor.a);
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Normal Map
	const float3 finalNormal = getNormal( In.texCoord.xy);
	const float3 Normal = float3(0,0,1);	//tangent space normal vector 
	
	// MATRIX
	// -----------------------------------------------------------------------------------------------------------
	//this code was added by the World Space Transform Node 
	const float3 Nn = normalize(In.worldNormal); 		//input the vectors required for tangent to world space transform 
	const float3 Tn = normalize(In.worldTangent); 
	const float3 Bn = normalize(In.worldBinormal); 
	#ifdef YUP 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Tn ) + ( finalNormal.y * -Bn); 
	#else 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Bn ) + ( finalNormal.y * -Tn); 
	#endif 
	
	
	
	
	
	// ____________________________________________________________________________
	// LIGHT INDEPENDENT STUFF
	
	// -----------------------------------------------------------------------------------------------------------
	// Self Ilumination
	float3 finalSelfIlum = black;
	finalSelfIlum = getSelfIlumination(In.texCoord.xy);
	
	// -----------------------------------------------------------------------------------------------------------
	// RimLight
	float3 finalRim = getRimLight(V, finalNormal);
	
	// -----------------------------------------------------------------------------------------------------------
	// CubeMap	
	float3 finalCubeMap = black;
	finalCubeMap = getCubeMap(In.texCoord.xy, finalNormal_ws, In.viewDir);
	
	
	
	
	// ____________________________________________________________________________
	// STUFF WITH LIGHTS
	
	float3 finalShading = black;
	float3 finalSpec = black;
	float3 finalSSS = black;
	float3 finalShadingAndLightAndShadow = black;
	
	for( uint i = 1; i < 4; ++i )
	{
	
		float3 thisLightVec;
		float3 thisLightColor = black;
		bool thisLightCastShadows;
		uint thisShadowPassCount = i;
		
		if (1 == i && 1.0f == useLight1)
		{
			thisLightVec = In.light1Vec.xyz;
			thisLightColor = light1Color;
			thisLightCastShadows = light1CastShadows;
		}
		else if (2 == i && 1.0f == useLight2)
		{
			thisLightVec = In.light2Vec.xyz;
			thisLightColor = light2Color;
			thisLightCastShadows = light2CastShadows;
		}
		else if (3 == i && 1.0f == useLight3)
		{
			thisLightVec = In.light3Vec.xyz;
			thisLightColor = light3Color;
			thisLightCastShadows = light3CastShadows;
		}
		else 
			continue;
		
		float3 L = normalize(thisLightVec);				//normalized light vector 
		float3 L_vec = thisLightVec;					//unnormalized light vector 
		float L_vec_length = length(L_vec);			//Measure the length of the light vector 
		float3 V = normalize(InEyeVec);			//normalized eye vector 
		float3 NormalizedHalfAngle = normalize((L + V));		
		
		float finalNormalDotH = saturate(dot(NormalizedHalfAngle,finalNormal)); 		
		float finalNormalDotL = saturate(dot(L,finalNormal));						
		float ldotFinalNormal = saturate(dot(finalNormal,L)); 						
		float inLdotFinalNormal = saturate(dot(finalNormal,-L)); 
		
							
		
		
		// -----------------------------------------------------------------------------------------------------------
		// lights and shadows
		float3 thisLightAndShadow = getLightsAndShadows(thisLightColor, thisLightCastShadows,  L_vec_length, In.wposition, thisShadowPassCount);
		
		// -----------------------------------------------------------------------------------------------------------
		// shading
		float3 thisShading = getShading(finalNormalDotL);
		
		// -----------------------------------------------------------------------------------------------------------
		// Specularity
		float3 thisSpec =  getSpec(In.texCoord.xy,finalNormalDotH) * thisLightAndShadow;
		
		
		// -----------------------------------------------------------------------------------------------------------
		// sss
		float3 thisSSS = getSSS(In.texCoord.xy, ldotFinalNormal, inLdotFinalNormal) * thisLightAndShadow; // here input also the shadows
		
		//~ float4 bla = float4(0,0,0,1);
		//~ bla.rgb = getSSS(In.texCoord.xy, ldotFinalNormal, inLdotFinalNormal);
		//~ return saturate(bla); 
		
		finalShadingAndLightAndShadow += thisLightAndShadow * thisShading;
		finalShading += thisShading;
		finalSpec += thisSpec;
		finalSSS += thisSSS;
	}
	
	//~ finalShadingAndLightAndShadow = saturate(finalShadingAndLightAndShadow);
	//~ finalShadingAndLightAndShadow += ambientLight.rgb * (1-finalShadingAndLightAndShadow);
	//~ finalShadingAndLightAndShadow = saturate(finalShadingAndLightAndShadow);
	//~ finalSpec = saturate(finalSpec);
	finalSSS = saturate(finalSSS) ;//* (0.2f+finalShadingAndLightAndShadow);
	
	
	
	
	// -----------------------------------------------------------------------------------------------------------
	// MIXING
	float4 ret = float4(0,0,0,1); 
	// opacity
	ret.a = finalOpacity; 
	 
	
	
	// diffuse
	ret.rgb = diffuseMulVertColor ; 
	
	// reflection
	ret.rgb += finalCubeMap;
	
	// shading
	// light color & shadow
	ret.rgb *= finalShadingAndLightAndShadow  + (1 - finalShadingAndLightAndShadow ) * ambientLight.rgb;
	
	// selfilumination
	ret.rgb += finalSelfIlum;
	
	// spec
	ret.rgb += diffuseMulVertColor *  (finalSpec * specLevelMul);
	ret.rgb += finalSpec * specLevelAdd;
	
	// sss
	ret.rgb += diffuseMulVertColor * finalSSS ;
	
	// rimlight
	ret.rgb += finalRim;
	
	if (useOpacityFromDiffuseColor)
		ret.a *= saturate(ret.r + ret.g + ret.b);
	
	
	// DEBUG
	//~ ret.rgb =  float3(1,1,1);
	//~ ret.rgb =	finalShadingAndLightAndShadow;
	//if (ret.r < 0.05f) ret.rgb = black;
	//ret.a = 0.0f / shadowPassCount;
	//if (ret.a < 0.5f) ret.a = 0.0f;
	//ret.a = 10.0f;	
	//~ ret = float4(0.1f,0.1f,0.5f,0.8f); 
	
	
	
	return saturate(ret); 
} 



// Pixel Shader Addons: 
float4 fAddons(v2f3L In) : COLOR 
{ 
	const float3 black = float3(0.0f, 0.0f, 0.0f);
	const float3 white = float3(1.0f, 1.0f, 1.0f);
	
	// reconstruct eye vector
	const float3 InEyeVec = float3(In.light1Vec.w, In.light2Vec.w, In.light3Vec.w);
	const float3 V = normalize(InEyeVec);	//normalized eye vector 
	
	// -----------------------------------------------------------------------------------------------------------
	// Diffuse Map +  Vertex Colors
	float4 diffuseMulVertColor = (0,0,0,1);
	diffuseMulVertColor = getDiffuseMulVertColor( In.texCoord.xy, In.color);
	
	// -----------------------------------------------------------------------------------------------------------
	// Opacity
	float finalOpacity = 1.0f;
	finalOpacity = getOpacity(In.texCoord.xy, diffuseMulVertColor.a);
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Normal Map
	const float3 finalNormal = getNormal( In.texCoord.xy);
	const float3 Normal = float3(0,0,1);	//tangent space normal vector 
	
	// MATRIX
	// -----------------------------------------------------------------------------------------------------------
	//this code was added by the World Space Transform Node 
	const float3 Nn = normalize(In.worldNormal); 		//input the vectors required for tangent to world space transform 
	const float3 Tn = normalize(In.worldTangent); 
	const float3 Bn = normalize(In.worldBinormal); 
	#ifdef YUP 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Tn ) + ( finalNormal.y * -Bn); 
	#else 
		float3 finalNormal_ws = ( Nn * finalNormal.z ) + (finalNormal.x * Bn ) + ( finalNormal.y * -Tn); 
	#endif 
	
	
	// -----------------------------------------------------------------------------------------------------------
	// Lit Sphere
	float3 finalLitSphere = black;
	finalLitSphere = getLitSphere(finalNormal_ws);
	
	
	
	// -----------------------------------------------------------------------------------------------------------
	// MIXING
	float4 ret = float4(1,1,1,1); 
	
	ret.rgb = finalLitSphere * 0.5f; // *0.3f to fix max dxsas pass blending bug (* 1/ passcount)
	
	// opacity
	ret.a = finalOpacity; 
	
	
	return saturate(ret); 
} 



// ###################################



technique TwoPass
{
	
	pass p0  
    {		 
		VertexShader = compile vs_3_0 v3L(); 
	    
		ZEnable = true; 
		ZWriteEnable = true; 
	    
		CullMode = cw; 
		ShadeMode = Gouraud;
	    
		AlphaBlendEnable = true; 
		AlphaTestEnable = FALSE; 
	    
		SrcBlend = SrcAlpha; 
		DestBlend = InvSrcAlpha; 
	    		
		PixelShader = compile ps_3_0 f3L(); 
	}  
	
	pass p1  
    {		 
		VertexShader = compile vs_3_0 v3L(); 
	    
		ZEnable = true; 
		ZWriteEnable = true; 
		ZFunc = LessEqual; 
	    
		CullMode = cw; 
		ShadeMode = Gouraud;
	    
		AlphaBlendEnable = true; 
		AlphaTestEnable = FALSE; 
	    
		SrcBlend = SrcAlpha; //SrcAlpha; //Zero; 
		DestBlend = One; //One; //SrcColor
		
	    
		PixelShader = compile ps_3_0 fAddons(); 
	}  
	
	
}
  


technique PassPerLight 
{  
	
	pass ambient  
    {		 
		VertexShader = compile vs_3_0 av(light1Pos, light1Type/*, light1Dir*/); 
	    
		ZEnable = true; 
		ZWriteEnable = true; 
	    
		CullMode = cw; 
		ShadeMode = Gouraud;
	    
		AlphaBlendEnable = true; 
		AlphaTestEnable = FALSE; 
	    
		SrcBlend = SrcAlpha; 
		DestBlend = InvSrcAlpha; 
	    		
		PixelShader = compile ps_3_0 af(/*light1Dir,*/ light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

	pass light1  
    {		 
		VertexShader = compile vs_3_0 v(light1Pos, light1Type/*, light1Dir*/); 
	    
		ZEnable = true; 
		ZWriteEnable = true;
		ZFunc = LessEqual; 
	    
		CullMode = cw; 
		ShadeMode = Gouraud;
	    
		AlphaBlendEnable = true; 
		AlphaTestEnable = FALSE;
		
		SrcBlend = SrcAlpha; 
		DestBlend = One; 
		 
		PixelShader = compile ps_3_0 f(/*light1Dir,*/ light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

	pass light2  
	{		 
		VertexShader = compile vs_3_0 v(light2Pos, light2Type/*, light2Dir*/); 
		
		ZEnable = true; 
		ZWriteEnable = false; 
		ZFunc = LessEqual; 
		
		CullMode = cw; 
		ShadeMode = Gouraud;
		
		AlphaBlendEnable = true; 
		AlphaTestEnable = false; 
		
		
		SrcBlend = SrcAlpha; 
		DestBlend = One; 
		//BlendOp = Add;
		
		PixelShader = compile ps_3_0 f(/*light2Dir,*/ light2Color, light2Attenuation, light2Hotspot, light2Falloff, light2Type, light2attenType, light2coneType, light2CastShadows, 2); 
	}  

	pass light3  
	{		 
		VertexShader = compile vs_3_0 v(light3Pos, light3Type/*, light3Dir*/); 
		ZEnable = true; 
		ZWriteEnable = false; 
		ZFunc = LessEqual; 
		
		CullMode = cw; 
		ShadeMode = Gouraud;
		
		AlphaBlendEnable = true; 
		AlphaTestEnable = FALSE; 
		
		SrcBlend = SrcAlpha;  // One  Zero    SrcColor  DestColor     SrcAlpha     InvSrcAlpha InvDestAlpha
		DestBlend = One; 
		
		PixelShader = compile ps_3_0 f(/*light3Dir,*/ light3Color, light3Attenuation, light3Hotspot, light3Falloff, light3Type, light3attenType, light3coneType, light3CastShadows, 3); 
	}  

}    