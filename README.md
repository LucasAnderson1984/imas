[![CircleCI](https://circleci.com/gh/LucasAnderson1984/imas.svg?style=svg&circle-token=705aa89f7de55d6a22d02fbd122597d33264ff9a)](https://circleci.com/gh/LucasAnderson1984/imas)
[![Maintainability](https://api.codeclimate.com/v1/badges/7ed3e077b116499ce906/maintainability)](https://codeclimate.com/github/LucasAnderson1984/imas/maintainability)
[![Test Coverage](https://api.codeclimate.com/v1/badges/7ed3e077b116499ce906/test_coverage)](https://codeclimate.com/github/LucasAnderson1984/imas/test_coverage)

# imas
Item Manufacturing and Sales

# Purpose
This is a project for CSU Fresno CSCI 226. The concept is to show how relational databases work. The project is going to use a real world example of how items are built from raw materials and then selling those items to customers.

# Trigger
There is a trigger that adds an item and it's unit of measure to the item unit of
measure table after an item gets created.

```
create or replace function insert_item_unit_of_measure() returns trigger AS $$
begin
insert into item_unit_of_measures (item_id, unit_of_measure_id, base_conversion, created_at, updated_at)
values
(new.id, new.unit_of_measure_id, 1, current_timestamp, current_timestamp);
return new;
end;
$$
language plpgsql;

create trigger insert_item_unit_of_measure
after insert
on items
for each row
execute procedure insert_item_unit_of_measure();
```
