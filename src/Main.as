package 
{
	import flash.display.Sprite;
	import flash.events.Event;
	import Game.Game;
	import Menu.MainMenu;
	
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Main extends Sprite 
	{
		private var 	game	:	Game;
		private var 	mMenu	:	MainMenu;
		
		public function Main():void 
		{
			if (stage) init();
			else addEventListener(Event.ADDED_TO_STAGE, init);
		}
		
		private function init(e:Event = null):void 
		{
			removeEventListener(Event.ADDED_TO_STAGE, init);
			// entry point
			
			addEventListener("startGame", startGame);
			
			mMenu = new MainMenu(stage);
			addChild(mMenu);
			
		}
		
		private function startGame(e:Event):void
		{
			removeChild(mMenu);
			mMenu = null;
			
			game = new Game(stage);
			addChild(game);
		}
		
	}
	
}