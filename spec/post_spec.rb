require 'spec_helper'

describe Schreihals::Post do
  subject do
    Factory.build(:post)
  end

  describe 'saving' do
    context "when no slug is set" do
      before { subject.slug = nil }
      it "should set its slug to a sluggified version of its title" do
        expect { subject.save }.to change(subject, :slug).from(nil).to('it-s-a-post')
      end
    end

    context "when post is being pubslihed and no published_at is set" do
      before { subject.published_at = nil ; subject.status = :published }
      it "should set its published_at to the current time" do
        expect { subject.save }.to change(subject, :published_at).from(nil).to(Time.now)
      end
    end
  end

  context 'date methods' do
    before { subject.published_at = "2012-01-02 12:23:13" }
    its(:year)  { should == 2012 }
    its(:month) { should == 01 }
    its(:day)   { should == 02 }
  end
end
