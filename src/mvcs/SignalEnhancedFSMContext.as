package mvcs {
import mvcs.controller.FSMConstants;
import mvcs.controller.cmds.FirstStateEnteredCmd;
import mvcs.controller.cmds.FirstStateTransitionCancelledCmd;
import mvcs.controller.cmds.SecondStateEnteredCmd;
import mvcs.controller.cmds.SecondStateTransitionCancelledCmd;
import mvcs.controller.cmds.TearDownFirstStateCmd;
import mvcs.controller.cmds.TearDownSecondStateCmd;
import mvcs.controller.cmds.TearDownThirdStateCmd;
import mvcs.controller.cmds.TestSynchronousActionCmd;
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

import org.osflash.statemachine.FSMInjector;
import org.osflash.statemachine.StateMachine;
import org.osflash.statemachine.core.ISignalFSMController;
import org.osflash.statemachine.core.IStateMachine;
import org.osflash.statemachine.decoding.SignalStateDecoder;
import org.osflash.statemachine.transitioning.SignalTransitionController;
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

		// create a SignalStateDecoder and pass it the State Declaration
		var decoder:SignalStateDecoder = new SignalStateDecoder( FSMConstants.FSM, injector, signalCommandMap );
		// add it the FSMInjector
		var smInjector:FSMInjector = new FSMInjector( decoder );
		// create a transitionController
		var transitionController:SignalTransitionController = new SignalTransitionController();
		// and pass it to the StateMachine
		var stateMachine:StateMachine = new StateMachine( transitionController );

		// add the SignalCommands to the decoder before injection
		decoder.addCommandClass( TestSynchronousActionCmd );
		decoder.addCommandClass( ValidateEntryToFirstStateCmd );
		decoder.addCommandClass( ValidateExitFromFirstStateCmd );
		decoder.addCommandClass( FirstStateEnteredCmd );
		decoder.addCommandClass( TearDownFirstStateCmd );
		decoder.addCommandClass( FirstStateTransitionCancelledCmd );
		decoder.addCommandClass( ValidateEntryToSecondStateCmd );
		decoder.addCommandClass( ValidateExitFromSecondStateCmd );
		decoder.addCommandClass( SecondStateEnteredCmd );
		decoder.addCommandClass( TearDownSecondStateCmd );
		decoder.addCommandClass( SecondStateTransitionCancelledCmd );
		decoder.addCommandClass( ValidateEntryToThirdStateCmd );
		decoder.addCommandClass( ValidateExitFromThirdStateCmd );
		decoder.addCommandClass( ThirdStateEnteredCmd );
		decoder.addCommandClass( TearDownThirdStateCmd );
		decoder.addCommandClass( ThirdStateTransitionCancelledCmd );

		// inject the statemachine, it will proceed to the initial state.
		// NB no injection rules have been set for view or model yet, the initial state
		// should be a resting one and the next state should be triggered by the
		// onApplicationComplete event in the ApplicationMediator
		smInjector.inject( stateMachine );

		// inject the statemachine (mainly to make sure that it doesn't get GCd )
		injector.mapValue( IStateMachine, stateMachine );
		// inject the fsmController to allow actors to control fsm
		injector.mapValue( ISignalFSMController, transitionController.fsmController );

		// injector is no longer needed
		smInjector.destroy();

	}

}
}