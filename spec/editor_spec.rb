require 'spec_helper'
require 'editor'

describe Editor do

  let(:editor) { Editor.new }

  context '#new' do
    it 'should be initialized with a welcome message and prompt' do
      output = capture_output { editor }
      output.should include('Welcome to the graphical editor')
      output.should include('Please enter a command')
    end

    it 'should be initialized with a list of the commands' do
      output = capture_output { editor }
      Editor::COMMANDS.each_pair do |cmd, description|
        output.should include("#{cmd}: #{description}" )
      end
    end
  end

  context 'exiting' do
    it 'should exit if X is entered' do
      capture_output do
        lambda { editor.do_command('X') }.should raise_error(SystemExit)
      end
    end
  end

end # of describe
