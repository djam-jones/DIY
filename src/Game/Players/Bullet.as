package Game.Players 
{
	import flash.events.Event;
	import flash.geom.Vector3D;
	import Game.ObjectGame;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Bullet extends ObjectGame
	{
		
		public var bulletArt	:	BulletArt;
		
		public function Bullet(side:int, _owner:Player, _ID:int) 
		{
			bulletArt = new BulletArt();
			ID = _ID;
			owner = _owner;
			
			speed = 15 * side;
			dir = new Vector3D(speed, 0, 0);
			
			addChild(bulletArt);
		}
		
		override public function update():void
		{
			this.x += dir.x;
			this.y += dir.y;
			
			if (this.x > 800 || this.x < 0 || this.y < 0 || this.y > 600)
			{
				destroy();
			}
			
		}	
		
		override public function destroy():void 
		{
			owner.destroyBullet(ID);
		}
	}	
}