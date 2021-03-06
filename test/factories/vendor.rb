require_relative '../../app/models/vendor/vendor'

FactoryGirl.define do
  factory :vendor do
    # mandatory properties
    name 'UnibaPaaS'
    url 'http://example.com'
    revision DateTime.now
    status 'production'
    extensible false

    hosting { FactoryGirl.build(:hosting) }
    scaling { FactoryGirl.build(:scaling) }

    # runtimes
    ignore do
      language 'ruby'
    end

    after(:build) do |vendor, evaluator|
      vendor.runtimes = build_list(:runtime, 1, language: evaluator.language)
    end

    factory :vendor_with_distinct_runtimes do
      ignore do
        runtime_count 2
      end

      after(:build) do |vendor, evaluator|
        vendor.runtimes = build_list(:runtime, evaluator.runtime_count)
      end
    end

    factory :vendor_with_middleware do
      # middleware
      ignore do
        middleware_count 5
      end

      after(:build) do |vendor, evaluator|
        vendor.middlewares = build_list(:middleware, evaluator.middleware_count)
      end
    end

    factory :vendor_with_frameworks do
      # frameworks
      ignore do
        frameworks_count 5
      end

      after(:build) do |vendor, evaluator|
        vendor.frameworks = build_list(:framework, evaluator.frameworks_count)
      end
    end

    factory :vendor_with_infrastructures do
      # infrastructures
      ignore do
        infrastructures_count 5
      end

      after(:build) do |vendor, evaluator|
        vendor.infrastructures = build_list(:infrastructure, evaluator.infrastructures_count)
      end
    end
  end
end