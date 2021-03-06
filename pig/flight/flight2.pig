--loading data
fulldata = load '$INPUT' USING PigStorage(',')
	as (Year:int,Month:int,DayofMonth:int,DayOfWeek:int,DepTime:int,CRSDepTime:int,ArrTime:int,CRSArrTime:int,
		UniqueCarrier:chararray,FlightNum:int,TailNum:chararray,ActualElapsedTime:int,CRSElapsedTime:int,
		AirTime:int,ArrDelay:int,DepDelay:int,Origin:chararray,Dest:chararray,Distance:int,TaxiIn:int,TaxiOut:int,
		Cancelled:int,CancellationCode:chararray,Diverted:int,CarrierDelay:int,WeatherDelay:int,
		NASDelay,SecurityDelay:int,LateAircraftDelay:int);

-- throw away the unnecessary data
dept = FOREACH fulldata GENERATE Origin as orig, Cancelled as Cancelled;
-- filter the flight is really departed
dept = FILTER dept BY Cancelled == 0;
-- throw away the unnecessary data
dept = FOREACH dept GENERATE orig as orig;
--count the departs
dept2 = GROUP dept BY orig;
count_dept = FOREACH dept2 GENERATE group as name, COUNT(dept) as amount;

STORE count_dept INTO '$OUTPUT'; -- USING PigStorage('\t','-schema');