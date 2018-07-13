
truncate table xwavgscore

truncate table xwstucourse

insert into xwstucourse
select *  from [学位名单成绩表201801]

insert into xwavgscore
select *  from[学位必修课平均分201801]

(33293 行受影响)

(1330 行受影响)
select count(*) from xwavgscore
select count(*) from xwstucourse