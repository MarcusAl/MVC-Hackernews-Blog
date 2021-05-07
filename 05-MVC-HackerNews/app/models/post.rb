require 'sqlite3'
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
    @db = SQLite3::Database.new("./db/posts.db")
  end

  def find(id)
    query = <<-SQL
    SELECT * FROM posts
    WHERE id = "#{id}"
    SQL
    exec = @db.execute(query).flatten
    if exec.empty?
      return nil
    else
      Post.new({ id: exec[0], title: exec[1], url: exec[2] })
    end
  end

  def all
    array = []
    array_database = @db.execute('SELECT * FROM posts')
    array_database.each do |ar|
      array << Post.new({ id: ar[0], title: ar[1], url: ar[2], votes: ar[3] })
    end
    array_database.empty? ? empty_array = [] : array
  end

  def save
    @db.execute(
      <<-SQL
      INSERT INTO posts (title, url, votes) VALUES ("#{@title}", "#{@url}","#{@votes}")
      SQL
    )
    @id = @db.last_insert_row_id
  end

  def update
    @db.execute(
      <<-SQL
      UPDATE posts
      SET title = "#{@title}" , url = "#{url}", votes = "#{votes}"
      WHERE id = "#{id}"
      SQL
    )
  end

  def destroy(id)
    # Destroys the current instance from the database
    @db.execute("DELETE FROM posts WHERE id = #{id}")
  end
end
