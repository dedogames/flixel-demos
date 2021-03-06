package;

import flixel.FlxSprite;
import flixel.FlxG;
import flixel.system.FlxAssets.FlxShader;

/**
 * ...
 * @author Zaphod
 */
class Bunny extends FlxSprite
{
	public var complex(default, set):Bool = false;
	
	public var useShader(default, set):Bool = false;
	
	private var _shader:FlxShader;
	
	public function new() 
	{
		super();
		
		if (FlxG.renderBlit)
			loadRotatedGraphic("assets/wabbit_alpha.png", 16, -1, false, true);
		else
			loadGraphic("assets/wabbit_alpha.png");
	}
	
	public function init(Offscreen:Bool = false, UseShader:Bool = false, ?Shader:FlxShader):Bunny
	{
		var speedMultiplier:Int = 50;
		
		if (Offscreen)
		{
			speedMultiplier = 5000;
		}
		
		if (Shader != null)
		{
			_shader = Shader;
		}
		
		useShader = UseShader;
		
		velocity.x = speedMultiplier * FlxG.random.float( -5, 5);
		velocity.y = speedMultiplier * FlxG.random.float( -7.5, 2.5);
		acceleration.y = 5;
		angle = FlxG.random.float( -15, 15);
		angularVelocity = 30 * FlxG.random.float( -5, 5);
		complex = PlayState.complex;
		elasticity = 1;
		
		return this;
	}
	
	override public function update(elapsed:Float):Void 
	{
		super.update(elapsed);
		
		if (complex)
		{
			alpha = 0.3 + 0.7 * y / FlxG.height;
		}
		
		if (!PlayState.offScreen)
		{
			updateBounds();
		}
	}
	
	private function updateBounds():Void
	{
		if (x > (FlxG.width - width))
		{
			velocity.x *= -1;
			x = (FlxG.width - width);
		}
		else if (x < 0)
		{
			velocity.x *= -1;
			x = 0;
		}
		
		if (y > (FlxG.height - height))
		{
			velocity.y *= -0.8;
			y = (FlxG.height - height);
			
			if (FlxG.random.bool()) 
			{
				velocity.y -= FlxG.random.float(3, 7);
			}
		}
		else if (y < 0)
		{
			velocity.y *= -0.8;
			y = 0;
		}
	}
	
	private function set_complex(Value:Bool):Bool
	{
		if (Value)
		{
			scale.x = scale.y = FlxG.random.float(0.3, 1.3);
		}
		else 
		{
			scale.set(1, 1);
			alpha = 1;
		}
		
		return complex = Value;
	}
	
	private function set_useShader(Value:Bool):Bool
	{
		if (Value)
		{
			shader = _shader;
		}
		else
		{
			shader = null;
		}
		
		return useShader = Value;
	}
}