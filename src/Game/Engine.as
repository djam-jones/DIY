package Game 
{
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Game.Maps.Map;
	import Game.Players.Bullet;
	import Game.Players.Player;
	import flash.events.EventDispatcher;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Engine 
	{
		private var gameObject	:	Vector.<ObjectGame>
		private var game		:	Game;
		private var impact:int = 1;
		
		public function Engine(_gameObject:Vector.<ObjectGame>, _game:Game) 
		{
			gameObject = _gameObject;
			game = _game;
		}
		
		public function update():void
		{
			for (var i:int = gameObject.length -1; i >= 0; i--)
			{
				if (gameObject[i] is Player || gameObject[i] is Bullet)
				{
					gameObject[i].update();
				}
			}
		}
		
		public function checkCollision():void
		{
			for (var i:int = gameObject.length - 1; i >= 0; i--)
			{
				for (var j:int = gameObject.length - 1; j >= 0; j--)
				{
					if (i == j) continue;
					
					//Entry Point
					if (gameObject[i].hitTestObject(gameObject[j]))
					{
						if (gameObject[i] is Player && gameObject[j] is Map)
						{
							while (gameObject[j].hitTestPoint(gameObject[i].x - gameObject[i].width / 2, gameObject[i].y, true))//Left Collision
							{
								gameObject[i].x += 1;
								//trace("Left");
							}
							while (gameObject[j].hitTestPoint(gameObject[i].x + gameObject[i].width / 2, gameObject[i].y, true))//Right Collision
							{
								gameObject[i].x -= 1;
								//trace("Right");
							}
							while (gameObject[j].hitTestPoint(gameObject[i].x, gameObject[i].y - gameObject[i].height / 2, true))//Top Collision
							{
								gameObject[i].y += 1;
								gameObject[i].dir.y = 0;
								//trace("Top");
							}
							while (gameObject[j].hitTestPoint(gameObject[i].x - gameObject[i].width / 5 * 1, gameObject[i].y + gameObject[i].height / 2, true))//Bottom Collision
							{
								gameObject[i].airBorne = false;
								gameObject[i].y -= 1;
								gameObject[i].dir.y = 0;
								//trace("Bot");
							}
							while (gameObject[j].hitTestPoint(gameObject[i].x + gameObject[i].width / 5 * 1, gameObject[i].y + gameObject[i].height / 2, true))//Bottom Collision
							{
								gameObject[i].airBorne = false;
								gameObject[i].y -= 1;
								gameObject[i].dir.y = 0;
								//trace("Bot");
							}
						}
						if (gameObject[i] is Player && gameObject[j] is Bullet)
						{
							if (gameObject[j].owner != gameObject[i])
							{
								gameObject[i].dir.x += gameObject[j].speed * impact;
								gameObject[j].destroy();
							}
						}
						if (gameObject[i] is Map && gameObject[j] is Bullet)
						{
							if (gameObject[i].hitTestPoint(gameObject[j].x, gameObject[j].y, true))
							{
								gameObject[j].destroy();
							}
						}
					}
				}
			}
		}
		
		public function onKeyDown(e:KeyboardEvent):void
		{
			for (var i:int = gameObject.length -1; i >= 0; i--)
			{
				if (gameObject[i] is Player)
				{
					gameObject[i].onKeyDown(e);
				}
			}
		}
		
		public function onKeyUp(e:KeyboardEvent):void
		{
			for (var i:int = gameObject.length -1; i >= 0; i--)
			{
				if (gameObject[i] is Player)
				{
					gameObject[i].onKeyUp(e);
				}
			}
		}
	}
}