require 'spec_helper'
require 'editor'

describe Editor do

  let(:editor) { Editor.new }
  let(:editor_3_4) { editor.do_command('I 3 4'); editor }

  context 'initialization' do
    it 'should include a welcome message and prompt' do
      output = capture_output { editor }
      output.should include('Welcome to the graphical editor')
      output.should include('Please enter a command')
    end

    it 'should include a list of the commands' do
      output = capture_output { editor }
      Editor::COMMAND_TEXT.each_pair do |cmd, text|
        output.should include("#{cmd}: #{text}" )
      end
    end
  end # of context

  context 'parsing space-separated input' do
    it 'should yield the command and an array of paramaters' do
      capture_output do
        editor.parse('cmd p1 p2 p3').should eq(['cmd', ['p1', 'p2', 'p3']])
      end
    end

    it 'should convert parameters represented by digits only to integers' do
      capture_output do
        editor.parse('cmd p1 2 45').should eq(['cmd', ['p1', 2, 45]])
      end
    end

    it 'should give a prompt on null or any whitespace entry' do
      whitespace, msg = ['',' ',"\t"," \t\r"], 'Please enter a valid command'
      capture_output do
        whitespace.each { |ws| editor.do_command(ws).should eq(msg) }
      end
    end
  end # of context

  context 'validating input' do
    it 'should give a prompt with commands list if an invalid command used' do
      bad_cmds = ['Z', '`', '!', '?', '[', 'exit']
      capture_output do
        bad_cmds.each do |cmd|
          editor.do_command(cmd).should eq("'#{cmd}' is not valid, try 'help'")
        end
      end
    end

    it 'should give a prompt with commands list if lower-case command used' do
      capture_output do
        editor.do_command('s').should eq("'s' is not valid, try 'help'")
      end
    end

    it 'should display a message if invalid coords are provided' do
      capture_output do
        e = editor
        e.do_command('I 2 3')
        e.do_command('L 3 5 G').should eq('Invalid coordinates')
      end
    end

    it 'should display a message if invalid colour is provided' do
      wrong_colours = ['x', '1', '>', '$']
      capture_output do
        e = editor
        e.do_command('I 2 3')
        wrong_colours.each do |colour|
          e.do_command("L 3 5 #{colour}").should eq('Invalid colour')
        end
      end
    end
  end # of context

  context 'command X' do
    it 'should exit the app' do
      capture_output do
        lambda { editor.do_command('X') }.should raise_error(SystemExit)
      end
    end

    it 'should display an error message if parameters provided' do
      capture_output do
        editor.do_command('X 2 3').should eq("'X' does not take parameters.")
      end
    end
  end # of context

  context 'command I' do
    it "should create a 2 by 3 grid of O's with args 2 3" do
      capture_output do
        editor.do_command('I 2 3').to_s.should eq("OO\nOO\nOO")
      end
    end

    it "should display an error message if wrong number of parameters given" do
      capture_output do
        editor.do_command('I 2 4 R').should eq("I takes 2 parameters, try 'help'")
      end
    end

    it "should display an error message with zero or negative coords" do
      capture_output do
        editor.do_command('I 0 3').should eq('Invalid coordinates')
        editor.do_command('I 250 -2').should eq('Invalid coordinates')
      end
    end

    it "should display an error message with args over image size limits" do
      capture_output do
        editor.do_command('I 251 3').should eq('Maximum size is 250 x 250')
      end
    end
  end # of context

  context 'command S' do
    it "should print a 2 by 3 grid of O's with args 2 3" do
      output = capture_output do
        e = editor
        e.do_command('I 2 3')
        e.do_command('S')
      end
      output[-9..-2].should eq("OO\nOO\nOO")
    end

    it 'should display an error message if parameters are provided' do
      capture_output do
        editor.do_command('S 2 3').should eq("'S' does not take parameters.")
      end
    end
  end # of context

  context 'command L' do
    it "should colour a single pixel with args '2 3 A'" do
      output = capture_output do
        e = editor_3_4
        e.do_command("L 2 3 A")
        e.do_command('S')
      end
      output[-16..-2].should eq("OOO\nOOO\nOAO\nOOO")
    end

    it "should display an error message if no image has been created" do
      capture_output do
        editor.do_command('L 2 3 A').should eq("Create an image first with 'I'")
      end
    end

    it "should display an error message if wrong number of parameters given" do
      capture_output do
        editor_3_4.do_command('L 2').should eq("L takes 3 parameters, try 'help'")
      end
    end

    it "should display an error message if coords out of range" do
      capture_output do
        editor_3_4.do_command('L 7 3 A').should eq('Invalid coordinates')
      end
    end
  end # of context

  context 'command C' do
    it "should clear set the image to all 'O's" do
      output = capture_output do
        e = editor_3_4
        e.do_command('L 2 3 A')
        e.do_command('C')
        e.do_command('S')
      end
      output[-16..-2].should eq("OOO\nOOO\nOOO\nOOO")
    end

    it "should not cause an error if there is no image" do
      capture_output do
        lambda { editor.do_command('C') }.should_not raise_error
      end
    end

    it 'should display an error message if parameters are provided' do
      capture_output do
        editor.do_command('C 2 3').should eq("'C' does not take parameters.")
      end
    end
  end # of context

  context 'command V' do
    it "should draw a vertical segment in an image" do
      output = capture_output do
        e = editor_3_4
        e.do_command('V 2 3 4 H')
        e.do_command('S')
      end
      output[-16..-2].should eq("OOO\nOOO\nOHO\nOHO")
    end
  end # of context

  context 'command H' do
    it "should draw a horizontal segment in an image" do
      output = capture_output do
        e = editor_3_4
        e.do_command("H 1 2 4 N")
        e.do_command('S')
      end
      output[-16..-2].should eq("OOO\nOOO\nOOO\nNNO")
    end
  end # of context

end # of describe
