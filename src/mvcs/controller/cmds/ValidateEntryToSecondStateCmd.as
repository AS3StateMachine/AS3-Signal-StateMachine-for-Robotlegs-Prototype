package mvcs.controller.cmds {
import mvcs.models.SecondStateGuardModel;
import mvcs.view.events.WriteEvent;

import org.osflash.statemachine.core.ISignalFSMController;
import org.robotlegs.mvcs.SignalCommand;

public class ValidateEntryToSecondStateCmd extends SignalCommand {
	[Inject]
	public var model:SecondStateGuardModel;

	[Inject]
	public var fsmController:ISignalFSMController;

	override public function execute():void{
		if( model.entering ){
			var n:Number = Math.random();
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry into Second State Cancelled, sending number: " + n ) );
			fsmController.cancel( "SecondStateEntryReason", n );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry to Second State Validated" ) )
		}
	}

}
}