package mvcs.view.mediators {
	import flash.events.MouseEvent;

	import mvcs.controller.FSMConstants;
	import mvcs.view.components.StateUI;

	import org.osflash.statemachine.core.IFSMController;
	import org.osflash.statemachine.core.ISignalState;
	import org.robotlegs.mvcs.Mediator;

	public class StateUIMediator extends Mediator {

	[Inject]
	public var fsmController:IFSMController;

	//////////////////////////////////////////////////////////////////////////////
	// overridden in subclasses to access injected properties
	protected function get view():StateUI{ return null; }

	protected function get model():Object{ return null; }

	protected function get signalState():ISignalState{ return null; }

	//////////////////////////////////////////////////////////////////////////////

	//////////////////////////////////////////////////////////////////////////////
	// 1) sets the model injected into subclass as the view data source
	// 2) adds a MouseEvent.CLICK listener to the view
	// 3) adds listener to signalState's entered signal
	// 4) adds listener to signalState's teardown signal
	override public function onRegister():void{
		view.data = model;
		view.addEventListener( MouseEvent.CLICK, onClick );
		signalState.entered.add( onStateEntered );
		signalState.tearDown.add( onStateTearDown );
		view.enableButtons = false;
	}

	//////////////////////////////////////////////////////////////////////////////

	private function onStateEntered( data:Object ):void{
		view.enableButtons = true
	}

	private function onStateTearDown():void{
		view.enableButtons = false;
	}

	//////////////////////////////////////////////////////////////////////////////
	// Sends appropriate action from button click. The signalState's name
	// is sent as the action payload
	private function onClick( event:MouseEvent ):void{
		switch( event.target ){
			case view.next:
				fsmController.action( FSMConstants.NEXT, signalState.name );
				break;
			case view.previous:
				fsmController.action( FSMConstants.PREVIOUS, signalState.name );
				break;
		}
	}

}
}