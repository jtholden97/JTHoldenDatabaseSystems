
--James Holden--
--Lab 10--


--
--function to find what courses are the prerequisite for a course--

--


create or replace function PreReqsFor(int, REFCURSOR) returns refcursor as 
$$
DECLARE
   selectedCourse INT := $1;
   resultset REFCURSOR := $2;
BEGIN
   open resultset FOR 
      SELECT preReqNum
      FROM Prerequisites
      WHERE courseNum = selectedCourse;
   return resultset;
end;
$$ 
language plpgsql;






--function to find what the course is a prerequisite for--

create or replace function IsPreReqFor(int, REFCURSOR) returns refcursor as 
$$
DECLARE
   selectedCourse INT := $1;
   result REFCURSOR := $2;
BEGIN
   open result FOR 
      SELECT courseNum
      FROM Prerequisites
      WHERE preReqNum = selectedCourse;
   return result;
end;
$$ 
language plpgsql;

