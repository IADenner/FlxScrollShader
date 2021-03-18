package shaders;
import flash.display.BitmapData;
import flixel.system.FlxAssets.FlxShader;
import openfl.display.Bitmap;
import openfl.display.Loader;

/**
 * ...
 * @author Isaac
 */
class TextureWrapperShader extends FlxShader
{
	@:glFragmentSource('
	#pragma header
	
	uniform float scrollx;
	uniform float scrolly;
	
	void main()
	{
		//take our displacement amount and modulo it by the size of the texture (1.0)
		vec2 coord = vec2(mod(openfl_TextureCoordv.x + scrollx, 1.0), mod(openfl_TextureCoordv.y + scrolly, 1.0));
		
		//sample this point
		vec4 sampled = texture2D(bitmap, coord);
		
		//apply to texture
		gl_FragColor = sampled;
	}')
	
	var scrollAmountx:Float;
	var scrollAmounty:Float;
	public function new() 
	{
		super();
		scrollAmountx = 0;
		scrollAmounty = 0;
		scrollx.value = [scrollAmountx];
		scrolly.value = [scrollAmounty];
	}
	
	public function update(amountx:Float = 0.01, amounty:Float = 0.01)
	{
		scrollAmountx += amountx;
		scrollAmounty += amounty;
		scrollx.value = [scrollAmountx];
		scrolly.value = [scrollAmounty];
	}
	
}