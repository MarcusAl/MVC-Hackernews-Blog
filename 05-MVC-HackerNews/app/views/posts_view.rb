require_relative '../models/post'
class PostsView
  # TODO: implement methods called by the PostsController
  def initialize
    @posts = Post.new
  end

  def list_all_posts
    array = @posts.all.flatten
    array.each do |post|
      puts '----------------'
      puts "#{post.id}.#{post.title}"
      puts post.url
      puts post.votes
      puts '----------------'
    end
  end

  def ask_user(message)
    puts message
    answer = gets.chomp
    puts '>'
    return answer
  end
end
