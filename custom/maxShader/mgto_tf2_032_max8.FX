
/*** Generated through Lumonix shaderFX  by: till 'rollin' maginot _ till.maginot.eu _ 08.2009   ***/ 

/*** TF2 Shader v0.32 ***/

// This FX shader was built to support 3ds Max's DXSAS shader compiler. 
string ParamID = "0x000001";	// this string tells 3ds Max to use the DXSAS compiler 
 



/*============================================================================
 ============= FullMaterial TECHNIQUE ============= 
============================================================================*/


float UIConst_ambientCube
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 3.0;
	float UIStep = 0.1;
	string UIName = "_CubemapStrength";
> = 0.1;
 
texture NormalMap : NormalMap
<
	string ResourceName = "pyro_normal.jpg";
	string UIName = "NormalMap";
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
 
float4x4 worldIT : WorldInverseTranspose < string UIWidget = "None"; >;  
float4x4 viewInv : ViewInverse < string UIWidget = "None"; >;  
float4x4 world : World < string UIWidget = "None"; >;  
texture UICubeMap_ambientCube : environment
<
	string ResourceName = "c_bensBackyard16D.dds";
	string UIName = "AmbientCube";
	string ResourceType = "Cube";
>;
 
samplerCUBE UICubeMap_ambientCubeSampler = sampler_state
{
	Texture = <UICubeMap_ambientCube>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
};
 
