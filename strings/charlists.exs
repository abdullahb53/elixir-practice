charlist = 'hełło'
IO.inspect(charlist) # [104, 101, 322, 322, 111]

charlist = "hełło" <> <<0>>
<<104, 101, 197, 130, 197, 130, 111, 0>>
IO.inspect(charlist) # <<104, 101, 197, 130, 197, 130, 111, 0>>


res = ?Z # You can get a character’s code point by using ?
IO.puts(res) # 90


# Graphemes and Codepoints
string = "\u0061\u0301"
# "á"

String.codepoints string
# ["a", "́"]

String.graphemes string
# ["á"]
