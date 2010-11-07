package mvcs.controller.cmds {
import mvcs.view.events.WriteEvent;

import org.robotlegs.mvcs.SignalCommand;

public class ThirdStateEnteredCmd extends SignalCommand {
	[Inject]
		public var payload:Object;

		override public function execute():void{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Third State Entered, sent from: " + payload.toString() ) );
		}

}
}