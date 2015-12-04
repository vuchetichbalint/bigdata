--loading data
fulldata = load '$INPUT' using PigStorage(',') 
	as (Year:int,Month:int,DayofMonth:int,DayOfWeek:int,DepTime:int,CRSDepTime:int,ArrTime:int,CRSArrTime:int,
		UniqueCarrier:chararray,FlightNum:int,TailNum:chararray,ActualElapsedTime:int,CRSElapsedTime:int,
		AirTime:int,ArrDelay:int,DepDelay:int,Origin:chararray,Dest:chararray,Distance:int,TaxiIn:int,TaxiOut:int,
		Cancelled:int,CancellationCode:chararray,Diverted:int,CarrierDelay:int,WeatherDelay:int,
		NASDelay,SecurityDelay:int,LateAircraftDelay:int);


-- throw away the unnecessary data
data = FOREACH fulldata GENERATE Origin as Origin, Cancelled as Cancelled;
-- filter the flight is realy departed
real_dept = FILTER fulldata BY Cancelled == 0;
-- throw away the unnecessary data
data = FOREACH real_dept GENERATE Origin as Origin;
--count the departs
grp_dept = GROUP real_dept BY Origin;
count_dept = FOREACH grp_dept GENERATE group as grp, COUNT(grp) as num;

STORE count_dept INTO '$OUTPUT'; -- USING PigStorage('\t','-schema');