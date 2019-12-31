Fn ReStartMax inputSecond = 
(
    local CSharpProvider,CompilerParams,CompilerResults,errorMessage
    CSharpCodeSource ="
    using System;
    using System.Diagnostics;
    using System.Threading;
    
    namespace Temp
    {
        static class Program
        {
            public static void Main(string[] args)
            {
                Thread.Sleep(" + ((inputSecond * 1000 ) as Integer) as string + ");
                Process.Start(@\""+ GetDir #MaxRoot + "3dsmax.exe" + "\");
            }
        }
    }
    "
    CSharpProvider = DotnetObject "Microsoft.CSharp.CSharpCodeProvider"
    CompilerParams = DotnetObject "System.CodeDom.Compiler.CompilerParameters"

    CompilerParams.ReferencedAssemblies.Add("System.dll")
    CompilerParams.GenerateExecutable = true
    CompilerParams.GenerateInMemory = false
    CompilerParams.OutputAssembly  = GetDir #MaxRoot + "ReStartMax.exe"
    CompilerParams.CompilerOptions  = "/target:winexe"
    CompilerResults = CSharpProvider.CompileAssemblyFromSource CompilerParams #(CSharpCodeSource)
    if CompilerResults.errors.HasErrors then
    (
        for i = 0 to CompilerResults.errors.count - 1 do
        (
            errorMessage =  (CompilerResults.errors.item i).line as string + ": " +  (CompilerResults.errors.item i).errorText
            print errorMessage
        )
    )
    else
    (
        ShellLaunch (GetDir #MaxRoot+"ReStartMax.exe") ""
        QuitMax #noPrompt
    )
)

ReStartMax(60)