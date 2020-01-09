
::DisableWindowsGhosting = ""


mxs.using "Logger"


struct DisableWindowsGhosting
(
	/*DOC_--------------------------------------------------------------------
	This creates a DotNet Class that uses the C# compiler to communicate with 
	the user32.dll to disable Windows Ghosting for stalled applications.
	
	Members:
		[FN] DisableWindowsGhostingClass : Runs upon instantiation
	
	--------------------------------------------------------------------_END*/
	
	fn DisableWindowsGhostingClass =
	(
		/*DOC_--------------------------------------------------------------------
		Uses the DotNet C# compiler to create a class that can diable the Windows
		Ghosting behavior
		
		Returns:
			Boolean
		
		--------------------------------------------------------------------_END*/
		
		::Logger.info "Disabling Windows Ghosting" args:#() cls:this
		
		local out = undefined
		
		if ClassOf (dotnet.GetType "DisableWindowsGhosting") != dotNetObject then
		(
			local source = StringStream ("
			using System.Runtime.InteropServices;
			
			public class DisableWindowsGhosting
			{
			[DllImport(\"user32.dll\")]
			public static extern bool DisableProcessWindowsGhosting();
			}")
			
			local compilerParams = dotnetobject "System.CodeDom.Compiler.CompilerParameters"
			
			compilerParams.ReferencedAssemblies.Add("System.dll");
			compilerParams.GenerateInMemory = on
			
			local csharpProvider = dotnetobject "Microsoft.CSharp.CSharpCodeProvider"
			local compilerResults = csharpProvider.CompileAssemblyFromSource compilerParams #(source as String)
			
			flush source
			close source
			
			if (compilerResults.Errors.Count > 0 ) then
			(
				local errs = stringstream ""
				for i = 0 to (compilerResults.Errors.Count-1) do
				(
					local err = compilerResults.Errors.Item[i]
					format "Error:% Line:% Column:% %\n" err.ErrorNumber err.Line err.Column err.ErrorText to:errs
				)
				format "%\n" errs
				return False
			)
			else
			(
				out = compilerResults.CompiledAssembly.CreateInstance "DisableWindowsGhosting"
			)
			
		)
		else
		(
			out = dotnetobject "DisableWindowsGhosting"
		)
		
		out.DisableProcessWindowsGhosting()
		
		True
	),
	
	fn GetModule =
	(
		/*DOC_--------------------------------------------------------------------
		Get the full path to the current MaxScript file
	
		Returns:
			String
		--------------------------------------------------------------------_END*/
	
		( GetSourceFileName() )
	),
	
	fn Help _fn: =
	(
		/*DOC_--------------------------------------------------------------------
		Get help on the current module or a specific function
	
		Kwargs:
			_fn (string) : Name of the internal method as a string
	
		Returns:
			VOID
	
		--------------------------------------------------------------------_END*/
	
		::mxs.GetScriptHelp ( GetSourceFileName() ) _fn:_fn
	),
	
private
	
	fn _init =
	(
		/*DOC_--------------------------------------------------------------------
		This method is run upon instantiation of the struct
		
		Returns:
			(VOID)
		
		--------------------------------------------------------------------_END*/
		
		this.DisableWindowsGhostingClass()
	),
	
	__init__ = _init()
)

DisableWindowsGhosting = DisableWindowsGhosting()