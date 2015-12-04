--loading data
fulldata = load '$INPUT' using PigStorage(',') 
	as (Year:int,Month:int,DayofMonth:int,DayOfWeek:int,DepTime:int,CRSDepTime:int,ArrTime:int,CRSArrTime:int,
		UniqueCarrier:chararray,FlightNum:int,TailNum:chararray,ActualElapsedTime:int,CRSElapsedTime:int,
		AirTime:int,ArrDelay:int,DepDelay:int,Origin:chararray,Dest:chararray,Distance:int,TaxiIn:int,TaxiOut:int,
		Cancelled:int,CancellationCode:chararray,Diverted:int,CarrierDelay:int,WeatherDelay:int,
		NASDelay,SecurityDelay:int,LateAircraftDelay:int);


-- throw away the unnecessary data
dept = FOREACH fulldata GENERATE Origin as Origin, Cancelled as Cancelled;
-- filter the flight is realy departed
dept = FILTER dept BY Cancelled == 0;
-- throw away the unnecessary data
dept = FOREACH dept GENERATE Origin as Origin;
--count the departs
dept = GROUP dept BY Origin;

--count_dept = FOREACH dept GENERATE dept.Origin as name, COUNT(dept) as one;
count_dept = FOREACH dept GENERATE COUNT(dept) as one;

/*
pairing = FOREACH fulldata GENERATE Origin as Origin, Dest as Dest;
pairing = DISTINCT pairing;
pairing = JOIN pairing as orig BY Origin OUTER pairing as dest BY Dest;
pairing = FILTER pairing BY orig.Origin == NULL OR dest.Dest == NULL;

pairing = JOIN pairing BY orig.Origin, count_dept BY
*/


STORE dept INTO '$OUTPUT'; -- USING PigStorage('\t','-schema');