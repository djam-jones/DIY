package Game.Maps 
{
	import Game.ObjectGame;
	/**
	 * ...
	 * @author Collin Loot
	 */
	public class Map extends ObjectGame
	{
		
		private var mapArt	:	MapArt;
		
		public function Map() 
		{
			mapArt = new MapArt();
			addChild(mapArt);
		}
		
	}

}