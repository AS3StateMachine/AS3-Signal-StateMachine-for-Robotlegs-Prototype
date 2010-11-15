package mvcs.controller.cmds {
	import mvcs.models.SecondStateGuardModel;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class ValidateExitFromSecondStateCmd extends SignalCommand {
	[Inject]
	public var model:SecondStateGuardModel;

	[Inject]
	public var fsmController:IFSMController;

	override public function execute():void{
		if( model.exiting ){
			var n:Number = Math.random();
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from Second State Cancelled, sending number: " + n ) );
			fsmController.cancel( "SecondStateExitReason", n );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Exit from Second State Validated" ) )
		}
	}

}
}