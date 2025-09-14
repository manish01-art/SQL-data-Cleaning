# 🗂️ Layoff Data Cleaning (SQL Project)

[![Made with SQL](https://img.shields.io/badge/Made%20with-SQL-blue?logo=postgresql)](https://www.postgresql.org/)  
[![GitHub repo size](https://img.shields.io/github/repo-size/your-username/layoff-data-cleaning)](https://github.com/your-username/layoff-data-cleaning)  
[![GitHub stars](https://img.shields.io/github/stars/your-username/layoff-data-cleaning?style=social)](https://github.com/your-username/layoff-data-cleaning/stargazers)  
[![License](https://img.shields.io/badge/License-MIT-green.svg)](LICENSE)  

📊 **Objective:** Clean and standardize a messy layoffs dataset to make it analysis-ready.  

---

## ⚡ Features  

- 🔄 **Remove Duplicates** using `ROW_NUMBER()`  
- 🏷️ **Standardize Data** → Company names, industries, countries, dates  
- 🧹 **Handle Missing Values** with self-joins and replacements  
- 📅 **Convert Dates** from string to proper SQL `DATE` format  
- ✅ **Final Clean Table** ready for insights & dashboards  

---

## 🔧 Process Overview  

### 1️⃣ Remove Duplicates  
```sql
ROW_NUMBER() OVER (
  PARTITION BY company, location, industry, total_laid_off, percentage_laid_off, date, stage, country, funds_raised_millions
  ORDER BY company
) AS row_num
```

### 2️⃣ Standardize Data  
- Trim extra spaces in company names  
- Merge inconsistent industry labels (`Crypto%` → `Crypto`)  
- Fix country variations (`United States`, `United States of America`)  
- Convert text-based dates → SQL `DATE`  

### 3️⃣ Handle Missing Values  
- Replace `'NULL'` & blanks with `NULL`  
- Fill missing industries by referencing other rows  

### 4️⃣ Final Table  
- Dropped helper columns (`row_num`)  
- Output → **`layoff2`** (clean dataset)  

---

## 📂 Repository Structure  

```
📁 Layoff-Data-Cleaning
 ┣ 📜 layoff_staging.sql   # Main SQL script for cleaning
 ┣ 📜 README.md            # Documentation
 ┣ 📜 LICENSE              # MIT License
```

---

## 📊 Example Queries  

```sql
-- Check cleaned dataset
SELECT * FROM layoff2;

-- Industries most impacted by layoffs
SELECT industry, COUNT(*) AS layoffs_count
FROM layoff2
GROUP BY industry
ORDER BY layoffs_count DESC;

-- Layoffs trend by year
SELECT EXTRACT(YEAR FROM date) AS year, SUM(total_laid_off) AS total
FROM layoff2
GROUP BY year
ORDER BY year;
```

---

## 🔮 Future Enhancements  
- 📈 Build dashboards in Power BI / Tableau  
- ⚙️ Automate pipeline using Airflow  
- 📤 Publish cleaned dataset  

---

---

✨ If you like this project, don’t forget to **⭐ star the repo**!  
