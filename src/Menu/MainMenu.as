package Menu 
{
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.display.Stage;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.display.StageDisplayState;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class MainMenu extends Sprite
	{
		private var startButton	:	SimpleButton;
		private var fullButton	:	SimpleButton;
		
		private var _s			:	Stage;
		
		public function MainMenu(_stage:Stage) 
		{
			_s = _stage;
			startButton = new StartButArt();
			fullButton = new FullSButArt();
			
			startButton.x = 300;
			startButton.y = 150;
			
			fullButton.x = 250;
			fullButton.y = 225;
			
			addChild(startButton);
			addChild(fullButton);
			
			addEventListener(MouseEvent.CLICK, onClick);
		}
		
		private function onClick(e:MouseEvent):void
		{
			if (e.target == startButton)
			{
				dispatchEvent(new Event("startGame", true));
				removeEventListener(MouseEvent.CLICK, onClick);
			}
			else if (e.target == fullButton)
			{
				_s.displayState = StageDisplayState.FULL_SCREEN; 
			}
		}
		
		
	}

}