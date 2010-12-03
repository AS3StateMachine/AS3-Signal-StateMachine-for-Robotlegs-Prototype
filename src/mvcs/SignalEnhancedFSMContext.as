package mvcs {
	import mvcs.controller.FSMConstants;
	import mvcs.controller.cmds.FirstStateEnteredCmd;
	import mvcs.controller.cmds.FirstStateTransitionCancelledCmd;
	import mvcs.controller.cmds.SecondStateEnteredCmd;
	import mvcs.controller.cmds.SecondStateTransitionCancelledCmd;
	import mvcs.controller.cmds.TearDownFirstStateCmd;
	import mvcs.controller.cmds.TearDownSecondStateCmd;
	import mvcs.controller.cmds.TearDownThirdStateCmd;
	import mvcs.controller.cmds.TestFSMControllerActionLaterCmd;
	import mvcs.controller.cmds.ThirdStateEnteredCmd;
	import mvcs.controller.cmds.ThirdStateTransitionCancelledCmd;
	import mvcs.controller.cmds.ValidateEntryToFirstStateCmd;
	import mvcs.controller.cmds.ValidateEntryToSecondStateCmd;
	import mvcs.controller.cmds.ValidateEntryToThirdStateCmd;
	import mvcs.controller.cmds.ValidateExitFromFirstStateCmd;
	import mvcs.controller.cmds.ValidateExitFromSecondStateCmd;
	import mvcs.controller.cmds.ValidateExitFromThirdStateCmd;
	import mvcs.models.FirstStateGuardModel;
	import mvcs.models.SecondStateGuardModel;
	import mvcs.models.ThirdStateGuardModel;
	import mvcs.view.components.FirstStateUI;
	import mvcs.view.components.OutputTextArea;
	import mvcs.view.components.SecondStateUI;
	import mvcs.view.components.ThirdStateUI;
	import mvcs.view.mediators.ApplicationMediator;
	import mvcs.view.mediators.FirstStateUIMediator;
	import mvcs.view.mediators.OutputTextAreaMediator;
	import mvcs.view.mediators.SecondStateUIMediator;
	import mvcs.view.mediators.ThirdStateUIMediator;

	import org.osflash.statemachine.SignalFSMInjector;
	import org.robotlegs.mvcs.SignalContext;

	// NOTE: extends a SignalContext
public class SignalEnhancedFSMContext extends SignalContext {
	override public function startup():void{
		// I've had to put the FSM creation here in the context as classes are being injected
		// by it, otherwise we will get missing injection rule errors. The FSM also needs to be
		// mapped first, as it is mapping classes needed by View and Model
		mapController();
		mapModel();
		mapView();
	}

	private function mapView():void{
		mediatorMap.mapView( FirstStateUI, FirstStateUIMediator );
		mediatorMap.mapView( SecondStateUI, SecondStateUIMediator );
		mediatorMap.mapView( ThirdStateUI, ThirdStateUIMediator );
		mediatorMap.mapView( OutputTextArea, OutputTextAreaMediator );
		mediatorMap.mapView( SignalEnhancedFSMPrototype, ApplicationMediator );
	}

	private function mapModel():void{
		injector.mapSingleton( FirstStateGuardModel );
		injector.mapSingleton( SecondStateGuardModel );
		injector.mapSingleton( ThirdStateGuardModel );
	}

	private function mapController():void{

		var fsmInjector:SignalFSMInjector = new SignalFSMInjector( injector, signalCommandMap );
		fsmInjector.initiate( FSMConstants.FSM );

		// add the SignalCommands to the decoder before injection
		fsmInjector.addCommandClass( TestFSMControllerActionLaterCmd );
		fsmInjector.addCommandClass( ValidateEntryToFirstStateCmd );
		fsmInjector.addCommandClass( ValidateExitFromFirstStateCmd );
		fsmInjector.addCommandClass( FirstStateEnteredCmd );
		fsmInjector.addCommandClass( TearDownFirstStateCmd );
		fsmInjector.addCommandClass( FirstStateTransitionCancelledCmd );
		fsmInjector.addCommandClass( ValidateEntryToSecondStateCmd );
		fsmInjector.addCommandClass( ValidateExitFromSecondStateCmd );
		fsmInjector.addCommandClass( SecondStateEnteredCmd );
		fsmInjector.addCommandClass( TearDownSecondStateCmd );
		fsmInjector.addCommandClass( SecondStateTransitionCancelledCmd );
		fsmInjector.addCommandClass( ValidateEntryToThirdStateCmd );
		fsmInjector.addCommandClass( ValidateExitFromThirdStateCmd );
		fsmInjector.addCommandClass( ThirdStateEnteredCmd );
		fsmInjector.addCommandClass( TearDownThirdStateCmd );
		fsmInjector.addCommandClass( ThirdStateTransitionCancelledCmd );

		fsmInjector.inject();
		fsmInjector.destroy();

	}

}
}