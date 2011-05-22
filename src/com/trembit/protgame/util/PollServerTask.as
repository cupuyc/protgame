package com.trembit.protgame.util
{
    import com.trembit.protgame.model.GameModel;
    
    import flash.events.Event;
    import flash.events.TimerEvent;
    import flash.net.URLRequestMethod;
    import flash.utils.Timer;
    
    import org.spicefactory.lib.task.Task;

    public class PollServerTask extends Task
    {
        public var gameModel : GameModel = GameModel.instance;

        private var pollTimer : Timer = new Timer(1000);

        public function PollServerTask()
        {
            super();
        }

        override protected function doStart():void {
            pollTimer.start();
            pollTimer.addEventListener(TimerEvent.TIMER, onPollTimer);
        }

        private function onPollTimer(event : Event) : void {
            new RestServiceTask(
                "players/_design/playersbytile/_view/playersbytile",
                URLRequestMethod.GET,
                "",
                function(result : Object) : void {
                    trace(result);
                }).start();
        }
    }
}