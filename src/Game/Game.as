package Game 
{
	
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import Game.Maps.Map;
	import Game.Players.Player;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Game extends Sprite
	{
		private var _stage		:	Stage;
		
		private var gameObjects	: 	Vector.<ObjectGame>;
		private var _engine		:	Engine;
		
		public function Game(s:Stage) 
		{
			_stage = s;
			
			gameObjects = new Vector.<ObjectGame>;
			_engine = new Engine(gameObjects, this);
			
			startGame();
		}
		
		private function startGame():void
		{
			var player:Player = new Player(37, 39, 38, 188, 190, 191, 250, 50, gameObjects, this);
			var player2:Player = new Player(65, 68, 87, 69, 82, 84, 400, 50, gameObjects, this);
			var map:Map = new Map();
			
			_stage.addEventListener(KeyboardEvent.KEY_DOWN, onKeyDown);
			_stage.addEventListener(KeyboardEvent.KEY_UP, onKeyUp);
			addEventListener(Event.ENTER_FRAME, update);
			
			//player.x = _stage.stageWidth / 2;
			//player.y = _stage.stageHeight / 2;
			
			addChild(player);
			addChild(player2);
			
			map.x = 50;
			map.y = 150;
			addChild(map);
			
			gameObjects.push(map, player, player2);
		}
		
		private function destroyBullet(e:Event):void 
		{
		}
		
		private function endGame():void
		{
			_stage.removeEventListener(KeyboardEvent.KEY_DOWN, onKeyDown)
			_stage.removeEventListener(KeyboardEvent.KEY_UP, onKeyUp);
		}
		
		private function onKeyDown(e:KeyboardEvent):void
		{
			_engine.onKeyDown(e);
		}
		
		private function onKeyUp(e:KeyboardEvent):void
		{
			_engine.onKeyUp(e);
		}
		
		private function update(e:Event):void
		{
			if (_engine)
			{
				_engine.update();
				_engine.checkCollision();
			}
		}
		
	}

}