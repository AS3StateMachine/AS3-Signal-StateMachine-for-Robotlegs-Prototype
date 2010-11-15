package mvcs.controller.cmds {
	import mvcs.models.FirstStateGuardModel;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class ValidateEntryToFirstStateCmd extends SignalCommand {

	[Inject]
	public var model:FirstStateGuardModel;

	[Inject]
	public var fsmController:IFSMController;

	override public function execute():void{
		if( model.entering ){
			var n:Number = Math.random();
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry into First State Cancelled, sending number: " + n ) );
			fsmController.cancel( "FirstStateEntryReason", n );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry to First State Validated" ) )
		}
	}

}
}