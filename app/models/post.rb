require 'sqlite3'
DB = SQLite3::Database.new("./db/posts.db")
class Post
  # TODO: Gather all code from all previous exercises
  # - reader and accessors
  # - initialize
  # - self.find
  # - self.all
  # - save
  # - destroy
  attr_reader :id, :db
  attr_accessor :title, :url, :votes

  def initialize(attr = {})
    @id = attr[:id] || nil
    @title = attr[:title] || nil
    @url = attr[:url] || nil
    @votes = attr[:votes] || 0
  end

  def find(id)
    query = <<-SQL
    SELECT * FROM posts
    WHERE id = "#{id}"
    SQL
    exec = DB.execute(query).flatten
    if exec.empty?
      return nil
    else
      Post.new({ id: exec[0], title: exec[1], url: exec[2] })
    end
  end

  def all
    array = []
    array_database = DB.execute('SELECT * FROM posts')
    array_database.each do |ar|
      array << Post.new({ id: ar[0], title: ar[1], url: ar[2], votes: ar[3] })
    end
    array_database.empty? ? empty_array = [] : array
  end

  def save
    DB.execute(
      <<-SQL
      INSERT INTO posts (title, url, votes) VALUES ("#{@title}", "#{@url}","#{@votes}")
      SQL
    )
    @id = DB.last_insert_row_id
  end

  def update
    DB.execute(
      <<-SQL
      UPDATE posts
      SET title = "#{@title}" , url = "#{url}", votes = "#{votes}"
      WHERE id = "#{id}"
      SQL
    )
  end

  def destroy(id)
    # Destroys the current instance from the database
    DB.execute("DELETE FROM posts WHERE id = #{id}")
  end
end

# Correct save code
# def save
#   if @id.nil?
#     DB.execute("INSERT INTO posts (url, votes, title) VALUES (?, ?, ?)", @url, @votes, @title)
#     @id = DB.last_insert_row_id
#   else
#     DB.execute("UPDATE posts SET url = ?, votes = ?, title = ? WHERE id = ?", @url, @votes, @title, @id)
#   end
# end
