package mvcs.controller.cmds {
	import mvcs.controller.FSMConstants;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.osflash.statemachine.core.IState;
	import org.robotlegs.mvcs.Command;

	public class TestFSMControllerActionLaterCmd extends Command {

	[Inject]
	public var fsmController:IFSMController;

	override public function execute():void{
 
		dispatch( new WriteEvent( WriteEvent.WRITE, "Testing FSMController's action later" ) );
		fsmController.action( FSMConstants.NEXT, "StartUp" );


	}

}
}