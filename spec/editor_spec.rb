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
  end # of context

  context 'parsing space-separated input' do
    it 'should yield the command and an array of paramaters' do
      capture_output do
        editor.parse('cmd p1 p2 p3').should eq(['cmd', ['p1', 'p2', 'p3']])
      end
    end

    it 'should give a prompt on null entry' do
      capture_output do
        editor.do_command('').should eq('Please enter a valid command')
      end
    end
  end # of context

  context 'validating commands' do
    it 'should give a prompt with commands list if an invalid command used' do
      capture_output do
        editor.do_command('Z').should eq("'Z' is not valid, hit '?' for command list")
      end
    end
  end # of context

  context 'command X' do
    it 'should exit the app' do
      capture_output do
        lambda { editor.do_command('X') }.should raise_error(SystemExit)
      end
    end
  end # of context

  context 'command I' do
    it "with args 250 250 should print a 2 by 2 grid of O's" do
      capture_output do
        editor.do_command('I 2 2').should eq("OO\nOO")
      end
    end
  end # of context

end # of describe
