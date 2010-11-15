package mvcs.controller.cmds {
	import mvcs.view.events.WriteEvent;

	import org.robotlegs.mvcs.SignalCommand;

	public class ThirdStateTransitionCancelledCmd extends SignalCommand {

	[Inject]
	public var action:String;

		[Inject]
	public var payload:Object;

	override public function execute():void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "cancelled because: " + action + "  Number sent: " + payload.toString() ) );
	}

}
}