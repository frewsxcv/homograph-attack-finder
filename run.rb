require 'set'

# latin → cyrillic
cyrillic_lookalikes = {
    'a' => 'а',
    'c' => 'с',
    # 'd' => 'ԁ',
    'e' => 'е',
    'h' => 'һ',
    'i' => 'і',
    'j' => 'ј',
    # 'k' => 'ҟ',
    'l' => 'ӏ',
    # 'm' => 'м',
    'n' => 'п',
    'o' => 'о',
    'p' => 'р',
    'q' => 'ԛ',
    'r' => 'г',
    's' => 'ѕ',
    # 'u' => 'џ',
    'w' => 'ԝ',
    'x' => 'х',
    'y' => 'у',
}.freeze

cyrillic_lookalike_latin = Set[*cyrillic_lookalikes.keys].freeze

numbers = Set['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

file = File.open("top-1m.csv", "r")
contents = file.read
file.close

contents.each_line do |line|
    _, line = line.split(',')
    domain, tld = line.split('.', 2)
    if Set[*domain.chars].subset?(cyrillic_lookalike_latin + numbers)
        cyrillic_domain = domain
            .chars
            .map{|char| cyrillic_lookalikes.fetch(char, char) }
            .join
        next if cyrillic_domain == domain # can happen if domain is all numbers
        puts "http://#{cyrillic_domain}.#{tld}"
    end
end
