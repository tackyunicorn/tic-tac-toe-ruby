require 'Matrix'

class Matrix
	def extract_diagonal
		each(:diagonal).to_a
	end
	def rotate
		Matrix[*to_a.map(&:reverse).transpose]
	end
end

@size = 3

@spot = 0

@x = Matrix.build(@size) {|row , col| @spot += 1}

@wins = Array.new()

@win_vectors =  @x.row_vectors.each { |sub| sub.each { |list| list } }

@wins.push(@x.extract_diagonal)
@wins.push(@x.rotate.extract_diagonal)
@wins.push(@x.row_vectors.each {|sub| sub.to_a})
@wins.push(@x.column_vectors.each {|sub| sub.to_a})

print (@wins)
puts ()
print (@win_vectors)