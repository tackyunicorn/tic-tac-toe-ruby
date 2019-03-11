require 'Matrix'

class Matrix
    def extract_diagonal
        each(:diagonal).to_a
    end
    def rotate
        Matrix[*to_a.map(&:reverse).transpose]
    end
end

class Test

  @@spot = 0
  @@size = 3

  @@x = Matrix.build(@@size) {|row , col| @@spot += 1}

  @@board = {}
  (1..@@size**2).each {|i| @@board[i] = ' '}

  @@temp = []

  @@wins = Array.new()
  @@x.row_vectors.each do |sub|
    @@temp.push(sub.to_a)
  end
  @@temp.reverse.each { |x| @@wins.push(x) }
  @@x.column_vectors.each do |sub|
    @@wins.push(sub.to_a)
  end
  @@wins.push(@@x.extract_diagonal)
  @@wins.push(@@x.rotate.extract_diagonal)

  def test
    (1..@@size**2).each {|i| @@board[i] = ' '}
    # print @@board
    print @@wins
  end

  def show
    (0...@@size).each do |i|
      if i == 0 then
        (0..@@size).each do
          print ('----')
        end
        puts ()
      end
      (0...@@size).each do |j|
        if j == 0 then
          print ('| ' + @@board[@@wins[i][j]] + ' |')
        else
          print ('  ' + @@board[@@wins[i][j]] + ' |')
        end
      end
      puts ()
      (0..@@size).each do
        print ('----')
      end
      puts()
    end
  end
end

a = Test.new
puts a.show
