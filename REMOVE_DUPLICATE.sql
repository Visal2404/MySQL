SELECT * 
FROM layoffs;

-- 1. Remove Duplicate 
-- 2. Standardize the Data 
-- 3. NULL value or blank value
-- 4. Remove any columns

-- Create a staging table 
 
 CREATE TABLE layoffs_staging 
 LIKE layoffs;
 
SELECT * from layoffs_staging;
 
 INSERT layoffs_staging 
 SELECT * 
 FROM layoffs;
 
 -- Remove duplicate 
 
 WITH remove_duplicate_cte AS
 (
 SELECT *,
 ROW_NUMBER () OVER(
 PARTITION BY company, location, industry, total_laid_off, 
 percentage_laid_off, `date`, stage, country, funds_raised_millions) AS num_row
 FROM layoffs_staging
 )
 SELECT * 
 FROM remove_duplicate_cte
 WHERE num_row> 1
 ;

-- Create one more staging area table for num_row
CREATE TABLE `layoffs_staging2` (
  `company` text,
  `location` text,
  `industry` text,
  `total_laid_off` int DEFAULT NULL,
  `percentage_laid_off` text,
  `date` text,
  `stage` text,
  `country` text,
  `funds_raised_millions` int DEFAULT NULL,
  `num_row` INT
) ENGINE=InnoDB DEFAULT CHARSET=utf8mb4 COLLATE=utf8mb4_0900_ai_ci;

SELECT * FROM layoffs_staging2;
	
INSERT INTO layoffs_staging2
 SELECT *,
 ROW_NUMBER () OVER(
 PARTITION BY company, location, industry, total_laid_off, 
 percentage_laid_off, `date`, stage, country, funds_raised_millions) AS num_row
 FROM layoffs_staging;

DELETE FROM layoffs_staging2 
WHERE num_row > 1;

SELECT * FROM layoffs_staging2; 
