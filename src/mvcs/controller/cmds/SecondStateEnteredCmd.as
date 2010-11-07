package mvcs.controller.cmds {
import mvcs.view.events.WriteEvent;

import org.robotlegs.mvcs.SignalCommand;

public class SecondStateEnteredCmd extends SignalCommand {
	[Inject]
		public var payload:Object;

		override public function execute():void{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Second State Entered, sent from: " + payload.toString() ) );
		}


}
}