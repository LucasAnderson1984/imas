[![CircleCI](https://circleci.com/gh/LucasAnderson1984/imas.svg?style=svg&circle-token=705aa89f7de55d6a22d02fbd122597d33264ff9a)](https://circleci.com/gh/LucasAnderson1984/imas)
[![Maintainability](https://api.codeclimate.com/v1/badges/7ed3e077b116499ce906/maintainability)](https://codeclimate.com/github/LucasAnderson1984/imas/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7ed3e077b116499ce906/test_coverage)](https://codeclimate.com/github/LucasAnderson1984/imas/test_coverage)

# imas
Item Manufacturing and Sales

# Purpose
This is a project for CSU Fresno CSCI 226. The concept is to show how relational databases work. The project is going to use a real world example of how items are built from raw materials and then selling those items to customers.

# Forecasting

Query for Forecasting
```
Select
CU.name,
IT.item_number,
IT.item_description,
'Each' as unit_of_measure,
to_char(SA.sales_date, 'yyyy-mm') as year_month,
sum(SA.sales_quantity * IUOM.base_conversion) as sales_quantity

From
sales SA
  Join customers CU
    On CU.id = SA.customer_id
  Join items IT
    On IT.id = SA.item_id
  Join unit_of_measures UOM
    On UOM.id = SA.unit_of_measure_id
  Join item_unit_of_measures IUOM
    On IUOM.item_id = SA.item_id and IUOM.unit_of_measure_id = SA.unit_of_measure_id

Group by
CU.name,
IT.item_number,
IT.item_description,
UOM.code,
year_month;
```
