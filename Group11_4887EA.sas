
proc import
	out=Data
	datafile="/home/u63576885/4887EA/Project_Housing.csv"
	dbms=csv
	replace;
run;


proc sql;
    select *
    from Data(obs=20);
run;


proc sgplot data=Data;
  title "Average Number of Receptions by Property Type";
  vbar FlatType / response=Totalreceptions stat=mean;
run;


proc sql;
create table Flatpopulation as
select FlatType,count(FlatType) as population from Data
	GROUP BY FlatType;
	
run;

proc sgpie data = Flatpopulation;
	title "Contribution of House Type";
	pie FlatType/ response=population datalabeldisplay=(response percent );
run;



proc sql;
create table Frequency1 as
  select FlatType, Totalbaths, count(*) as Frequency
  from Data
  where FlatType in ('flat', 'terraced house')
  group by FlatType, Totalbaths;
  
  select* from Frequency1
run;

proc sgplot data=Frequency1;
  title "Distribution of the number Bathrooms by FlatType";
  vbox Totalbaths / category=FlatType;
run;

proc sql;
create table Turnover1 as
  select FlatType, sum(price) as Turnover
  from Data
  group by FlatType
  order by Turnover desc;
  
  select * from Turnover1;
run;

proc sgplot data=Turnover1;
  title "Turnover by FlatType";
  vbar FlatType / response=Turnover;
  xaxis discreteorder=data;
run;
/*proc sgplot data=Data;
  title "Scatter Plot";
  scatter x=Totalbeds Totalbaths y=price;
run;
*/
/*proc sql;
  create table AvgPriceBeds as
  select Totalbeds, FlatType, mean(Price) as Avg_Price
  from Data
  group by Totalbeds, FlatType;
  select* from AvgPriceBeds;
quit;
proc sgplot data=AvgPriceBeds;
  scatter x=FlatType y=Totalbeds / colorresponse=Avg_Price colormodel=(viridis);
  xaxis display=(nolabel);
  yaxis grid;
run;*/
proc sql;
  create table AvgPriceBeds as
  select Totalbeds,mean(Price) as Avg_Price
  from Data
  group by Totalbeds;
  select* from AvgPriceBeds;
  
run;
proc sql;
  create table AvgPriceBaths as
  select Totalbaths,mean(Price) as Avg_Price
  from Data
  group by Totalbaths;
  select* from AvgPriceBaths;
  
run;
proc sgplot data=AvgPriceBeds;
    title 'Scatter of Beds-AvgPrice';
    scatter x=Totalbeds y=Avg_Price;

    
    
run;
proc sgplot data=AvgPriceBaths;
	TITLE 'Scatter of Bathrooms-AvgPrice';
    scatter x = Totalbaths  y = Avg_Price;

  
run;

