package game.shaders;

import openfl.display.Shader;
import openfl.filters.ShaderFilter;
import openfl.utils.ByteArray;
import sys.FileSystem;
import sys.io.File;

class ShaderCode
{
	var shader:Shader;
	var filter:ShaderFilter;

	public function new(shaderName:String)
	{
		var fragmentCode:String = loadShaderCode(shaderName);

		if (fragmentCode != null)
		{
			var shaderData:ByteArray = new ByteArray();
			shaderData.writeUTFBytes(fragmentCode);

			shader = new Shader(shaderData);

			filter = new ShaderFilter(shader);
		}
		else
		{
			trace("Shader not found: " + shaderName);
		}
	}

	private function loadShaderCode(fileName:String):String
	{
		var shaderPath:String = game.AssetsPaths.getPath("data/shaders/" + fileName);
		if (FileSystem.exists(shaderPath))
		{
			return File.getContent(shaderPath);
		}
		else
		{
			return null;
		}
	}
}
