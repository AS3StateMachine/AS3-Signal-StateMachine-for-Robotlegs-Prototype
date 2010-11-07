package mvcs.controller.cmds {
import mvcs.models.FirstStateGuardModel;
import mvcs.view.events.WriteEvent;

import org.osflash.statemachine.core.ISignalFSMController;
import org.robotlegs.mvcs.SignalCommand;

public class ValidateExitFromFirstStateCmd extends SignalCommand {
	[Inject]
	public var model:FirstStateGuardModel;

	[Inject]
	public var fsmController:ISignalFSMController;

	override public function execute():void{
		if( model.exiting ){
			var n:Number = Math.random();
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from First State Cancelled, sending number: " + n ) );
			fsmController.cancel( "FirstStateExitReason", n );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from First State Validated" ) )
		}
	}

}
}