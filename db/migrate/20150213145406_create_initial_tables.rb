class CreateInitialTables < ActiveRecord::Migration
  def change
    create_table :users do |t|
      t.string :name
      t.string :email
      t.string :password_hash
    end

    create_table :polls do |t|
      t.integer :creator_id
      t.string :name
      t.timestamps
    end

    create_table :questions do |t|
      t.string :text
      t.integer :poll_id
    end

    create_table :choices do |t|
      t.integer :question_id
      t.string :content
    end

    create_table :answers do |t|
      t.integer :taken_poll_id
      t.integer :choice_id
    end

    create_table :poll_submissions do |t|
      t.integer :poll_id
      t.integer :responder_id

      t.timestamps
    end
  end
end


