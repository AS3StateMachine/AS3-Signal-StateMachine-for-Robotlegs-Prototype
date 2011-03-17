package mvcs.controller.cmds {
	import mvcs.controller.FSMConstants;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class CancelledTestEnteredCmd extends SignalCommand {

	[Inject]
	public var fsmController:IFSMController;

	[Inject]
	public var payload:Object;

	override public function execute():void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "Cancelled Test State Entered, sent from: " + payload.toString() ) );
		fsmController.action(FSMConstants.NEXT);
	}

}
}