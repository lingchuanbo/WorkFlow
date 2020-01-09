/***************************************************************************************************
Copyright (C) 2013 - 2017  Gavyn Thompson

This program is free software: you can redistribute it and/or modify
it under the terms of the GNU General Public License as published by
the Free Software Foundation; either version 3 of the License, or
(at your option) any later version.

This program is distributed in the hope that it will be useful,
but WITHOUT ANY WARRANTY; without even the implied warranty of
MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
GNU General Public License for more details.

You should have received a copy of the GNU General Public License
along with this program. if not, see <http://www.gnu.org/licenses/>.
***************************************************************************************************/
/***************************************************************************************************
Author:				    Gavyn Thompson
Company:				GTVFX
Website:				https://github.com/gtvfx
Email:				    gftvfx@gmail.com
ScriptVersion:			
Updated:				
[Purpose]

***************************************************************************************************/
/*
__HELP__

Constructor: GetBitmapMinMaxPixels
Instantiated Global: GetBitmapMinMaxPixels

Methods:
	FromFile <path to file>

Example:
	minmax = GetBitmapMinMaxPixels.FromFile <Path to image file>
	
__END__
*/

mxs.Using "EventTimer"

struct GetBitmapMinMaxPixels
(
public

	cClass,
	
	fn GetCSharpStr = (),
	fn InitDotNetClass = (),
	
	fn FromFile mapFile =
	(
		if not ( DoesFileExist mapFile ) then
		(
			local str = StringStream ""
			format "Could not find image file at:\n%\n" mapFile to:str
			messageBox ( str as string ) title:"File Error:"
			return undefined
		)
		
		if ( this.cClass != undefined ) then
		(
			local calcTime = ::EventTimer caption:"Per Pixel Line Min/Max Processing"
			
			local tmp = bitmaptexture filename:mapFile
				
			local minmax = this.cClass.getMinMaxPixels ( dotnet.ValueToDotNetObject ( Gethandlebyanim tmp ) ( dotnetclass "System.UIntptr" ) )
			
			calcTime.End()
			
			minmax
		)
	),
	
	fn GetModule =
	(
		( GetSourceFileName() )
	),
	
	fn Help =
	(
		::_ilmLibrary.GetScriptHelp ( GetSourceFileName() )
	),

private
	
	fn GetCSharpStr =
	(
		local classStr = "
using System;
using Autodesk.Max;
using Autodesk.Max.Wrappers;
using System.Runtime.InteropServices;

struct pixelColor //stand in struct to use w/marshal
{
	public float R;
	public float G;
	public float B;
	public float A;
}

class GetMinMaxPixels
{
	public unsafe static float[] getMinMaxPixels (System.UIntPtr handle)
	{
		float min = 1000000;
		float max = -1000000;
		
		BitmapTex tex = (BitmapTex)GlobalInterface.Instance.Animatable.GetAnimByHandle(handle);
		IBitmap bmp = tex.GetBitmap(0);
		
		__Global.IGlobalBMM_Color_fl ctr = new __Global.__GlobalBMM_Color_fl();
		
		int structSize = sizeof(float)*4; //BMM_Color_fl has 4 floats RGBA as main parameters

		int wid = bmp.Width;
		int hei = bmp.Height;
		
		IntPtr pointer = Marshal.AllocHGlobal(structSize*wid);
		IBMM_Color_fl line = ctr.Marshal(pointer);
	   
		for (int i = 0; i < hei; i++)
		{
			bmp.GetPixels(0, i, wid, line);
			
			for (int j = 0; j < wid; j++)
			{
				IntPtr ptr = new IntPtr(pointer.ToInt64() + j * structSize);
				pixelColor* px = (pixelColor*)ptr;
				
				float val = ((*px).R*.3f + (*px).G*.59f + (*px).B*.11f);
				min = Math.Min(min, val);
				max = Math.Max(max, val);
			}
		}
		
		Marshal.FreeHGlobal(pointer);
		
		return new float[]{min, max};
	}
}
		"
		
		classStr
	),
	
	fn InitDotNetClass =
	(
		local compilerParams = dotnetobject "System.CodeDom.Compiler.CompilerParameters"
		dotnet.setlifetimecontrol compilerParams #dotnet
			
		compilerParams.CompilerOptions = "/unsafe"
		compilerParams.ReferencedAssemblies.Add ("System.dll")
		compilerParams.ReferencedAssemblies.Add ("System.Drawing.dll")
		compilerParams.ReferencedAssemblies.Add ((getdir #maxroot) + @"Autodesk.Max.dll")
		compilerParams.ReferencedAssemblies.Add ((getdir #maxroot) + @"\bin\assemblies\Autodesk.Max.Wrappers.dll")
		compilerParams.ReferencedAssemblies.Add ((getdir #maxroot)+ @"ManagedServices.dll")
		compilerParams.ReferencedAssemblies.Add ((getdir #maxroot)+ @"MaxCustomControls.dll")
		compilerParams.GenerateInMemory = on
			
		local csharpProvider = dotnetobject "Microsoft.CSharp.CSharpCodeProvider"
			
		local compilerResults = csharpProvider.CompileAssemblyFromSource compilerParams #( ( this.GetCSharpStr() ) )
		dotnet.setlifetimecontrol compilerResults #dotnet
		
		if ( compilerResults.Errors.Count > 0 ) then
		(		
			local errs = stringstream ""
			for i = 0 to (compilerResults.Errors.Count-1) do
			(
				local err = compilerResults.Errors.Item[i]
				format "Error:% Line:% Column:% %\n" err.ErrorNumber err.Line err.Column err.ErrorText to:errs
			)
			--format "%\n" errs
			throw errs
			return undefined
		)
		
		format "***** C# Class Initialized *****\n"
		
		( dotnetclass "GetMinMaxPixels" )
	),

	fn _init =
	(
		if ( ( MaxVersion() )[1] >= 18000 ) then -- Check if the 3dsmax version is at least 3dsmax 2016, C# SDK is different in older versions
		(
			this.cClass = this.InitDotNetClass()
		)
		else
		(
			messageBox "This module is not compatible with 3dsmax versions prior to 2016" title:"Max Version:"
		)
	),

	__init__ = _init()
)

GetBitmapMinMaxPixels = GetBitmapMinMaxPixels()
-- minmax = GetBitmapMinMaxPixels.FromFile <Path to image file>

/*
minmax = GetBitmapMinMaxPixels.FromFile @"C:\_cache\_scripts\Mark Williams\scripts\showTools\vray\images\settao_valley_lat_long.v01.exr"



*/
