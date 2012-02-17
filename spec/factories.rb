FactoryGirl.define do
  factory :post, class: Schreihals::Post do
    title "It's a Post!"
    body "Hello world.\n\nI'm a really interesting post!"
    published_at "2012-01-02 12:23:13"
  end
end
