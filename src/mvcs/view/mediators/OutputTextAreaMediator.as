package mvcs.view.mediators {
	import mvcs.view.components.OutputTextArea;
	import mvcs.view.events.WriteEvent;

	import org.robotlegs.mvcs.Mediator;

	public class OutputTextAreaMediator extends Mediator {
	[Inject]
	public var view:OutputTextArea;

	override public function onRegister():void{
		eventDispatcher.addEventListener( WriteEvent.WRITE, onWrite );
	}

	private function onWrite( event:WriteEvent ):void{
		view.htmlText += ">>" + event.msg + "<br/>";
	}

}
}