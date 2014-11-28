package Game.Players 
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.events.KeyboardEvent;
	import flash.geom.Vector3D;
	import Game.Game;
	import Game.ObjectGame;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Player extends ObjectGame
	{
		private var playerArt	:	PlayerArt;
		private var guns 		:	Vector.<MovieClip>
		
		private var keydown		:	Boolean;
		
		private var vertSpeed	:	Number = 7.5;
		private var playerSize	:	Number = 0.3;
		private var gravity		: 	Number = 7.5;
		private var jumpHeight	:	Number = -18;
		private var dampSpeed	:	Number = 0.75;
		private var heightDamp	:	Number = 1;
		private var maxGrav		:	Number = 20;
		
		private var leftKey:uint;
		private var rightKey:uint;
		private var upKey:uint;
		private	var swapLeft:uint;
		private var swapRight:uint;
		private var fireKey:uint;
		
		private var spawnX:int;
		private var spawnY:int;
		
		private var newPistol:PistolArt = new PistolArt();
		private var newRifle:RifleArt = new RifleArt();
		
		public var pistolEquipped:Boolean = true;
		public var rifleEquipped:Boolean = false;
		
		public var allowShooting:Boolean = true;
		public var shootTime:int = 0;
		public var shootLimit:int = 6;
		
		private var gameObjects:Vector.<ObjectGame>;
		
		private var game:Game;
		
		//private var downKey:uint;
		
		public function Player(_leftKey:uint, _rightKey:uint, _upKey:uint, swapleft:uint, swapright:uint,firekey:uint, _spawnX:int, _spawnY:int, _gameObjects:Vector.<ObjectGame>, _game:Game) 
		{
			game = _game;
			
			gameObjects = _gameObjects;
			
			addEventListener("destroyBullet", destroyBullet);
			
			dir = new Vector3D(0, gravity, 0);
			playerArt = new PlayerArt();
			guns = new Vector.<MovieClip>;
			
			leftKey = _leftKey;
			rightKey = _rightKey;
			upKey = _upKey;
			
			swapLeft = swapleft;
			swapRight = swapright;
			
			fireKey = firekey;
			
			spawnX = _spawnX;
			spawnY = _spawnY;
			
			this.x = spawnX;
			this.y = spawnY;
			
			addChild(playerArt);
			addChild(newPistol);
			newPistol.visible = true;
			addChild(newRifle);
			newRifle.visible = false;
			guns.push(newPistol);
			guns.push(newRifle);
		}
		
		public function destroyBullet(ID:int):void 
		{
			if (ID < gameObjects.length)
			{
				game.removeChild(gameObjects[ID]);
				gameObjects.splice(ID, 1);
			}
			else if(ID == gameObjects.length) 
			{
				game.removeChild(gameObjects[ID-1]);
				gameObjects.splice(ID -1, 1);
			}
		}
		
		private function respawn():void
		{
			this.x = spawnX;
			this.y = spawnY;
			dir.y = 0;
			dir.x = 0;
		}
		
		override public function update():void 
		{
			this.x += dir.x;
			this.y += dir.y;
			
			if (dir.y < maxGrav)
			{
				dir.y += heightDamp;
			}
			
			if (!keydown)
			{
				if (dir.x > 0)
				{
					dir.x -= dampSpeed;
				}
				else if(dir.x < 0)
				{
					dir.x += dampSpeed;
				}
			}
			
			if (dir.x > 0)
			{
				this.scaleX = 1;
			}
			else if( dir.x < 0)
			{
				this.scaleX = -1;
			}
			
			if (this.y > 600)
			{
				respawn();
			}
			
			if(shootTime < shootLimit)
			{
				shootTime++;
			}
			else
			{
				allowShooting = true;
				shootTime = 0;
			}
			
			if (pistolEquipped)
			{
				shootLimit = 25;
			}
			else 
			{
				shootLimit = 15;
			}
			
			if (dir.x < 10000 && playerArt.currentFrame > 28)
			{
				playerArt.gotoAndPlay(0);
			}
		}
		
		override public function onKeyDown(e:KeyboardEvent):void 
		{
			if (e.keyCode == leftKey)// Left
			{
				dir.x = -vertSpeed;
				keydown = true;
			}
			if (e.keyCode == rightKey)// Right
			{
				dir.x = vertSpeed;
				keydown = true;
			}
			if (e.keyCode == upKey && airBorne == false)
			{
				dir.y = jumpHeight;
				airBorne = true;
			}
			
			if(e.keyCode == swapLeft) //Switch to Pistol
			{
				newPistol.visible = true;
				newRifle.visible = false;
				
				pistolEquipped = true;
				rifleEquipped = false;
			}
			else if(e.keyCode == swapRight) //Switch to Rifle
			{
				newPistol.visible = false;
				newRifle.visible = true;
				
				pistolEquipped = false;
				rifleEquipped = true;
			}
			
			if(e.keyCode == fireKey && allowShooting)
			{
				allowShooting = false;
				
				var newBullet:Bullet = new Bullet(this.scaleX, this, gameObjects.length);
				
				if(pistolEquipped == true)
				{
					newBullet.x = this.x + newPistol.x + newPistol.width + newBullet.width*2 * this.scaleX;
					newBullet.y = this.y + newPistol.y;
				}
				else if(rifleEquipped == true)
				{
					newBullet.x = this.x + newRifle.x + newRifle.width * this.scaleX;
					newBullet.y = this.y + newRifle.y;
				}
					
				game.addChild(newBullet);
				gameObjects.push(newBullet);
			}
		}
		
		override public function onKeyUp(e:KeyboardEvent):void 
		{
			if (e.keyCode == leftKey)// Left
			{
				keydown = false;	
			}
			else if (e.keyCode == rightKey)// Right
			{
				keydown = false;
			}
			
		}
		
	}

}