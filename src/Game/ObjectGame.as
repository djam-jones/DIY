package Game 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import Game.Players.Player;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class ObjectGame extends Sprite
	{
		public var airBorne:Boolean;
		
		public var dir:Vector3D;
		
		public var speed:Number;
		
		public var owner:Player;
		
		public var ID:int;
		
		public function update():void { };
		
		public function onKeyDown(e:KeyboardEvent):void { };
		
		public function onKeyUp(e:KeyboardEvent):void { };
		
		public function destroy():void { };
		
	}

}