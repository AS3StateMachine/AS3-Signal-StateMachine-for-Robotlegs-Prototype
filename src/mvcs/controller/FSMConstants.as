package mvcs.controller {

public class FSMConstants {
    public static const SYNCTEST:String = "state/synchTest";

    public static const CANCELLED_TEST:String = "state/cancelledTest";

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
        <state name={IDLING} >
            <transition action={NEXT}
            target={SYNCTEST}/>

        </state>

        <state name={SYNCTEST}>
            <entered>
                <commandClass classPath="TestFSMControllerActionLaterCmd"/>
            </entered>
            <transition action={NEXT} target={CANCELLED_TEST}/>
        </state>

        <state name={CANCELLED_TEST} >
            <entered>
                <commandClass classPath="CancelledTestEnteredCmd"/>
            </entered>
            <exitingGuard>
                <commandClass classPath="ValidateExitFromCancelledTestStateCmd"/>
            </exitingGuard>
            <cancelled>
                <commandClass classPath="CancelledTestTransitionCancelledCmd"/>
            </cancelled>
            <transition action={NEXT} target={FIRST}/>
        </state>

        <state name={FIRST} inject="true">
            <entered>
                <commandClass classPath="FirstStateEnteredCmd"/>
            </entered>
            <exitingGuard>
                <commandClass classPath="ValidateExitFromFirstStateCmd"/>
            </exitingGuard>
            <enteringGuard>
                <commandClass classPath="ValidateEntryToFirstStateCmd"/>
            </enteringGuard>
            <cancelled>
                <commandClass classPath="FirstStateTransitionCancelledCmd"/>
            </cancelled>
            <tearDown>
                <commandClass classPath="TearDownFirstStateCmd"/>
            </tearDown>

            <transition action={NEXT} target={SECOND}/>
            <transition action={PREVIOUS} target={THIRD}/>

        </state>

        <state name={SECOND} inject="true">
            <entered>
                <commandClass classPath="SecondStateEnteredCmd"/>
            </entered>
            <exitingGuard>
                <commandClass classPath="ValidateExitFromSecondStateCmd"/>
            </exitingGuard>
            <enteringGuard>
                <commandClass classPath="ValidateEntryToSecondStateCmd"/>
            </enteringGuard>
            <cancelled>
                <commandClass classPath="SecondStateTransitionCancelledCmd"/>
            </cancelled>
            <tearDown>
                <commandClass classPath="TearDownSecondStateCmd"/>
            </tearDown>

            <transition action={NEXT}target={THIRD}/>
            <transition action={PREVIOUS}target={FIRST}/>

        </state>

        <state name={THIRD} inject="true">

            <entered>
                <commandClass classPath="ThirdStateEnteredCmd"/>
            </entered>
            <exitingGuard>
                <commandClass classPath="ValidateExitFromThirdStateCmd"/>
            </exitingGuard>
            <enteringGuard>
                <commandClass classPath="ValidateEntryToThirdStateCmd"/>
            </enteringGuard>
            <cancelled>
                <commandClass classPath="ThirdStateTransitionCancelledCmd"/>
            </cancelled>
            <tearDown>
                <commandClass classPath="TearDownThirdStateCmd"/>
            </tearDown>

            <transition action={NEXT} target={FIRST}/>
            <transition action={PREVIOUS} target={SECOND}/>

        </state>

    </fsm>

}

}