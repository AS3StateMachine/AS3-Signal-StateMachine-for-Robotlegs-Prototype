package mvcs.controller.cmds {
import mvcs.view.events.WriteEvent;

import org.osflash.signals.ISignal;
import org.robotlegs.mvcs.SignalCommand;

public class FirstStateEnteredCmd extends SignalCommand {

	[Inject]
	public var payload:Object;

	override public function execute():void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "First State Entered, sent from: " + payload.toString() ) );
	}

}
}