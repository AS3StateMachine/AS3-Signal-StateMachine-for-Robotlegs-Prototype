package mvcs.controller {

public class FSMConstants {
	public static const SYNCTEST:String = "state/synchTest";

	public static const IDLING:String = "state/idling";

	public static const FIRST:String = "state/first";

	public static const SECOND:String = "state/second";

	public static const THIRD:String = "state/third";

	public static const NEXT:String = "action/next";
	public static const PREVIOUS:String = "action/previous";

	/**
	 * XML configures the State Machine. This could be loaded from an external
	 * file as well.
	 */
	public static const FSM:XML = <fsm initial={IDLING}>

		<!-- THE INITIAL STATE -->
		<state	 name={IDLING} >
			<transition action={NEXT}
			target={SYNCTEST}/>

		</state>

		<state
		name={SYNCTEST}
		entered="TestFSMControllerActionLaterCmd"
		>

			<transition action={NEXT}
			target={FIRST}/>

		</state>

		<state
		name={FIRST}
		inject="true"
		entered="FirstStateEnteredCmd"
		exitingGuard="ValidateExitFromFirstStateCmd"
		enteringGuard="ValidateEntryToFirstStateCmd"
		cancelled="FirstStateTransitionCancelledCmd"
		teardown="TearDownFirstStateCmd">

			<transition action={NEXT}
			target={SECOND}/>

			<transition action={PREVIOUS}
			target={THIRD}/>

		</state>

		<state
		name={SECOND}
		inject="true"
		entered="SecondStateEnteredCmd"
		exitingGuard="ValidateExitFromSecondStateCmd"
		enteringGuard="ValidateEntryToSecondStateCmd"
		cancelled="SecondStateTransitionCancelledCmd"
		teardown="TearDownSecondStateCmd">

			<transition action={NEXT}
			target={THIRD}/>

			<transition action={PREVIOUS}
			target={FIRST}/>

		</state>

		<state	 name={THIRD}
		inject="true"
		entered="ThirdStateEnteredCmd"
		exitingGuard="ValidateExitFromThirdStateCmd"
		enteringGuard="ValidateEntryToThirdStateCmd"
		cancelled="ThirdStateTransitionCancelledCmd"
		teardown="TearDownThirdStateCmd">

			<transition action={NEXT}
			target={FIRST}/>

			<transition action={PREVIOUS}
			target={SECOND}/>

		</state>

	</fsm>;
}
}