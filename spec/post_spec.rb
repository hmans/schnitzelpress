require 'spec_helper'

describe SchnitzelPress::Post do
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

      context "when a title is available" do
        before { subject.title = "Team Schnitzel is AWESOME!" }

        it "should set its slug to a sluggified version of its title" do
          expect { subject.save }.to change(subject, :slug).
            from(nil).
            to('team-schnitzel-is-awesome')
        end
      end

      context "when no title is available" do
        before do
          subject.title = nil
          subject.body = "Team Schnitzel is AWESOME! Lorem ipsum and so on."
        end

        it "should set its slug to a sluggified version of the truncated body" do
          expect { subject.save }.to change(subject, :slug).
            from(nil).
            to('team-schnitzel-is-awesome-lorem')
        end
      end
    end

    context "when another post on the same day is already using the same slug" do
      before do
        @other_post = Factory(:published_post, slugs: ["amazing-slug"])
        subject.published_at = @other_post.published_at
        subject.slug = "amazing-slug"
      end

      it { should_not be_valid }
    end

    context "when another page is using the same slug" do
      subject { Factory.build(:draft_page) }

      before do
        @other_page = Factory(:published_page, slugs: ["amazing-slug"])
        subject.slug = "amazing-slug"
      end

      it { should_not be_valid }
    end

    it "should store blank attributes as nil" do
      subject.link = ""
      expect { subject.save }.to change(subject, :link).from("").to(nil)
    end

    it "should remove leading and trailing spaces from string attributes" do
      subject.link = " moo "
      subject.link.should == " moo "
      subject.save
      subject.link.should == "moo"
    end
  end

  describe '.latest' do
    it 'should return the latest published posts' do
      2.times { Factory :draft_post }
      5.times { Factory :published_post }
      SchnitzelPress::Post.latest.size.should == 5
    end
  end

  context 'date methods' do
    before { subject.published_at = "2012-01-02 12:23:13" }
    its(:year)  { should == 2012 }
    its(:month) { should == 01 }
    its(:day)   { should == 02 }
  end
end
