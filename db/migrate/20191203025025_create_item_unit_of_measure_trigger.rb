class CreateItemUnitOfMeasureTrigger < ActiveRecord::Migration[6.0]
  def up
    ActiveRecord::Base.connection.execute(
      'create or replace function insert_item_unit_of_measure() ' \
      'returns trigger AS $$ ' \
      'begin ' \
      'insert into item_unit_of_measures ' \
      '(item_id, unit_of_measure_id, base_conversion, created_at, ' \
      'updated_at) values ' \
      '(new.id, new.unit_of_measure_id, 1, current_timestamp, ' \
      'current_timestamp); ' \
      'return new; ' \
      'end; ' \
      '$$ ' \
      'language plpgsql;'
    )

    ActiveRecord::Base.connection.execute(
      'create trigger insert_item_unit_of_measure ' \
      'after insert ' \
      'on items ' \
      'for each row ' \
      'execute procedure insert_item_unit_of_measure();'
    )
  end

  def down
    ActiveRecord::Base.connection.execute(
      'drop trigger insert_item_unit_of_measure on items;'
    )

    ActiveRecord::Base.connection.execute(
      'drop function insert_item_unit_of_measure();'
    )
  end
end
