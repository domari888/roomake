class CreateInquiries < ActiveRecord::Migration[6.1]
  def change
    create_table :inquiries do |t|
      t.string :name, null: false
      t.string :name_kana, null: false
      t.string :email, null: false
      t.text :content, null: false
      t.inet :remote_ip

      t.timestamps
    end
  end
end
