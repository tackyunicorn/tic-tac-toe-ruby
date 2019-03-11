class TicTacToe
  attr_accessor :size

  def init(params = {})
      # set the default size to be 3 x 3
      @@size = params.fetch(:size , 3)

      # used to initialize the spots for the win configurations
      @@spot = 0

      # build a matrix of the specified size, initialize it with
      # values of the spots, (1..size**2)
      @@x = Matrix.build(@@size) {|row , col| @@spot += 1}

      # The board is a Hash of spots (keys) and their corresponding values
      # (empty for now)
      @@board = {}
      (1..@@size**2).each {|i| @@board[i] = i.to_s}

      # wins is a list containing all possible configurations of the
      # board in the winning state
      @@wins = Array.new()
      @@temp = Array.new()
      @@x.row_vectors.each do |sub|
          @@temp.push(sub.to_a)
      end
      @@temp.reverse.each { |x| @@wins.push(x) }
      @@x.column_vectors.each do |sub|
          @@wins.push(sub.to_a)
      end
      @@wins.push(@@x.extract_diagonal)
      @@wins.push(@@x.rotate.extract_diagonal)
  end

  # show is a function that displays the current state of the board
  def show()
      (0...@@size).each do |i|
          if i == 0 then
            (0..@@size).each do
              print ('-----')
            end
            puts ()
          end
          (0...@@size).each do |j|
            if j == 0 then
              if @@board[@@wins[i][j]].to_s.length == 2 then
                  print ('| ' + @@board[@@wins[i][j]] + ' |')
              else
                  print ('|  ' + @@board[@@wins[i][j]] + ' |')
              end
            else
              if @@board[@@wins[i][j]].to_s.length == 2 then
                  print ('  ' + @@board[@@wins[i][j]] + ' |')
              else
                  print ('   ' + @@board[@@wins[i][j]] + ' |')
              end
            end
          end
          puts ()
          (0..@@size).each do
            print ('-----')
          end
          puts()
      end
  end

  # checkline is used as a helper function for check_all that returns
  # the true if all the spots in a line have the same move
  def checkline(mark , move , config)
      (0...@@wins[config].length).each do |i|
          if @@board[@@wins[config][i]] != mark then
              return false
          end
      end
      return true
  end

  # check_all checks the board for the win configurations of the particular
  # move and retuns true if chekline returns true
  def check_all(mark , move)
      (0...@@wins.length).each do |i|
          if @@wins[i].include?(move) then
              if checkline(mark , move , i) then
                  return true
              end
          end
      end
      return false
  end
end