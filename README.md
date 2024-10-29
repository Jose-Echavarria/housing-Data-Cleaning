Nashville Housing Data Cleaning Project
This project focuses on cleaning and standardizing a Nashville housing dataset using SQL. Key tasks include formatting dates, filling in missing address information, splitting address components, converting values for clarity, removing duplicates, and dropping unused columns.

Project Breakdown

1.Standardize Date Format
* Converted SaleDate to a standard date format and stored it in a new column, SaleDateConverted.

2. Populate Missing Address Data
* Used a self-join to fill in missing PropertyAddress values based on matching ParcelID.

3. Split Address Information
* Extracted individual address components from PropertyAddress and OwnerAddress, including separate columns for street, city, and state.

4. Transform 'Sold as Vacant' Data
* Converted SoldAsVacant values from "Y" and "N" to "Yes" and "No" for clarity and consistency.

5. Remove Duplicates
* Identified and removed duplicate records using a Common Table Expression (CTE) based on key columns like ParcelID, SalePrice, and SaleDate.

6. Column Cleanup
* Removed unused columns such as OwnerAddress, TaxDistrict, and PropertyAddress to streamline the dataset.
