package reflex.layouts
{
	
	import flash.geom.Point;
	import flash.geom.Rectangle;
	
	import reflex.measurement.resolveHeight;
	import reflex.measurement.resolveWidth;
		
	[LayoutProperty(name="width", measure="true")]
	[LayoutProperty(name="height", measure="true")]
	
	/**
	 * Provides a measured layout from left to right.
	 * 
	 * @alpha
	 **/
	public class HorizontalLayout extends Layout implements ILayout
	{
		
		public var gap:Number = 5;
		public var edging:Boolean = false;
		
		override public function measure(children:Array):Point
		{
			var point:Point = super.measure(children);
			point.x = edging ? gap/2 : 0;
			for each(var child:Object in children) {
				var width:Number = reflex.measurement.resolveWidth(child);
				var height:Number = reflex.measurement.resolveHeight(child);
				point.x += width + gap;
				point.y = Math.max(point.y, height);
			}
			point.x -= edging ? gap/2 : gap;
			return point;
		}
		
		override public function update(children:Array, rectangle:Rectangle):void
		{
			super.update(children, rectangle);
			if(children) {
				// this takes a few passes for percent-based measurement. we can probably speed it up later
				var availableSpace:Point = reflex.measurement.calculateAvailableSpace(children, rectangle);
				var percentageTotals:Point = reflex.measurement.calculatePercentageTotals(children);
				
				var position:Number = edging ? gap/2 : 0;
				var length:int = children.length;
				
				availableSpace.x -= edging ? gap*length : gap*(length-1);
				for(var i:int = 0; i < length; i++) {
					var child:Object = children[i];
					var width:Number = reflex.measurement.resolveWidth(child, availableSpace.x, percentageTotals.x);  // calculate percentWidths based on available width and normalized percentages
					var height:Number = reflex.measurement.resolveHeight(child, rectangle.height); // calculate percentHeights based on full height and with no normalization
					reflex.measurement.setSize(child, Math.round(width), Math.round(height));
					child.x = Math.round(position);
					child.y = Math.round(rectangle.height/2 - height/2);
					position += width + gap;
				}
			}
		}
		
	}
}