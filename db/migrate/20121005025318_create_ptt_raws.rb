class CreatePttRaws < ActiveRecord::Migration
  def change
    create_table :ptt_raws do |t|
      t.string :ptt_user_id
      t.string :title
      t.string :link

      t.timestamps
    end
  end
end
