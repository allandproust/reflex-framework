package reflex.measurement
{
	
	/**
	 * @alpha
	 */
	public function resolveWidth(object:Object, total:Number = NaN, percentageTotal:Number = 100):Number // this utility is getting interesting, more docs soon
	{
		//var explicit:IMeasurements;
		//var measured:IMeasurements;
		//var percent:IMeasurablePercent;
		if (object is IMeasurable && (object as IMeasurable).explicit != null && !isNaN((object as IMeasurable).explicit.width)) { // explicit width is defined
			return (object as IMeasurable).explicit.width;
		} else if(object is IMeasurablePercent && !isNaN(total) && !isNaN((object as IMeasurablePercent).percentWidth)) { // support percent-based measurement
			return total * (object as IMeasurablePercent).percentWidth/percentageTotal;
		} else if(object is IMeasurable && (object as IMeasurable).measured != null && !isNaN((object as IMeasurable).measured.width)) { // measured width is defined
			return (object as IMeasurable).measured.width;
		} else if(object != null) { // we'll try to find a width anyways (even on non-DisplayObjects)
			try {
				return object.width;
			} catch(e:Error) {}
			return 0;
		} else {
			return 0;
		}
	}
	
}