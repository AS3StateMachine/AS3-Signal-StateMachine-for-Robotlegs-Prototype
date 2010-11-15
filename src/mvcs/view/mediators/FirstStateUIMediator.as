package mvcs.view.mediators {
	import mvcs.models.FirstStateGuardModel;
	import mvcs.view.components.FirstStateUI;
	import mvcs.view.components.StateUI;

	import org.osflash.statemachine.core.ISignalState;

	public class FirstStateUIMediator extends StateUIMediator {
	[Inject]
	public var ui:FirstStateUI;

	[Inject]
	public var data:FirstStateGuardModel;

	[Inject(name="state/first")]
	public var state:ISignalState;

	protected override function get view():StateUI{ return ui; }

	protected override function get model():Object{ return data; }

	protected override function get signalState():ISignalState{ return  state; }

}
}