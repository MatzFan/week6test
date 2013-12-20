require 'spec_helper'
require 'editor'

describe Editor do

  let(:editor) { Editor.new }

  context '#new' do
    it 'should be initialized with a welcome message' do
      output = capture_output do
        editor
      end
      output.should include('Welcome to the graphical editor')
    end
  end

end # of describe
