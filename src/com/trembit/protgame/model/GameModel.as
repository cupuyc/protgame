package com.trembit.protgame.model
{

    [Bndable]
    public class GameModel
    {

        public static var instance : GameModel = new GameModel();

        public var availableUUID : String;
        
        public function GameModel()
        {
            super();
        }
    }
}