-- STANDARDIZE DATA

SELECT company, TRIM(company)
FROM layoffs_staging2;

-- TRIM company column

UPDATE layoffs_staging2
SET company  = TRIM(company);

SELECT * FROM layoffs_staging2;

SELECT DISTINCT(industry)
FROM layoffs_staging2
ORDER BY 1;

SELECT * 
FROM layoffs_staging2
WHERE industry LIKE 'Crypto%';

-- Update any column that Crypto% to Crypto

UPDATE layoffs_staging2
SET industry = 'Crypto'
WHERE industry LIKE 'Crypto%';

SELECT DISTINCT (country), TRIM(TRAILING '.' FROM country)
FROM layoffs_staging2
ORDER By 1;

-- TRIM country column on United States

UPDATE layoffs_staging2
SET country  = TRIM(TRAILING '.' FROM country)
WHERE country LIKE 'United States%';

SELECT * FROM layoffs_staging2layoffs_staging2
WHERE country like 'United States';

SELECT `date`layoffs_staging
FROM layoffs_staging2;

-- Change the type of column on date (from date to string)

UPDATE layoffs_staging2
SET `date` = STR_TO_DATE(`date`, '%m/%d/%Y');

ALTER TABLE layoffs_staging2
MODIFY COLUMN `date` DATE;

SELECT * FROM layoffs_staging2
WHERE industry IS NULL
OR  industry = '';

UPDATE layoffs_staging2
SET industry  = NULL 
WHERE industry = '';

-- Update column where industry is null to info 

UPDATE layoffs_staging2 t1 
JOIN layoffs_staging2 t2
	ON t1.company = t2.company 
SET t1.industry = t2.industry
WHERE t1.industry IS NULL 
AND t2.industry IS NOT NULL;

SELECT company, industry 
FROM layoffs_staging2
WHERE industry = 'Travel';

SELECT * FROM layoffs_staging2;

-- Delete row where total laid off and percentage is null

DELETE 
FROM layoffs_staging2 
WHERE total_laid_off IS NULL 
AND percentage_laid_off IS NULL;

ALTER TABLE layoffs_staging2
DROP COLUMN num_row;