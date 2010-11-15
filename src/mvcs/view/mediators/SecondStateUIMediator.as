package mvcs.view.mediators {
	import mvcs.models.SecondStateGuardModel;
	import mvcs.view.components.SecondStateUI;
	import mvcs.view.components.StateUI;

	import org.osflash.statemachine.core.ISignalState;

	public class SecondStateUIMediator extends StateUIMediator {
	[Inject]
	public var ui:SecondStateUI;

	[Inject]
	public var data:SecondStateGuardModel;

	[Inject(name="state/second")]
	public var state:ISignalState;

	protected override function get view():StateUI{ return ui; }

	protected override function get model():Object{ return data; }

	protected override function get signalState():ISignalState{ return  state; }

}
}