# mxs_bundle
This is a deployable Maxscript bundle with a module management system
that comes with several libraries that I will be extending as I'm able.

The setup relies on Environment variables that I'm currently setting with
a Batch file that sets up the environment and then Launches 3dsmax.

The MaxLauncher.bat file will need to be updated with paths for your
local setup. At the very least you'll need to create the required environment
variables through your own wrapper.


**Purpose:**

The primary purpose of this package is to facilitate a module based approach to MaxScript libraries. This attempts to replicate the utility of C# namespaces and the ‘Using’ operator, or the Python ‘import’ operator. The result isn’t one-to-one, but the use-case is similar and very functional.

**Environment Variables:**

* "MXSPATH"

    * This is a semicolon separated path that behaves much like the PYTHONPATH

    * The individual paths are searched when sourcing a module.

    * The first module found while searching is returned and loaded

* "MXS_CODEROOT"

    * This is the base path to the code directories of the main MXS package

* "MXS_TOOLS"

    * This is a semicolon separated path that behaves much like the PYTHONPATH

    * Much like modules, there is logic here to support a tool framework that can be expanded by child packages.

**Coding standards:**

* All modules must be within a directory that is in the MXSPATH environment variable

* Supported MaxScript files are .ms and .mse

* Libraries are searched for by filename

    * Sourcing in the Logger module would look like this:

        * mxs.using "Logger"

        * This will search the paths in the MXSPATH, in order, until it finds a file named Logger.ms or Logger.mse.

        * It will then return the module and perform a FileIn operation on it

* All modules should create a global variable of the same name upon being loaded

    * Logger.ms should create a global variable ‘Logger’

    * This global variable is used to track if the module is already loaded or not

* This global variable should either contain an instance of a Struct or it should contain the uninstantiated struct for objects that will be instanced by the consumer.

* It’s a good practice to compose your Struct with the same name that you will instantiate it with, if for no other reason than reducing the number of variables in the system. But this also makes it more intuitive as a consumer if you know that you’re going to call a global variable that matches the name of the module you’re sourcing.

    * For example:

        * struct Logger ( <logic> )  

        * Logger = Logger() -- Instantiate the struct to a global variable of the same name

* You can have helper structs within the module so long as they are only used by the main struct and not intended to be used individually. 

    * This ensures that the usage of the structs are intuitive and we’re not just sourcing in random global variables without any guidance on how to use them.

* Each module should contain these two methods:

    * Fn GetModule = ( GetSourceFileName() )

    * Fn Help = ( ::mxs.GetScriptHelp (GetSourceFileName()) )

    * These methods can be used by the main module for various purposes.

    * The Help method is purposefully written as a static method so that it can be called on an un-instantiated object.

* All modules should contain a Help block above the start of the code.

    * This should just be a commented block with the text ‘__HELP__’ at the beginning and ‘__END__’ to finish it off. 

    * The main mxs lib has a method that parses the text file and returns this block of text and prints it to the listener window.

        * In this way we can provide help for consuming modules without external documentation.

* Variable scoping:

    * All variables should have their scope declared

        * Variables used only within a function should be declared as ‘local’

            * local foo

        * Variables and Methods within a struct should always be called using the ‘this’ keyword.

            * this.foo

            * this.foo()

        * Global variables should always be prefixed with a double-colon, ‘::’.

            * This ensures that the compiler will only search the variable from the global pool.

            * It also makes your code easier to read as this tells the reader that the variable is coming from another source not defined in the current scope.

            * Technical info about this can be found here:

                * [https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2015/ENU/MAXScript-Help/files/GUID-382E7583-DD2A-4DF5-B568-71502DF95ED9-htm.html](https://knowledge.autodesk.com/search-result/caas/CloudHelp/cloudhelp/2015/ENU/MAXScript-Help/files/GUID-382E7583-DD2A-4DF5-B568-71502DF95ED9-htm.html)

* Module sourcing loops!

    * If a module is sourcing in another module that, in turn, sources it, you’ll need to do a forward declaration of your modules global variable before all of your ‘using’ declarations.

    * For example: MeshFns and MaterialFns source oneanother. In these modules, you’ll find that we define their global variables prior to our ‘using’ declarations by just defining it as an empty string. ( ::MeshFns = "" )


