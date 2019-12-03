# frozen_string_literal: true

class CreateItemUnitOfMeasureTrigger < ActiveRecord::Migration[6.0] # :nodoc:
  def up
    ActiveRecord::Base.connection.execute(
      <<-SQL
        CREATE or REPLACE FUNCTION insert_item_unit_of_measure()
        RETURNS trigger AS $$
          BEGIN
            INSERT INTO item_unit_of_measures(
              item_id,
              unit_of_measure_id,
              base_conversion,
              created_at,
              updated_at
            ) VALUES (
              new.id,
              new.unit_of_measure_id,
              1,
              current_timestamp,
              current_timestamp
            );
            RETURN NEW;
          END;
        $$
        LANGUAGE plpgsql;
      SQL
    )

    ActiveRecord::Base.connection.execute(
      <<-SQL
        CREATE TRIGGER insert_item_unit_of_measure
          AFTER INSERT ON items
          FOR EACH ROW
          EXECUTE PROCEDURE insert_item_unit_of_measure();
      SQL
    )
  end

  def down
    ActiveRecord::Base.connection.execute(
      'DROP TRIGGER insert_item_unit_of_measure ON items;'
    )

    ActiveRecord::Base.connection.execute(
      'DROP FUNCTION insert_item_unit_of_measure();'
    )
  end
end
