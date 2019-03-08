class TicTacToe
	@@board = { 7 => ' ' , 8 => ' ' , 9 => ' ' ,
				4 => ' ' , 5 => ' ' , 6 => ' ' ,
				1 => ' ' , 2 => ' ' , 3 => ' '  }

	@@wins = [  [7 , 4 , 1] , [8 , 5 , 2] , [9 , 6 , 3] ,
				[7 , 8 , 9] , [4 , 5 , 6] , [1 , 2 , 3] ,
				[7 , 5 , 3] , [1 , 5 , 9]  ]

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

	def checkline(move , spot1 , spot2 , spot3)
		if @@board[spot1] == move && @@board[spot2] == move && @@board[spot3] == move then
			return move
		end
	end

	def checkall(move)
		(0...@@wins.length).each do |i|
			if checkline(move , @@wins[i][0] , @@wins[i][1] , @@wins[i][2]) == move then
				return true
			end
		end
		return false
	end

	def turn(player)
		system "cls"
		puts ("<=============PLAYER #{player}=============>")
		puts ()
		show
		puts ()
		puts ("Select a position: ")
		@point = gets.chomp.to_i
		if (@@board[@point] != 'X' && @@board[@point] != 'O') then
			if player == 1 then
				@mark = 'X'
			else
				@mark = 'O'
			end
				@@board[@point] = @mark
				@taken += 1
				if (checkall(@mark)) then
					return true
				else
					return false
				end
		else
			puts ("That spot is taken!")
			sleep(1)
			turn(@player)
		end
	end

	def game()
		@taken = 0
		
		while true do

			if (@taken > 7) then
				puts ('The game ends in a tie')
				break
			end
			
			@player = 1
			if turn(@player) then
				puts ("Player #{@player} wins!")
				break
			end
			@player = 2
			if turn(@player) then
				puts ("Player #{@player} wins!")
				break
			end

		end
	end
end

system "cls"
game = TicTacToe.new
result = game.game
puts (result)