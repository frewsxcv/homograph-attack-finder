require 'set'

cyrillic_lookalikes = Set[
    'a', # cyrillic: а
    'c', # cyrillic: с
    # 'd', # cyrillic: ԁ
    'e', # cyrillic: е
    'h', # cyrillic: һ
    'i', # cyrillic: і
    'j', # cyrillic: ј
    # 'k', # cyrillic: ҟ
    'l', # cyrillic: ӏ
    # 'm', # cyrillic: м
    'n', # cyrillic: п
    'o', # cyrillic: о
    'p', # cyrillic: р
    'q', # cryillic: ԛ
    'r', # cyrillic: г
    's', # cyrillic: ѕ
    # 'u', # cyrillic: џ
    'w', # cyrillic: ԝ
    'x', # cyrillic: х
    'y', # cyrillic: у
].freeze

numbers = Set['0', '1', '2', '3', '4', '5', '6', '7', '8', '9'].freeze

file = File.open("top-1m.csv", "r")
contents = file.read
file.close

contents.each_line do |line|
    _, line = line.split(',')
    domain, _ = line.split('.', 2)
    if Set[*domain.chars].subset?(cyrillic_lookalikes + numbers)
        puts domain
    end
end
