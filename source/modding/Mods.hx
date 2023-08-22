package modding;

import haxe.Json;
import sys.FileSystem;
import sys.io.File;

using StringTools;

typedef ModJson =
{
	var name:String;
	var version:String;
	var description:String;
}

class Mods
{
	public static var mods:Array<ModJson>;
	public static var modDirectory:String = "mods/";

	public static function loadMods():Void
	{
		mods = [];

		if (FileSystem.exists(modDirectory))
		{
			for (mod in getModFolders())
			{
				var filePath:String = modDirectory + mod + "/mod.json";
				var jsonContent:String = File.getContent(filePath);
				var mod:ModJson = Json.parse(jsonContent);
				mods.push(mod);
			}
		}
	}

	public static function getModFolders():Array<String>
	{
		var folders:Array<String> = [];
		if (FileSystem.exists(modDirectory))
		{
			for (file in FileSystem.readDirectory(modDirectory))
			{
				if (FileSystem.isDirectory(modDirectory + file))
				{
					folders.push(file);
				}
			}
		}
		return folders;
	}
}
