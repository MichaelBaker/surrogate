require 'spec_helper'

messages_for = Surrogate::RSpec::MessagesFor

describe messages_for, 'argument inspection' do

  describe 'individual argument inspection inspection' do
    it 'inspects non RSpec matchers as their default inspection' do
      messages_for.inspect_argument("1").should == '"1"'
      messages_for.inspect_argument(1).should == "1"
      messages_for.inspect_argument([/a/]).should == "[/a/]"
    end

    it 'inspects rspec matchers' do
      messages_for.inspect_argument(no_args).should == 'no args'
      messages_for.inspect_argument(hash_including abc: 123).should == 'hash_including(:abc=>123)'
    end
  end


  describe 'multiple argument inspection' do
    it "wraps individual arguments in `'" do
      messages_for.inspect_arguments([/a/]).should == "`/a/'"
    end

    it "joins arguments with commas" do
      messages_for.inspect_arguments(['x', no_args]).should == "`\"x\", no args'"
    end

    it 'returns no_args when the array is empty' do
      messages_for.inspect_arguments([]).should == "`no args'"
    end
  end
end
