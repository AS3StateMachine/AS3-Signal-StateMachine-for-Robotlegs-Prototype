package mvcs.controller.cmds {
	import mvcs.view.events.WriteEvent;

	import org.robotlegs.mvcs.SignalCommand;

	public class TearDownFirstStateCmd extends SignalCommand {

	override public function execute():void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "First State Teardown" ) );
	}

}
}