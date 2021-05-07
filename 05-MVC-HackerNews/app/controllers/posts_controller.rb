require_relative '../models/post'
require_relative '../views/posts_view'
class PostsController
  def initialize
    @view = PostsView.new
    @post = Post.new
  end

  ################################################################
  # BEWARE: you MUST NOT use the global variable DB in this file #
  ################################################################

  def index
    # TODO: implement listing all posts
    @view.list_all_posts
  end

  def create
    # Creating a new post
    # Stores the post title in a variable
    title = @view.ask_user("What is the title of your post?")
    # Stores the post url in a variable
    url = @view.ask_user("What is the url of your post?")
    # Creates a new post instance
    new_post = Post.new({ title: title, url: url })
    new_post.save
  end

  def update
    # Updates an existing post

    # Stores the post id
    id = @view.ask_user("What is the id of your post?")
    # Stores the post title in a variable
    title = @view.ask_user("What is the new title of your post?")
    # Stores the post url in a variable
    url = @view.ask_user("What is the new url of your post?")
    # Creates a new post instance
    new_post = Post.new({ id: id, title: title, url: url })
    new_post.update
  end

  def destroy
    # Destroys a post

    # Stores the post id
    id = @view.ask_user("What post should be deleted? Please enter the id")
    # Calls on the destroy method in the post class
    @post.destroy(id)
  end

  def upvote
    # Adds an upvote counter to a post
    upvote_id = @view.ask_user("Which post would you like to upvote?").to_i
    post = @post.find(upvote_id)
    post.votes += 1
    post.update
  end
end

# new_post = PostsController.new
# puts PostsController
