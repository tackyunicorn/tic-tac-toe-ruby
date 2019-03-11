class Matrix
  def extract_diagonal
      each(:diagonal).to_a
  end
  def rotate
      Matrix[*to_a.map(&:reverse).transpose]
  end
end