texture TextureMap_6745
<
	string ResourceName = "tmp_flat_black.jpg";
	string UIName = "_AmbientCubeMask";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_6745Sampler = sampler_state
{
	Texture = <TextureMap_6745>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
texture TextureMap_glowmap
<
	string ResourceName = "";
	string UIName = "_GlowMap";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_glowmapSampler = sampler_state
{
	Texture = <TextureMap_glowmap>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
bool UIBool_3552
<
	string UIName = "UseVertexColors";
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

texture TextureMap_9908 : DiffuseMap
<
	string ResourceName = "pyro_red.jpg";
	string UIName = "DiffuseMap";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_9908Sampler = sampler_state
{
	Texture = <TextureMap_9908>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
texture RAMP_TextureMap_3124
<
	string ResourceName = "ramp_tf2.jpg";
	string UIName = "RampTexture";
	string ResourceType = "2D";
>;
 
sampler2D RAMP_TextureMap_3124Sampler = sampler_state
{
	Texture = <RAMP_TextureMap_3124>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = CLAMP;
	AddressV = CLAMP;
};
 
float UIConst_2_ramp
<
	string UIWidget = "Spinner";
	float UIMin = -100.0;
	float UIMax = 100.0;
	float UIStep = 1.0;
	string UIName = "_RampContrast";
> = 2.0;
 
texture TextureMap_8266
<
	string ResourceName = "pyro_exponent.jpg";
	string UIName = "ExponentMap";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_8266Sampler = sampler_state
{
	Texture = <TextureMap_8266>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
float UIConst_9564
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "_ExponentBoost";
> = 1.0;
 
float UIConst_7954
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "SpecFresnelTerm";
> = 2.0;
 
float UIConst_6206
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "RimlightExponent";
> = 1.0;
 
float UIConst_4557
<
	string UIWidget = "Spinner";
	float UIMin = -999.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "_RimlightMask";
> = 10.0;
 
texture TextureMap_7698
<
	string ResourceName = "pyro_spec.jpg";
	string UIName = "SpecMap";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_7698Sampler = sampler_state
{
	Texture = <TextureMap_7698>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
float UIConst_3414
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "SpecBoost";
> = 1.0;
 
float3 UIColor_1020
<
	string UIName = "RimAmbientColor";
	string UIWidget = "Color";
> = {1.0f, 1.0f, 1.0f };
 
float UIConst_5741
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 999.0;
	float UIStep = 0.1;
	string UIName = "RimBoost";
> = 1.0;
 
float GlobalShadingBias
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
	float UIStep = 0.1;
	string UIName = "_global_ShadingBias";
> = 0.3;
 
float UIConst_globalSaturation
<
	string UIWidget = "Spinner";
	float UIMin = 0.0;
	float UIMax = 1.0;
	float UIStep = 0.1;
	string UIName = "_global_Saturation";
> = 0.6;
 
texture TextureMap_9272
<
	string ResourceName = "darFly_body_A_01.tga";
	string UIName = "_OpacityMap_(alphaChannel)";
	string ResourceType = "2D";
>;
 
sampler2D TextureMap_9272Sampler = sampler_state
{
	Texture = <TextureMap_9272>;
	MinFilter = LINEAR;
	MagFilter = LINEAR;
	MipFilter = LINEAR;
	AddressU = WRAP;
	AddressV = WRAP;
};
 
// this function does the different types of light attenuation 
float attenuation_funcT1(int lightattenType, float4 lightAttenuation, float3 lightVec) 
{ 
	float att = 1.0; 
	return att; 
} 
	 
// this function does the different types of cone angle 
float coneangle_funcT1(int lightconeType, float lightHotspot, float lightFalloff, float3 lightVec, float3 lightDir) 
{ 
	float cone = 1.0; 
	return cone; 
} 

/************** light info **************/ 

float3 light1Dir : Direction 
< 
	string UIName = "Light 1 Direction"; 
	string Object = "TargetLight"; 
	string Space = "World"; 
		int refID = 1; 
> = {100.0f, 100.0f, 100.0f}; 

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
#define light1CastShadows false

//---------------------------------- 


float4x4 wvp : WorldViewProjection < string UIWidget = "None"; >;  
float4x4 worldI : WorldInverse < string UIWidget = "None"; >;  
// create the light vector 
float3 lightVec_funcT1(float3 worldSpacePos, float3 lightVector, float3x3 objTangentXf, int lightType) 
{ 
	float3 lightVec = mul(objTangentXf, (mul((lightVector - worldSpacePos), worldI).xyz)); 
	return lightVec; 
} 

// input from application 
	struct a2vT1 { 
	float4 position		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
	float4 tangent		: TANGENT; 
	float4 binormal		: BINORMAL; 
	float4 normal		: NORMAL; 
	float3 vertcol		: TEXCOORD3; 
	float vertalpha 	: TEXCOORD4; 

}; 

// output to fragment program 
struct v2fT1 { 
        float4 position    		: POSITION; 

		float2 texCoord			: TEXCOORD0; 
        float3 worldTangent  	: TEXCOORD1; 
        float3 worldBinormal 	: TEXCOORD2; 
        float3 worldNormal   	: TEXCOORD3; 
        float3 viewDir	    	: TEXCOORD4; 
        float4 color    		: COLOR0; 
        float3 lightVec    		: TEXCOORD5; 
        float3 eyeVec	    	: TEXCOORD6; 

}; 

// Ambient Pass Vertex Shader: 
v2fT1 avT1(a2vT1 In, uniform float3 lightPos, uniform int lightType, uniform float3 lightDir) 
{ 
	v2fT1 Out = (v2fT1)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	In.texCoord.y += 1.0f;		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
	//this code was added by the World Space Transform Node 
	Out.worldNormal = mul(In.normal, worldIT).xyz;		//compute world space normal 
	Out.worldBinormal = mul(In.binormal, worldIT).xyz;	//compute world space binormal 
	Out.worldTangent = mul(In.tangent, worldIT).xyz;		//compute world space tangent 
	Out.viewDir = mul(In.position, world) - viewInv[3]; 
	//this code was added by the Vertex Color Node 
	float4 VertColor = float4(In.vertcol.rgb, In.vertalpha.r); 
	Out.color = VertColor; 


	return Out; 
} 

// Ambient Pass Pixel Shader: 
float4 afT1(v2fT1 In, uniform float3 lightDir, uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 

	float4 NormalMap = tex2D(NormalMapSampler, In.texCoord.xy);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	//this code was added by the World Space Transform Node 
	float3 Nn = normalize(In.worldNormal); 		//input the vectors required for tangent to world space transform 
	float3 Tn = normalize(In.worldTangent); 
	float3 Bn = normalize(In.worldBinormal); 
	#ifdef YUP 
		float3 MathWorldXform_ambientCube = ( Nn * NormalMap.rgb.z ) + (NormalMap.rgb.x * Tn ) + ( NormalMap.rgb.y * -Bn); 
	#else 
		float3 MathWorldXform_ambientCube = ( Nn * NormalMap.rgb.z ) + (NormalMap.rgb.x * Bn ) + ( NormalMap.rgb.y * -Tn); 
	#endif 
	float3 MathReflect_ambientCube = reflect(In.viewDir, MathWorldXform_ambientCube);		//Compute the reflection vector 
	float3 UICubeMap_ambientCubeInputVector = MathReflect_ambientCube.xyz;
	#ifdef YUP 
	#else 
	UICubeMap_ambientCubeInputVector.xyz = UICubeMap_ambientCubeInputVector.xzy;  //swizzle required for Max 
	#endif 
	float4 UICubeMap_ambientCube = texCUBE(UICubeMap_ambientCubeSampler, UICubeMap_ambientCubeInputVector);
	float3 MathOperator_212 = UIConst_ambientCube * UICubeMap_ambientCube.rgb;
	float4 TextureMap_6745 = tex2D(TextureMap_6745Sampler, In.texCoord.xy);
	float MathOperator_8047 = 1.0 - TextureMap_6745.r;
	float3 finalAmbientcubeTree = MathOperator_212 * MathOperator_8047;
	float4 TextureMap_glowmap = tex2D(TextureMap_glowmapSampler, In.texCoord.xy);
	float3 MathOperator_addGlow = finalAmbientcubeTree + TextureMap_glowmap.rgb;
	float UIConst_8960 = 1.0; 
	float4 INVertColor_2598 = In.color; 		//bringing in the vertex color 
	float3 UIColor_6440 = float3(1.0f, 1.0f, 1.0f );
	float3 MathIf_3607;
	if (UIBool_3552 == UIConst_8960) MathIf_3607 = INVertColor_2598.rgb; else MathIf_3607 = UIColor_6440.rgb; 
	float4 TextureMap_9908 = tex2D(TextureMap_9908Sampler, In.texCoord.xy);
	float3 MathOperator_8633 = MathIf_3607 * TextureMap_9908.rgb;
	float3 MathBrightnessContrast_1928 = (MathOperator_8633 - 0.5) * 1.1 + 0.5 + -0.1;
	float3 MathOperator_434 = MathBrightnessContrast_1928 * 1.0;
	float3 MathOp_ambientrimlight = MathOperator_addGlow + MathOperator_434;
	float3 input1 = MathOp_ambientrimlight; 
	float4 TextureMap_9272 = tex2D(TextureMap_9272Sampler, In.texCoord.xy);
	float input3 = TextureMap_9272.a; 

	float4 ret =  float4(input1, 1); 
	ret.a = input3 ; 
	return ret; 
} 

// Vertex Shader: 
v2fT1 vT1(a2vT1 In, uniform float3 lightPos, uniform int lightType, uniform float3 lightDir) 
{ 
	v2fT1 Out = (v2fT1)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	//this code was added by the Vertex Color Node 
	float4 VertColor = float4(In.vertcol.rgb, In.vertalpha.r); 
	Out.color = VertColor; 

	In.texCoord.y += 1.0f;		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
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
	float3 wsLVec = lightPos - wsLPos;    //cast a ray to the light 
	float3 osLVec = mul(wsLVec, worldI).xyz;  //transform the world space light vector to object space 
	Out.lightVec = mul(objTangentXf, osLVec);			//tangent space light vector passed out 
	//these three lines were added by the Eye Vector Node 
	float4 osIPos = mul(viewInv[3], worldI);			//put world space eye position in object space 
	float3 osIVec = osIPos.xyz - In.position.xyz;		//object space eye vector 
	Out.eyeVec = mul(objTangentXf, osIVec);				//tangent space eye vector passed out 

	return Out; 
} 

// Pixel Shader: 
float4 fT1(v2fT1 In, uniform float3 lightDir, uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 

	float UIConst_8960 = 1.0; 
	float4 INVertColor_2598 = In.color; 		//bringing in the vertex color 
	float3 UIColor_6440 = float3(1.0f, 1.0f, 1.0f );
	float3 MathIf_3607;
	if (UIBool_3552 == UIConst_8960) MathIf_3607 = INVertColor_2598.rgb; else MathIf_3607 = UIColor_6440.rgb; 
	float4 TextureMap_9908 = tex2D(TextureMap_9908Sampler, In.texCoord.xy);
	float3 MathOperator_8633 = MathIf_3607 * TextureMap_9908.rgb;
	float4 NormalMap = tex2D(NormalMapSampler, In.texCoord.xy);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	float halfLambertExponent = 1.0; 
	float3 L = normalize(In.lightVec.xyz);	//normalized light vector 
	float NdotL_dif = dot(L,NormalMap.rgb);		//dot product 
	float ZeroPointFive = 0.5; 
	float ScalePoint5 = NdotL_dif * ZeroPointFive;
	float BiasPoint5 = ScalePoint5 + ZeroPointFive;
	float MathPow_8093 = pow(BiasPoint5,halfLambertExponent);		//x to the power of y 
	float2 MathVecConstuct_1551 = float2(MathPow_8093, MathPow_8093);
	float4 RAMP_TextureMap_3124 = tex2D(RAMP_TextureMap_3124Sampler, MathVecConstuct_1551.xy);
	float3 MathOperator_4504 = RAMP_TextureMap_3124.rgb * UIConst_2_ramp;
	float UIConst_5915 = 1.0; 
	float3 MathOperator_2655 = lightColor.rgb * UIConst_5915;
	float3 finalRampTree = MathOperator_4504 * MathOperator_2655;
	float3 MathOp_multDiffuseRamp = MathOperator_8633 * finalRampTree;
	float MathDotProduct_8392 = saturate(dot(NormalMap.rgb,L)); 		//clamped dot product 
	float UIConst_4383 = 1.0; 
	float MathOperator_336 = MathDotProduct_8392 * UIConst_4383;
	float3 MathOperator_7960 = NormalMap.rgb * MathOperator_336;
	float3 V = normalize(In.eyeVec.xyz);		//normalized eye vector 
	float MathDotProduct_7124 = saturate(dot(MathOperator_7960,V)); 		//clamped dot product 
	float4 TextureMap_8266 = tex2D(TextureMap_8266Sampler, In.texCoord.xy);
	float UIConst_7909 = 2.0; 
	float MathOperator_7865 = TextureMap_8266.r * UIConst_7909;
	float UIConst_3875 = 20.0; 
	float MathOperator_7835 = MathOperator_7865 + UIConst_3875;
	float MathOperator_2649 = MathOperator_7835 * UIConst_9564;
	float MathPow_2079 = pow(MathDotProduct_7124,MathOperator_2649);		//x to the power of y 
	float MathOperator_4910 = MathPow_2079 * UIConst_7954;
	float MathPow_545 = pow(MathDotProduct_7124,UIConst_6206);		//x to the power of y 
	float UIConst_7554 = 1.0; 
	float MathDotProduct_4855 = saturate(dot(V,NormalMap.rgb)); 		//clamped dot product 
	float MathOperator_5445 = UIConst_7554 - MathDotProduct_4855;
	float UIConst_7415 = 4.0; 
	float MathPow_7183 = pow(MathOperator_5445,UIConst_7415);		//x to the power of y 
	float MathOperator_5637 = 1.0 * UIConst_4557;
	float MathOperator_801 = MathPow_7183 * MathOperator_5637;
	float MathOperator_9791 = MathPow_545 * MathOperator_801;
	float MathIf_361;
	if (MathOperator_4910 > MathOperator_9791) MathIf_361 = MathOperator_4910; else MathIf_361 = MathOperator_9791; 
	float4 TextureMap_7698 = tex2D(TextureMap_7698Sampler, In.texCoord.xy);
	float MathOperator_6772 = TextureMap_7698.r + 0.1;
	float3 MathOperator_6685 = MathOperator_6772 * lightColor.rgb;
	float3 MathOperator_4112 = MathIf_361 * MathOperator_6685;
	float3 MathOperator_3549 = MathOperator_4112 * UIConst_3414;
	float UIConst_7377 = 0.5; 
	float UIConst_4986 = 2.0; 
	float UIConst_3027 = 1.0; 
	float3 MathVecConstuct_2442 = float3(UIConst_7377, UIConst_4986, UIConst_3027);
	float MathDotProduct_9978 = saturate(dot(NormalMap.rgb,MathVecConstuct_2442)); 		//clamped dot product 
	float UIConst_7572 = 0.005; 
	float MathOperator_8558 = MathOperator_5637 * UIConst_7572;
	float MathOperator_3752 = MathDotProduct_9978 * MathOperator_8558;
	float MathOperator_6347 = MathOperator_801 * MathOperator_3752;
	float3 MathOperator_3621 = MathOperator_6347 * UIColor_1020.rgb;
	float3 MathOperator_88 = MathOperator_3621 * UIConst_5741;
	float3 MathOperator_579 = MathOperator_3549 + MathOperator_88;
	float3 MathOp_addSpec = MathOp_multDiffuseRamp + MathOperator_579;
	float3 MathOp_multLight = MathOp_addSpec * GlobalShadingBias;
	float3 InColor = MathOp_multLight;
	float UIConst_4466 = 0.3; 
	float mult_red = InColor.r * UIConst_4466;
	float UIConst_2278 = 0.59; 
	float mult_green = InColor.g * UIConst_2278;
	float add1 = mult_red + mult_green;
	float UIConst_2947 = 0.11; 
	float mult_blue = InColor.b * UIConst_2947;
	float add2 = add1 + mult_blue;
	float UIConst_7513 = 1.0; 
	float DivideByOne = add2 / UIConst_7513;
	float3 OutGrey = float3(DivideByOne, DivideByOne, DivideByOne);
	float3 Blend = lerp(OutGrey, MathOp_multLight, UIConst_globalSaturation); 
	float3 input2 = Blend; 
	float4 TextureMap_9272 = tex2D(TextureMap_9272Sampler, In.texCoord.xy);
	float input3 = TextureMap_9272.a; 

	float4 ret =  float4(input2, 1); 
	ret.a = input3 ; 
	return ret; 
} 

technique FullMaterial  
{  
	pass ambient  
    {		 
		VertexShader = compile vs_2_0 avT1(light1Pos, light1Type, light1Dir); 
		ZEnable = true; 
		ZWriteEnable = true; 
		CullMode = cw; 
		ShadeMode = Gouraud;
		AlphaBlendEnable = true; 
		SrcBlend = SrcAlpha; 
		DestBlend = InvSrcAlpha; 
		AlphaTestEnable = FALSE; 
		PixelShader = compile ps_2_0 afT1(light1Dir, light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

	pass light1  
    {		 
		VertexShader = compile vs_2_0 vT1(light1Pos, light1Type, light1Dir); 
		ZEnable = true; 
		CullMode = cw; 
		ShadeMode = Gouraud;
		AlphaBlendEnable = true; 
		ZWriteEnable = true; 
		ZFunc = LessEqual; 
		SrcBlend = SrcAlpha; 
		DestBlend = One; 
		AlphaTestEnable = FALSE; 
		PixelShader = compile ps_2_0 fT1(light1Dir, light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

}  



/*============================================================================
 ============= ramp_only TECHNIQUE ============= 
============================================================================*/



// create the light vector 
float3 lightVec_funcT2(float3 worldSpacePos, float3 lightVector, float3x3 objTangentXf, int lightType) 
{ 
	float3 lightVec = mul(objTangentXf, (mul((lightVector - worldSpacePos), worldI).xyz)); 
	return lightVec; 
} 

// input from application 
	struct a2vT2 { 
	float4 position		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
	float4 tangent		: TANGENT; 
	float4 binormal		: BINORMAL; 
	float4 normal		: NORMAL; 

}; 

// output to fragment program 
struct v2fT2 { 
        float4 position    		: POSITION; 

		float2 texCoord			: TEXCOORD0; 
        float3 lightVec    		: TEXCOORD1; 

}; 

// Vertex Shader: 
v2fT2 vT2(a2vT2 In, uniform float3 lightPos, uniform int lightType, uniform float3 lightDir) 
{ 
	v2fT2 Out = (v2fT2)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	In.texCoord.y += 1.0f;		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
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
	float3 wsLVec = lightPos - wsLPos;    //cast a ray to the light 
	float3 osLVec = mul(wsLVec, worldI).xyz;  //transform the world space light vector to object space 
	Out.lightVec = mul(objTangentXf, osLVec);			//tangent space light vector passed out 

	return Out; 
} 

// Pixel Shader: 
float4 fT2(v2fT2 In, uniform float3 lightDir, uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 

	float4 NormalMap = tex2D(NormalMapSampler, In.texCoord.xy);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	float halfLambertExponent = 1.0; 
	float3 L = normalize(In.lightVec.xyz);	//normalized light vector 
	float NdotL_dif = dot(L,NormalMap.rgb);		//dot product 
	float ZeroPointFive = 0.5; 
	float ScalePoint5 = NdotL_dif * ZeroPointFive;
	float BiasPoint5 = ScalePoint5 + ZeroPointFive;
	float MathPow_8093 = pow(BiasPoint5,halfLambertExponent);		//x to the power of y 
	float2 MathVecConstuct_1551 = float2(MathPow_8093, MathPow_8093);
	float4 RAMP_TextureMap_3124 = tex2D(RAMP_TextureMap_3124Sampler, MathVecConstuct_1551.xy);
	float3 MathOperator_4504 = RAMP_TextureMap_3124.rgb * UIConst_2_ramp;
	float UIConst_5915 = 1.0; 
	float3 MathOperator_2655 = lightColor.rgb * UIConst_5915;
	float3 finalRampTree = MathOperator_4504 * MathOperator_2655;
	float3 MathOp_8487_debug = finalRampTree * 1.0;
	float3 input2 = MathOp_8487_debug; 

	float4 ret =  float4(input2, 1); 
	return ret; 
} 

technique ramp_only  
{  
	pass light1  
    {		 
		VertexShader = compile vs_2_0 vT2(light1Pos, light1Type, light1Dir); 
		ZEnable = true; 
		ZWriteEnable = true; 
		CullMode = cw; 
		ShadeMode = Gouraud;
		AlphaBlendEnable = false; 
		AlphaTestEnable = FALSE; 
		PixelShader = compile ps_2_0 fT2(light1Dir, light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

}  



/*============================================================================
 ============= Spec_only_TEST TECHNIQUE ============= 
============================================================================*/



// create the light vector 
float3 lightVec_funcT3(float3 worldSpacePos, float3 lightVector, float3x3 objTangentXf, int lightType) 
{ 
	float3 lightVec = mul(objTangentXf, (mul((lightVector - worldSpacePos), worldI).xyz)); 
	return lightVec; 
} 

// input from application 
	struct a2vT3 { 
	float4 position		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
	float4 tangent		: TANGENT; 
	float4 binormal		: BINORMAL; 
	float4 normal		: NORMAL; 

}; 

// output to fragment program 
struct v2fT3 { 
        float4 position    		: POSITION; 

		float2 texCoord			: TEXCOORD0; 
        float3 lightVec    		: TEXCOORD1; 
        float3 eyeVec	    	: TEXCOORD2; 

}; 

// Vertex Shader: 
v2fT3 vT3(a2vT3 In, uniform float3 lightPos, uniform int lightType, uniform float3 lightDir) 
{ 
	v2fT3 Out = (v2fT3)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	In.texCoord.y += 1.0f;		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
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
	float3 wsLVec = lightPos - wsLPos;    //cast a ray to the light 
	float3 osLVec = mul(wsLVec, worldI).xyz;  //transform the world space light vector to object space 
	Out.lightVec = mul(objTangentXf, osLVec);			//tangent space light vector passed out 
	//these three lines were added by the Eye Vector Node 
	float4 osIPos = mul(viewInv[3], worldI);			//put world space eye position in object space 
	float3 osIVec = osIPos.xyz - In.position.xyz;		//object space eye vector 
	Out.eyeVec = mul(objTangentXf, osIVec);				//tangent space eye vector passed out 

	return Out; 
} 

// Pixel Shader: 
float4 fT3(v2fT3 In, uniform float3 lightDir, uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 

	float4 NormalMap = tex2D(NormalMapSampler, In.texCoord.xy);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	float3 L = normalize(In.lightVec.xyz);	//normalized light vector 
	float MathDotProduct_8392 = saturate(dot(NormalMap.rgb,L)); 		//clamped dot product 
	float UIConst_4383 = 1.0; 
	float MathOperator_336 = MathDotProduct_8392 * UIConst_4383;
	float3 MathOperator_7960 = NormalMap.rgb * MathOperator_336;
	float3 V = normalize(In.eyeVec.xyz);		//normalized eye vector 
	float MathDotProduct_7124 = saturate(dot(MathOperator_7960,V)); 		//clamped dot product 
	float4 TextureMap_8266 = tex2D(TextureMap_8266Sampler, In.texCoord.xy);
	float UIConst_7909 = 2.0; 
	float MathOperator_7865 = TextureMap_8266.r * UIConst_7909;
	float UIConst_3875 = 20.0; 
	float MathOperator_7835 = MathOperator_7865 + UIConst_3875;
	float MathOperator_2649 = MathOperator_7835 * UIConst_9564;
	float MathPow_2079 = pow(MathDotProduct_7124,MathOperator_2649);		//x to the power of y 
	float MathOperator_4910 = MathPow_2079 * UIConst_7954;
	float MathPow_545 = pow(MathDotProduct_7124,UIConst_6206);		//x to the power of y 
	float UIConst_7554 = 1.0; 
	float MathDotProduct_4855 = saturate(dot(V,NormalMap.rgb)); 		//clamped dot product 
	float MathOperator_5445 = UIConst_7554 - MathDotProduct_4855;
	float UIConst_7415 = 4.0; 
	float MathPow_7183 = pow(MathOperator_5445,UIConst_7415);		//x to the power of y 
	float MathOperator_5637 = 1.0 * UIConst_4557;
	float MathOperator_801 = MathPow_7183 * MathOperator_5637;
	float MathOperator_9791 = MathPow_545 * MathOperator_801;
	float MathIf_361;
	if (MathOperator_4910 > MathOperator_9791) MathIf_361 = MathOperator_4910; else MathIf_361 = MathOperator_9791; 
	float4 TextureMap_7698 = tex2D(TextureMap_7698Sampler, In.texCoord.xy);
	float MathOperator_6772 = TextureMap_7698.r + 0.1;
	float3 MathOperator_6685 = MathOperator_6772 * lightColor.rgb;
	float3 MathOperator_4112 = MathIf_361 * MathOperator_6685;
	float3 MathOperator_3549 = MathOperator_4112 * UIConst_3414;
	float UIConst_7377 = 0.5; 
	float UIConst_4986 = 2.0; 
	float UIConst_3027 = 1.0; 
	float3 MathVecConstuct_2442 = float3(UIConst_7377, UIConst_4986, UIConst_3027);
	float MathDotProduct_9978 = saturate(dot(NormalMap.rgb,MathVecConstuct_2442)); 		//clamped dot product 
	float UIConst_7572 = 0.005; 
	float MathOperator_8558 = MathOperator_5637 * UIConst_7572;
	float MathOperator_3752 = MathDotProduct_9978 * MathOperator_8558;
	float MathOperator_6347 = MathOperator_801 * MathOperator_3752;
	float3 MathOperator_3621 = MathOperator_6347 * UIColor_1020.rgb;
	float3 MathOperator_88 = MathOperator_3621 * UIConst_5741;
	float3 MathOperator_579 = MathOperator_3549 + MathOperator_88;
	float3 MathOp_5114_debug = MathOperator_579 * 1.0;
	float3 input2 = MathOp_5114_debug; 

	float4 ret =  float4(input2, 1); 
	return ret; 
} 

technique Spec_only_TEST  
{  
	pass light1  
    {		 
		VertexShader = compile vs_2_0 vT3(light1Pos, light1Type, light1Dir); 
		ZEnable = true; 
		ZWriteEnable = true; 
		CullMode = cw; 
		ShadeMode = Gouraud;
		AlphaBlendEnable = false; 
		AlphaTestEnable = FALSE; 
		PixelShader = compile ps_2_0 fT3(light1Dir, light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

}  



/*============================================================================
 ============= cubemap_only TECHNIQUE ============= 
============================================================================*/



// create the light vector 
float3 lightVec_funcT5(float3 worldSpacePos, float3 lightVector, float3x3 objTangentXf, int lightType) 
{ 
	float3 lightVec = mul(objTangentXf, (mul((lightVector - worldSpacePos), worldI).xyz)); 
	return lightVec; 
} 

// input from application 
	struct a2vT5 { 
	float4 position		: POSITION; 

	float2 texCoord		: TEXCOORD0; 
	float4 tangent		: TANGENT; 
	float4 binormal		: BINORMAL; 
	float4 normal		: NORMAL; 

}; 

// output to fragment program 
struct v2fT5 { 
        float4 position    		: POSITION; 

		float2 texCoord			: TEXCOORD0; 
        float3 worldTangent  	: TEXCOORD1; 
        float3 worldBinormal 	: TEXCOORD2; 
        float3 worldNormal   	: TEXCOORD3; 
        float3 viewDir	    	: TEXCOORD4; 

}; 

// Vertex Shader: 
v2fT5 vT5(a2vT5 In, uniform float3 lightPos, uniform int lightType, uniform float3 lightDir) 
{ 
	v2fT5 Out = (v2fT5)0; 
	Out.position = mul(In.position, wvp);				//transform vert position to homogeneous clip space 

	In.texCoord.y += 1.0f;		//this fixes Max's V texcoord which is off by one 
	Out.texCoord = In.texCoord;						//pass through texture coordinates from channel 1 
	//this code was added by the World Space Transform Node 
	Out.worldNormal = mul(In.normal, worldIT).xyz;		//compute world space normal 
	Out.worldBinormal = mul(In.binormal, worldIT).xyz;	//compute world space binormal 
	Out.worldTangent = mul(In.tangent, worldIT).xyz;		//compute world space tangent 
	Out.viewDir = mul(In.position, world) - viewInv[3]; 

	return Out; 
} 

// Pixel Shader: 
float4 fT5(v2fT5 In, uniform float3 lightDir, uniform float4 lightColor, uniform float4 lightAttenuation, uniform float lightHotspot, uniform float lightFalloff, uniform int lightType, uniform int lightattenType, uniform int lightconeType, uniform bool lightCastShadows, uniform int shadowPassCount) : COLOR 
{ 

	float4 NormalMap = tex2D(NormalMapSampler, In.texCoord.xy);
	NormalMap.xyz = NormalMap.xyz * 2 - 1;		//expand to -1 to 1 range 
	NormalMap.rgb = normalize(NormalMap.rgb); 		//normalized the normal vector 
	//this code was added by the World Space Transform Node 
	float3 Nn = normalize(In.worldNormal); 		//input the vectors required for tangent to world space transform 
	float3 Tn = normalize(In.worldTangent); 
	float3 Bn = normalize(In.worldBinormal); 
	#ifdef YUP 
		float3 MathWorldXform_ambientCube = ( Nn * NormalMap.rgb.z ) + (NormalMap.rgb.x * Tn ) + ( NormalMap.rgb.y * -Bn); 
	#else 
		float3 MathWorldXform_ambientCube = ( Nn * NormalMap.rgb.z ) + (NormalMap.rgb.x * Bn ) + ( NormalMap.rgb.y * -Tn); 
	#endif 
	float3 MathReflect_ambientCube = reflect(In.viewDir, MathWorldXform_ambientCube);		//Compute the reflection vector 
	float3 UICubeMap_ambientCubeInputVector = MathReflect_ambientCube.xyz;
	#ifdef YUP 
	#else 
	UICubeMap_ambientCubeInputVector.xyz = UICubeMap_ambientCubeInputVector.xzy;  //swizzle required for Max 
	#endif 
	float4 UICubeMap_ambientCube = texCUBE(UICubeMap_ambientCubeSampler, UICubeMap_ambientCubeInputVector);
	float3 MathOperator_212 = UIConst_ambientCube * UICubeMap_ambientCube.rgb;
	float4 TextureMap_6745 = tex2D(TextureMap_6745Sampler, In.texCoord.xy);
	float MathOperator_8047 = 1.0 - TextureMap_6745.r;
	float3 finalAmbientcubeTree = MathOperator_212 * MathOperator_8047;
	float3 MathOp_793_debug = finalAmbientcubeTree * 1.0;
	float3 input2 = MathOp_793_debug; 

	float4 ret =  float4(input2, 1); 
	return ret; 
} 

technique cubemap_only  
{  
	pass light1  
    {		 
		VertexShader = compile vs_2_0 vT5(light1Pos, light1Type, light1Dir); 
		ZEnable = true; 
		ZWriteEnable = true; 
		CullMode = cw; 
		ShadeMode = Gouraud;
		AlphaBlendEnable = false; 
		AlphaTestEnable = FALSE; 
		PixelShader = compile ps_2_0 fT5(light1Dir, light1Color, light1Attenuation, light1Hotspot, light1Falloff, light1Type, light1attenType, light1coneType, light1CastShadows, 1); 
	}  

}    