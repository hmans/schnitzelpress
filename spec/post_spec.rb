require 'spec_helper'

describe Schreihals::Post do
  subject do
    Factory.build(:post, published_at: "2012-01-02 12:23:13")
  end

  context "date methods" do
    its(:year) { should == 2012 }
    its(:month) { should == 01 }
    its(:day) { should == 02 }
  end
end
