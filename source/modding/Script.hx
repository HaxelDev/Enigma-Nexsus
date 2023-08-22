package modding;

import hscript.Expr;
import hscript.Interp;
import hscript.Parser;
import sys.FileSystem;
import sys.io.File;

class Script
{
	public var script:Expr;
	public var interp:Interp;
	public var parser:Parser;

	public function new(scriptName:String)
	{
		interp = new Interp();
		parser = new Parser();

		parser.allowTypes = true;
		parser.allowJSON = true;
		parser.allowMetadata = true;

		var scriptFilePath:String = game.AssetsPaths.getPath("data/scripts/" + scriptName + ".hx");
		if (FileSystem.exists(scriptFilePath))
		{
			var scriptCode:String = File.getContent(scriptFilePath);
			script = parser.parseString(scriptCode);

			if (script != null)
			{
				interp.variables.set("FlxG", flixel.FlxG);
				interp.execute(script);
			}
			else
			{
				trace("Script parsing error.");
			}
		}
		else
		{
			trace("Script file not found: " + scriptFilePath);
		}
	}
}
