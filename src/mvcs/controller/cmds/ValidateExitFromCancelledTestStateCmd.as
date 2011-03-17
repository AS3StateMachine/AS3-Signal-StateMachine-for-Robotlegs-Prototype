
package mvcs.controller.cmds {
	import mvcs.models.CancelledTestModel;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class ValidateExitFromCancelledTestStateCmd extends SignalCommand {

	[Inject]
	public var model:CancelledTestModel;

	[Inject]
	public var fsmController:IFSMController;

	override public function execute():void{
		if( model.permissionToExit ){
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from Cancelled Test State Validated" ) );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from Cancelled Test State Cancelled " ) );
			fsmController.cancel( "Testing Cancelleation" );
		}
	}

}
}