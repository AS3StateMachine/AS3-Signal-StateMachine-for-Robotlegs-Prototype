package mvcs.controller.cmds {
	import mvcs.controller.FSMConstants;
	import mvcs.models.CancelledTestModel;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class CancelledTestTransitionCancelledCmd extends SignalCommand {

	[Inject]
	public var action:String;

	[Inject]
	public var model:CancelledTestModel;

		[Inject]
	public var fsmController:IFSMController;


	
	override public function execute():void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "cancelled because: " + action ) );
		model.permissionToExit = true;
		fsmController.action(FSMConstants.NEXT, {})
	}

}
}