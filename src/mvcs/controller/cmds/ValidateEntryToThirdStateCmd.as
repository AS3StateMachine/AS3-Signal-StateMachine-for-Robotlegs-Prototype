package mvcs.controller.cmds {
	import mvcs.models.ThirdStateGuardModel;
	import mvcs.view.events.WriteEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.SignalCommand;

	public class ValidateEntryToThirdStateCmd extends SignalCommand {

	[Inject]
	public var model:ThirdStateGuardModel;

	[Inject]
	public var fsmController:IFSMController;

	override public function execute():void{
		if( model.entering ){
			var n:Number = Math.random();
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry into Third State Cancelled, sending number: " + n ) );
			fsmController.cancel( "ThirdStateEntryReason", n );
		} else{
			dispatch( new WriteEvent( WriteEvent.WRITE, "Entry to Third State Validated" ) )
		}
	}

}
}