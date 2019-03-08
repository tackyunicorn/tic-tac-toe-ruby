class TicTacToe

	# The board is a Hash of spots (keys) and their corresponding values
	# (empty for now)
	@@board = { 7 => ' ' , 8 => ' ' , 9 => ' ' ,
				4 => ' ' , 5 => ' ' , 6 => ' ' ,
				1 => ' ' , 2 => ' ' , 3 => ' '  }

	# wins is a list containing all possible configurations of the
	# board in the winning state
	@@wins = [  [7 , 4 , 1] , [8 , 5 , 2] , [9 , 6 , 3] ,
				[7 , 8 , 9] , [4 , 5 , 6] , [1 , 2 , 3] ,
				[7 , 5 , 3] , [1 , 5 , 9]  ]

	# show is a function that displays the current state of the board
	def show()
		puts (' 	|	' + ' 	|	')
		puts (@@board[7] + '	|	' + @@board[8] + '	|	' + @@board[9])
		puts ('------------------------------------')
		puts (@@board[4] + '	|	' + @@board[5] + '	|	' + @@board[6])
		puts (' 	|	' + ' 	|	')
		puts ('------------------------------------')
		puts (@@board[1] + '	|	' + @@board[2] + '	|	' + @@board[3])
		puts (' 	|	' + ' 	|	')
	end

	# checkline is used as a helper function for check_all that returns
	# the move if all the spots in a line have the same move
	def checkline(move , spot1 , spot2 , spot3)
		if @@board[spot1] == move && @@board[spot2] == move && @@board[spot3] == move then
			return move
		end
	end

	# check_all checks the board for all possible win configurations on a 
	# particular move and returns true if a configuration is found
	def check_all(move)
		(0...@@wins.length).each do |i|
			if checkline(move , @@wins[i][0] , @@wins[i][1] , @@wins[i][2]) == move then
				return true
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
		puts ("Select a position [numpad layout]: ")
		@point = gets.chomp.to_i
		if (1..9).include?(@point) then
			if (@@board[@point] != 'X' && @@board[@point] != 'O') then
				if player == 1 then
					@mark = 'X'
				else
					@mark = 'O'
				end

				@@board[@point] = @mark
				@taken += 1
				if (check_all(@mark)) then
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
	# player 1 winning and 2 on player 2 winning
	def game()
		@taken = 0

		while true do

			if (@taken > 7) then
				system "cls"
				puts ("<=============PLAYER #{@player}=============>")
				puts ()
				show
				puts ()
				return 0
			end

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

# create a class object for TicTacToe and call the game method
system "cls"
game = TicTacToe.new
result = game.game

if result == 0 then
	puts ('The game ends in a tie')
elsif result == 1
	puts ("Player 1 wins!")
else
	puts ("Player 2 wins!")
end