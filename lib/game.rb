class Game < TicTacToe
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