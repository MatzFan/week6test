require 'stringio'

# well done for using it
def capture_output &block
  old_stdout = $stdout
  test_stdout = StringIO.new
  $stdout = test_stdout
  block.call
  test_stdout.string
ensure
  $stdout = old_stdout
end

HELLO = "\
IIIIIIIIIIIIIIIIIIIIIIIIIIII
IMIIMIMMMMIMIIIIMIIIIIMMIIMI
IMIIMIMIIIIMIIIIMIIIIMOOMIMI
IMIIMIMIIIIMIIIIMIIIIMOOMIMI
IMMMMIMMMMIMIIIIMIIIIMOOMIMI
IMIIMIMIIIIMIIIIMIIIIMOOMIMI
IMIIMIMIIIIMIIIIMIIIIMOOMIII
IMIIMIMMMMIMMMMIMMMMIIMMIIMI
IIIIIIIIIIIIIIIIIIIIIIIIIIII"

def hello_commands
  [('I 28 9'),
   ('V 2 2 8 M'),
   ('V 5 2 8 M'),
   ('V 7 2 7 M'),
   ('V 12 2 7 M'),
   ('V 17 2 7 M'),
   ('V 22 3 7 M'),
   ('V 25 3 7 M'),
   ('V 27 2 8 M'),
   ('H 3 10 5 M'),
   ('H 8 10 2 M'),
   ('H 7 20 8 M'),
   ('H 23 24 2 M'),
   ('H 23 24 8 M'),
   ('L 6 5 O'),
   ('L 11 8 O'),
   ('L 16 8 O'),
   ('L 27 7 O'),
   ('F 25 8 I'),
   ('S')]
end

