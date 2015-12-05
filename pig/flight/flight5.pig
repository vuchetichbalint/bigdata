--loading data
fulldata = load '$INPUT' USING PigStorage(',')
	as (Year:int,Month:int,DayofMonth:int,DayOfWeek:int,DepTime:int,CRSDepTime:int,ArrTime:int,CRSArrTime:int,
		UniqueCarrier:chararray,FlightNum:int,TailNum:chararray,ActualElapsedTime:int,CRSElapsedTime:int,
		AirTime:int,ArrDelay:int,DepDelay:int,Origin:chararray,Dest:chararray,Distance:int,TaxiIn:int,TaxiOut:int,
		Cancelled:int,CancellationCode:chararray,Diverted:int,CarrierDelay:int,WeatherDelay:int,
		NASDelay,SecurityDelay:int,LateAircraftDelay:int);

pairing = FOREACH fulldata GENERATE Origin as orig, Dest as dest;
pairing = DISTINCT pairing;
pairing_grp = GROUP pairing ALL;
pairing_count = FOREACH pairing_grp GENERATE COUNT(pairing);

STORE pairing_count INTO '$OUTPUT'; -- USING PigStorage('\t','-schema');