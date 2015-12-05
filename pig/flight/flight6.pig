--loading data
fulldata = load '$INPUT' USING PigStorage(',')
	as (Year:int,Month:int,DayofMonth:int,DayOfWeek:int,DepTime:int,CRSDepTime:int,ArrTime:int,CRSArrTime:int,
		UniqueCarrier:chararray,FlightNum:int,TailNum:chararray,ActualElapsedTime:int,CRSElapsedTime:int,
		AirTime:int,ArrDelay:int,DepDelay:int,Origin:chararray,Dest:chararray,Distance:int,TaxiIn:int,TaxiOut:int,
		Cancelled:int,CancellationCode:chararray,Diverted:int,CarrierDelay:int,WeatherDelay:int,
		NASDelay,SecurityDelay:int,LateAircraftDelay:int);


-- throw away the unnecessary data
dept = FOREACH fulldata GENERATE Origin as Origin, Cancelled as Cancelled;
-- filter the flight is really departed
dept = FILTER dept BY Cancelled == 0;
-- throw away the unnecessary data
dept = FOREACH dept GENERATE Origin as orig;
-- count the departs
dept2 = GROUP dept BY orig;
count_dept = FOREACH dept2 GENERATE group as name, COUNT(dept) as amount;

-- generate all possible routes
airport = FOREACH fulldata GENERATE Origin as name;
airport2 = DISTINCT airport;
airport3 = FOREACH fulldata2 GENERATE Origin as name2;
airport4 = DISTINCT airport3;
all_pairing = CROSS airport2, airport4;
all_pairing = FOREACH all_pairing GENERATE $0 as orig, $1 as dest;
all_pairing = FILTER all_pairing BY orig != dest;
-- generate real routes
real_pairing = FOREACH fulldata GENERATE Origin as real_orig, Dest as real_dest;
real_pairing = DISTINCT real_pairing;

not_pairing = JOIN all_pairing BY (orig,dest) LEFT OUTER, real_pairing BY (real_orig,real_dest);
not_pairing2 = FILTER not_pairing BY $3 IS NULL;
not_pairing3 = FOREACH not_pairing2 GENERATE $0 as orig, $1 as dest;

data = JOIN not_pairing3 BY orig, count_dept BY name;
data2 = FOREACH data GENERATE not_pairing3::orig as orig, not_pairing3::dest as dest, count_dept::amount as orig_amount;
data3 = JOIN data2 BY dest, count_dept BY name;
data4 = FOREACH data3 GENERATE data2::orig as orig, data2::dest as dest, data2::orig_amount as orig_amount, count_dept::amount as dept_amount;
data5 = FOREACH data4 GENERATE orig as orig, dest as dest, orig_amount+dept_amount as sum_amount;

data6 = GROUP data5 ALL;
themax = FOREACH data6 GENERATE MAX(data5.sum_amount) as val;

thebiggest = FILTER data5 by sum_amount == themax.val;

STORE thebiggest INTO '$OUTPUT'; -- USING PigStorage('\t','-schema');