FactoryGirl.define do
  factory :post, :class => Schnitzelpress::Post do
    title { Faker::Lorem.sentence }
    body  { Faker::Lorem.paragraphs }
    published_at { Time.now }
  end

  factory :published_post, :parent => :post do
    status :published
  end

  factory :draft_post, :parent => :post do
    status :draft
  end

  factory :page, :parent => :post do
    published_at nil
  end

  factory :published_page, :parent => :page do
    status :published
    published_at nil
  end

  factory :draft_page, :parent => :page do
    status :draft
  end
end
