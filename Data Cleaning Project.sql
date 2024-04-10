--Cleaning Data in SQL Queries

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

--Standerdize Data Format

SELECT SaleDate, CONVERT(date,SaleDate)
FROM PortfolioProject.dbo.NashvilleHousing

Update NashvilleHousing
Set SaleDate =CONVERT(Date,SaleDate)

Alter Table NashvilleHousing
ADD SaleDateConverted Date;

UPDATE NashvilleHousing
SET SaleDateConverted = CONVERT(Date,SaleDate)

SELECT SaleDateConverted
FROM PortfolioProject.dbo.NashvilleHousing



-- Populate Propert Adress Data

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing
--WHERE PropertyAddress is null
Order by ParcelId

SELECT A.ParcelID, A.PropertyAddress, B.ParcelID, B.PropertyAddress, ISNULL(a.propertyaddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing as A
join PortfolioProject.dbo.NashvilleHousing as B
	on A.parcelID = B.ParcelID
	AND A.[UniqueID] <> B.[UniqueID]
	Where a.PropertyAddress is null

	UPDATE a
	SET PropertyAddress = ISNULL(a.propertyaddress,b.PropertyAddress)
FROM PortfolioProject.dbo.NashvilleHousing as A
join PortfolioProject.dbo.NashvilleHousing as B
	on A.parcelID = B.ParcelID
	AND A.[UniqueID] <> B.[UniqueID]
	Where a.PropertyAddress is null

	--breaking out Address into Individual Colums(Address, City, State)

SELECT PropertyAddress
FROM PortfolioProject.dbo.NashvilleHousing

SELECT
SUBSTRING(PropertyAddress, 1,CharINDEX(',',PropertyAddress) -1 ) as address,
SUBSTRING(PropertyAddress, CharINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) as address
FROM PortfolioProject.dbo.NashvilleHousing


Alter Table NashvilleHousing
ADD PropertySplitAddress NVarchar(255)

Update NashvilleHousing
Set PropertySplitAddress = SUBSTRING(PropertyAddress, 1,CharINDEX(',',PropertyAddress) -1 ) 

Alter Table NashvilleHousing
ADD PropertySplitCity NVarchar(255)

Update NashvilleHousing
Set PropertySplitCity = SUBSTRING(PropertyAddress, CharINDEX(',',PropertyAddress) +1, LEN(PropertyAddress)) 

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing



Select
PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)
,PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE NashvilleHousing
Add OwnerSplitAddress Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitAddress = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 3)


ALTER TABLE NashvilleHousing
Add OwnerSplitCity Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitCity = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 2)



ALTER TABLE NashvilleHousing
Add OwnerSplitState Nvarchar(255);

Update NashvilleHousing
SET OwnerSplitState = PARSENAME(REPLACE(OwnerAddress, ',', '.') , 1)

SELECT *
FROM PortfolioProject.dbo.NashvilleHousing

-- Change Y and N to Yes and No in "Sold as Vacant" field


SELECT DISTINCT(SoldAsVacant), Count(SoldAsVacant)
FROM PortfolioProject.dbo.NashvilleHousing
Group by SoldAsVacant
order by 2

SELECT soldasvacant
, Case When SoldasVacant = 'Y' Then 'Yes'
	When SoldasVacant = 'N' Then 'No'
	Else SoldAsVacant
	END
FROM PortfolioProject.dbo.NashvilleHousing


Update NashvilleHousing
SET SoldAsVacant = CASE When SoldAsVacant = 'Y' THEN 'Yes'
	   When SoldAsVacant = 'N' THEN 'No'
	   ELSE SoldAsVacant
	   END


--Remove Duplicates

With RowNumCTE As(
Select *,
	ROW_NUMBER() OVER (
	PARTITION BY ParcelID,
				 PropertyAddress,
				 SalePrice,
				 SaleDate,
				 LegalReference
				 ORDER BY
					UniqueID
					) row_num
From PortfolioProject.dbo.NashvilleHousing
)
SELECT *
FROM RowNumCTE
WHERE row_num >1 


--DELETE Unused Columns

SELECT *
From PortfolioProject.dbo.NashvilleHousing

ALTER TABLE PortfolioProject.dbo.NashvilleHousing
DROP COLUMN OwnerAddress, TaxDistrict, PropertyAddress, SaleDate
