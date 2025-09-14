select * from layoffs

/**Process**/

--1) Remove Duplicates
--2) Standardize data
--3) Remove NUll/Blank values
--4) Remove any column

create table layoffs_staging( like layoffs including all)

select * from layoffs_Staging

insert into layoffs_staging
select * from layoffs

with duplicates_rows as(
select  *, 
row_number() over(partition by company,location,industry,total_laid_off,percentage_laid_off
,date,stage,country,funds_raised_millions
) as  row_num
from layoffs_staging
)
select *
from duplicates_rows
where row_num>1

select * from layoffs_Staging
where company = 'Casper'

delete  from layoffs_staging
where row_num > 1

--creating another table as layoff2 to make row_num as as permanent column and deleting duplicates later.
	
CREATE TABLE layoff2 AS
SELECT *,
       ROW_NUMBER() OVER (
           PARTITION BY company, location, industry, total_laid_off,
                        percentage_laid_off, date, stage, country, funds_raised_millions
           ORDER BY company
       ) AS row_num
FROM layoffs_staging;

select * from layoff2
	
delete from layoff2
where row_num>1

select * from layoff2
where row_num>1

--Standardizing data

-- Trimming Company
	
select company,trim(company) as TrimCompany
from layoff2;

update layoff2
set company  = trim(company)

select * from layoff2

-- Updating Industry	

select  * 
from layoff2
where industry like 'Crypto%'

update  layoff2
set industry = 'Crypto'
where industry like 'Crypto%'

select distinct(industry) from
layoff2 
	
-- Updating Country
	
select distinct(country) from layoff2
	where country = 'United States'

update layoff2
set country = 'United States'
where country like 'United States%'

select * from layoff2
where country = 'United States'
order by 1

--Updating Date

select *from layoff2

SELECT date FROM layoff2 WHERE date !~ '^\d{1,2}/\d{1,2}/\d{4}$' OR date IS NULL;

UPDATE layoff2 SET date = NULL WHERE date !~ '^\d{1,2}/\d{1,2}/\d{4}$';

SELECT date, TO_DATE(date, 'MM/DD/YYYY') AS converted FROM layoff2 ;

ALTER TABLE layoff2
ALTER COLUMN date TYPE date USING TO_DATE(date, 'MM/DD/YYYY');

-- Populating Data

select * from layoff2
where total_laid_off = 'NULL' 
and percentage_laid_off = 'NULL'	;


select * from layoff2
where industry = 'NULL'
or industry = ''


select * from layoff2
where company = 'Airbnb'

select * from layoff2 t1
join layoff2 t2
on t1.company = t2.company
and t1.location = t2.location
where (t1.industry is null or t1.industry = '')
and t2.industry is not null


update layoff2
	set industry = 'NULL'
	where industry = ''

UPDATE layoff2 t1
SET industry = t2.industry
FROM layoff2 t2
WHERE t1.company = t2.company
  AND (t1.industry IS NULL )
  AND t2.industry IS NOT NULL;


--droped row_num
alter table layoff2
drop column row_num

---final view

select * from layoff2






