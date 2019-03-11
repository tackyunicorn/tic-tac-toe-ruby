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

  # turn gives the turn to a particular player, makes the player
  # select a spot and calls check_all to see if the player has won
  def turn(player)
      system "cls"
      puts ("<=============PLAYER #{player}=============>")
      puts ()
      show
      puts ()
      puts ("Select a position: ")
      @move = gets.chomp.to_i
      if (1..@@size**2).include?(@move) then
          if (@@board[@move] != 'X' && @@board[@move] != 'O') then
              if player == 1 then
                  @mark = 'X'
              else
                  @mark = 'O'
              end

              @@board[@move] = @mark
              @taken += 1
              if (check_all(@mark , @move)) then
                  return true
              else
                  return false
              end

          else
              puts ("That spot is taken!")
              sleep(1)
              turn(@player)
          end
      else
          puts ("Invalid input")
          sleep(1)
          turn(@player)
      end
  end

  # game starts the game and keeps a counter of spots taken
  # to check for a tie condition. returns 0 on a tie, 1 on
  # player 1 winning and 2 on player 2 winning. the minumum
  # size of the board is 3
  def game()

      system "cls"
      puts "Enter the size of the tic-tac-toe board: "
      size = gets.chomp.to_i
      if (size > 2) then
          init(:size => size)
      else
          puts("Invalid input")
          sleep(1)
          game()
      end
      
      @taken = 0

      while true do

          if (@taken >= (@@size**2)-2) then
              system "cls"
              puts ("<=============PLAYER #{@player}=============>")
              puts ()
              show
              puts ()
              return 0
          end

          # player 1 is assumed to take X and player 2 assumed to take Y
          # this setting can be changed in the turn() method
          @player = 1
          if turn(@player) then
              system "cls"
              puts ("<=============PLAYER #{@player}=============>")
              puts ()
              show
              puts ()
              return 1
          end

          @player = 2
          if turn(@player) then
              system "cls"
              puts ("<=============PLAYER #{@player}=============>")
              puts ()
              show
              puts ()
              return 2
          end

      end
  end
end