class Story < ApplicationRecord
  has_many :comments, as: :commentable

  # recursive approach in the code
  def slow_count_comments(story)
    count = story.comments.count
    story.comments.each { |comment| count += slow_count_comments(comment) }
    count
  end

  def fast_count_comments(story)
    sql = <<-SQL
      WITH RECURSIVE story_comments AS (
        SELECT id, commentable_id FROM comments WHERE commentable_id = #{story.id} AND commentable_type = 'Story'
        UNION
        SELECT c.id, c.commentable_id FROM comments AS c
        INNER JOIN story_comments AS sc ON ((sc.id = c.commentable_id) AND (c.commentable_type = 'Comment'))
      ) SELECT count(*) FROM story_comments;
    SQL
    count = Comment.count_by_sql(sql)
    count
  end

end

# reload!; story = Story.find 2; p story.child_comment_count(story)