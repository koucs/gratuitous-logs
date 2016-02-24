# -*- coding: utf-8 -*-
# Read about factories at http://github.com/thoughtbot/factory_girl

FactoryGirl.define do
  factory :valid_no_draft_post, class: Post do
    sequence(:title){|n| "Test Title #{n}" }
    sequence(:contents){|n| "Test Contents #{n}" }
    category_id false
    is_draft false
    is_valid true
  end

  factory :invalid_draft_post, class: Post do
    sequence(:title){|n| "Test Title #{n}" }
    sequence(:contents){|n| "Test Contents #{n}" }
    category_id false
    is_draft true
    is_valid false
  end

  factory :invalid_no_draft_post, class: Post do
    sequence(:title){|n| "Test Title #{n}" }
    sequence(:contents){|n| "Test Contents #{n}" }
    category_id false
    is_draft false
    is_valid false
  end

end
