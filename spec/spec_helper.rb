require 'stringio'

def capture_output &block
  old_stdout = $stdout
  test_stdout = StringIO.new
  $stdout = test_stdout
  block.call
  test_stdout.string
ensure
  $stdout = old_stdout
end
