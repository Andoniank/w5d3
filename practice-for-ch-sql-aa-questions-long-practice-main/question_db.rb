require 'singleton'
require 'sqlite3'

class QuestionDatabase < SQLite3::Database
    include Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

#--------------------------------------------------------

class User
    attr_accessor :id, :fname, :lname
    
    def self.all
        data = QuestionDatabase.instance.execute("SELECT * FROM users")
        data.map {|datum| User.new(datum)}
    end

    def self.find_by_id(id)
        user = QuestionDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM 
                users
            WHERE
                id = ?
        SQL
        return nil if user.length == 0
        User.new(user.first)
    end

    def self.find_by_name(fname, lname)
        user = QuestionDatabase.instance.execute(<<-SQL, fname, lname)
            SELECT
                *
            FROM 
                users
            WHERE
                fname = ? AND lname = ?
        SQL
        return nil if user.length == 0
        User.new(user.first)
    end

    def initialize(options)
        @id = options['id']
        @fname = options['fname']
        @lname = options['lname']
    end

    def authored_questions 
        author = Question.find_by_author_id(self.id)
        raise "#{self} not found in DB" unless author
    end

    def authored_replies
        author = Reply.find_by_user_id(self.id)
        raise "#{self} not found in DB" unless author
    end

    def create
        raise "#{self} already in database" if self.id
        QuestionDatabase.instance.execute(<<-SQL, self.fname, self.lname)
          INSERT INTO
            users (fname, lname)
          VALUES
            (?, ?)
        SQL
        self.id = QuestionDatabase.instance.last_insert_row_id
    end

    def update
        raise "#{self} not in database" unless self.id
        QuestionDatabase.instance.execute(<<-SQL, self.fname, self.lname, self.id)
          UPDATE
            users
          SET
            fname = ?, lname = ?
          WHERE
            id = ?
        SQL
    end
end

#--------------------------------------------------------

class Question
    
    def self.all
        data = QuestionDatabase.instance.execute("SELECT * FROM questions")
        data.map {|datum| Question.new(datum)}
    end
    
    def self.find_by_id(id)
        q_id = QuestionDatabase.instance.execute(<<-SQL, id)
            SELECT
                *
            FROM 
                questions
            WHERE
                id = ?
        SQL
        return nil if q_id.length == 0
        Question.new(q_id.first)
    end

    def find_by_author_id(author_id)
        question = QuestionDatabase.instance.execute(<<-SQL, author_id)
            SELECT
                *
            FROM 
                questions
            WHERE
                author_id = ?
        SQL
        return nil if question.length == 0
        Question.new(question.first)
    end

    def author
    end

    def replies
    end


end

#--------------------------------------------------------

class QuestionFollow
    def self.find_by_id
    end
end

#--------------------------------------------------------

class Reply
    def self.find_by_id
    end

    def find_by_user_id(user_id)
        reply = QuestionDatabase.instance.execute(<<-SQL, user_id)
            SELECT
                *
            FROM 
                replies
            WHERE
                user_id = ?
        SQL
        return nil if reply.length == 0
        Reply.new(reply.first)
    end

    def find_by_question_id(question_id)
    end

    def author
    end

    def question
    end

    def parent_reply
    end

    def child_replies
    end
end

#--------------------------------------------------------

class QuestionLike
    def self.find_by_id
    end
end