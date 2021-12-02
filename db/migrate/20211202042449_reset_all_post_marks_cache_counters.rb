class ResetAllPostMarksCacheCounters < ActiveRecord::Migration[6.1]
  def up
    Post.find_each { |post| Post.reset_counters(post.id, :marks_count) }
  end

  def down; end
end
