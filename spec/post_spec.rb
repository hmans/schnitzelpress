require 'spec_helper'

describe Schreihals::Post do
  subject do
    Factory.build(:post)
  end

  context 'slugs' do
    before do
      subject.slugs = ['some-slug', 'another-slug']
      subject.slug = 'a-new-slug'
    end

    its(:slugs) { should == ['some-slug', 'another-slug', 'a-new-slug'] }
    its(:slug) { should == 'a-new-slug'}
  end

  context 'saving' do
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

  describe '.latest' do
    it 'should return the latest published posts' do
      2.times { Factory :draft_post }
      5.times { Factory :published_post }
      Schreihals::Post.latest.size.should == 5
    end
  end

  context 'date methods' do
    before { subject.published_at = "2012-01-02 12:23:13" }
    its(:year)  { should == 2012 }
    its(:month) { should == 01 }
    its(:day)   { should == 02 }
  end
end
