package mvcs.view.events {
import flash.events.Event;

public class WriteEvent extends Event {
	public static const WRITE:String = "write";
	public var msg:String;

	public function WriteEvent( type:String, msg:String ){
		this.msg = msg;
		super( type );
	}

	override public function clone():Event{
		return new WriteEvent( type, msg );
	}

}
}