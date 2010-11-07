package mvcs.controller.cmds {
import mvcs.controller.FSMConstants;
import mvcs.view.events.WriteEvent;

import org.osflash.statemachine.core.ISignalFSMController;
import org.osflash.statemachine.core.IState;
import org.robotlegs.mvcs.Command;

public class TestSynchronousActionCmd extends Command {

	[Inject]
	public var fsmController:ISignalFSMController;

	override public function execute():void{


		// toggle code by removing (or adding) the leading / below
		// sending a NEXT action should throw a TransitionError

		//*
		dispatch( new WriteEvent( WriteEvent.WRITE, "Hooking next action to ChangedSignal" ) );
		fsmController.addChangedListenerOnce( sendNext );
		/*/
		 fsmController.action( FSMConstants.NEXT, null );
		 //*/

	}

	private function sendNext( state:IState ):void{
		dispatch( new WriteEvent( WriteEvent.WRITE, "Synchronous test successfull, Sending NEXT action" ) );
		fsmController.action( FSMConstants.NEXT, "StartUp" );
	}
}
}