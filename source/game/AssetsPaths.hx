package game;

class AssetsPaths
{
	public static function getPath(filePath:String):String
	{
		var file:String = modding.Mods.getPath(filePath);
		if (sys.FileSystem.exists(file))
		{
			return file;
		}
		return "assets/" + filePath;
	}
}
