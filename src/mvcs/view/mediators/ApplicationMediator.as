package mvcs.view.mediators {
	import mvcs.controller.FSMConstants;

	import mx.events.FlexEvent;

	import org.osflash.statemachine.core.IFSMController;
	import org.robotlegs.mvcs.Mediator;

	public class ApplicationMediator extends Mediator {
	[Inject]
	public var view:SignalEnhancedFSMPrototype;

	[Inject]
	public var fsmController:IFSMController;

	override public function onRegister():void{
		view.addEventListener( FlexEvent.APPLICATION_COMPLETE, onApplicationComplete );
	}

	private function onApplicationComplete( event:FlexEvent ):void{
		view.removeEventListener( FlexEvent.APPLICATION_COMPLETE, onApplicationComplete );
		fsmController.action( FSMConstants.NEXT, null )
	}

}
}