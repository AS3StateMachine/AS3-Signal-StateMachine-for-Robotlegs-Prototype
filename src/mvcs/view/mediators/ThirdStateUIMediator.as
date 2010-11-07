package mvcs.view.mediators {
import mvcs.models.ThirdStateGuardModel;
import mvcs.view.components.StateUI;
import mvcs.view.components.ThirdStateUI;

import org.osflash.statemachine.core.ISignalState;

public class ThirdStateUIMediator extends StateUIMediator {
	[Inject]
	public var ui:ThirdStateUI;

	[Inject]
	public var data:ThirdStateGuardModel;

	[Inject(name="state/third")]
	public var state:ISignalState;

	protected override function get view():StateUI{ return ui; }

	protected override function get model():Object{ return data; }

	protected override function get signalState():ISignalState{ return  state; }

}
}