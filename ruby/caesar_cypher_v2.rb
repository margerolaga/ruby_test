def caesar_cipher (string,shift)
# The shift variable should allow positive and negative numbers
# The string variable allows spaces.

letters_hash = {
  1 => 'a',
  2 => 'b',
  3 => 'c',
  4 => 'd',
  5 => 'e',
  6 => 'f',
  7 => 'g',
  8 => 'h',
  9 => 'i',
  10 => 'j',
  11 => 'k',
  12 => 'l',
  13 => 'm',
  14 => 'n',
  15 => 'o',
  16 => 'p',
  17 => 'q',
  18 => 'r',
  19 => 's',
  20 => 't',
  21 => 'u',
  22 => 'v',
  23 => 'w',
  24 => 'x',
  25 => 'y',
  26 => 'z'
}

#Here we split the entered string into an array and place it into the cypher_array
cypher_array = string.split("")

#Here we create a 1:1 array to use as a capitalization flag for our letters. We will use this to see if
#we need to capitalize the letter in the cypher if it was capitalized in the original string.
#This saves us the hassle of creating another hash for capital letters.
string_is_capital = Array.new(cypher_array.length,0)

#Here we go through each element of the cypher_array using the each_with_index method
cypher_array.each_with_index do |letter, index|

  #Here we check if the letter matches with a value in the letters_hash.
  #If there is no match, i.e. nil, then we just retain that letter. This handles the case of symbols (!, #, etc.)
  if letters_hash.key(letter.downcase) == nil
    cypher_array[index] = letter

  #Else, if the letter matches with a key in the hash, then it is converted to that key and replaces the letter value
  #in the cypher_array.
  else
    cypher_array[index] = letters_hash.key(letter.downcase)
  end

  #Here, we populate the string_is_capital array, checking if the letter in the string is upper case
  #If it is, then we assign 1 in the array element. If not, then we assign 0.
  if letter == letter.upcase
    string_is_capital[index] = 1
  else
    string_is_capital[index] = 0
  end

end

#Here, the cypher_array would now consist of numbers and symbols only. All letters should be converted to their
#corresponding numerical value according to the hash.
cypher_array.each_with_index do |orig_number, index|

  #To avoid shifting non-integer values of the array, we check if the value in that index is an integer
  #If it not an integer, i.e. it is a retained symbol, nothing happens.
  #If it is an integer, proceed with the code.
  if orig_number.is_a?(Integer)

    #Here we apply the shift value to the numerical value of the letters.
    shifted_number = orig_number.to_i + shift

    #If the shifted number does go over 26, which is letter 'z', then we subtract 26 to it to wrap it back to 'a'
    while shifted_number > 26
      shifted_number -= 26
    end

    #If the shifted number does become negative, cases where the shift number is a negative number,
    #then we add 26 to it to wrap it back to the letter 'z'
    while shifted_number < 0
      shifted_number += 26
    end

    #Here we use the string_is_capital array to check if we need to capitalize this specific element in the array
    #If the string_is_capital value is 1, we use the upcase method. And if it is 0, then we use the downcase method to be sure.
    if string_is_capital[index] == 1
      cypher_array[index] = letters_hash[shifted_number].upcase
    elsif string_is_capital[index] == 0
      cypher_array[index] = letters_hash[shifted_number].downcase
    end

  end

end

#Here we print out the original string and the constructed cypher for comparison.
puts string
puts cypher_array.join

end

caesar_cipher('What, a string!',5)
