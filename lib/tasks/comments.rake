  desc "Add new comments"
  task add_comments: :environment do
    5.times do |n|
      counter = rand(1..9999)
      story = Story.create(title: "Story #{n} - #{counter}", url: "https://isorsa.com/stories/#{counter}")
      5.times do |i|
        comment = story.comments.create(body: "Comment #{i} - #{counter}")
        5.times do |j|
          sub_comment = comment.comments.create(body: "Sub comment #{i}.#{j} - #{counter}")
          5.times do |m|
            sub_comment.comments.create(body: "Sub sub comment #{i}.#{j}.#{m} - #{counter}")
          end
        end
      end
    end
  end
