require 'singleton'

class QuestionDatabase < SQLite3::Database
    incude Singleton

    def initialize
        super('questions.db')
        self.type_translation = true
        self.results_as_hash = true
    end

end

#--------------------------------------------------------

class User
    attr_accessor :id, :fname, :lname

    def self.find_by_id
        data = QuestionDatabase.instance.execute("SELECT * FROM users")
        data.map {|datum| User.new(datum)}
    end

    def find_by_name(fname, lname)
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

    def 
end

#--------------------------------------------------------

class Question
    def self.find_by_id
        data = QuestionDatabase.instance.execute("SELECT * FROM questions")
        data.map {|datum| Question.new(datum)}
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
    end

    def find_by_question_id(question_id)
    end
end

#--------------------------------------------------------

class QuestionLike
    def self.find_by_id
    end
end