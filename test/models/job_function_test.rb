# frozen_string_literal: true

require 'test_helper'

class JobFunctionTest < ActiveSupport::TestCase
  def setup
    # @job_function = JobFunction.first
    @job_function = create(:job_function)
    Skill.create(job_function_id: @job_function.id, name: 'Advertising')
    Skill.create(job_function_id: @job_function.id, name: 'Agile Marketing')
  end

  def test_skills_name
    # expect = ['Advertising', 'Agile Marketing', 'B2B Marketing', 'B2C Marketing', 'Brand Reputation', 'Brand Strategy/Marketing', 'Content Marketing', 'Content Strategy and Creation', 'CRM', 'Cross Sell/Upsell', 'Customer Loyalty and Retention Marketing', 'Customer Onboarding', 'Database Marketing', 'Digital Marketing', 'Direct Marketing (mail, email)', 'eCommerce', 'Event Marketing', 'Go To Market Strategy', 'Inbound Marketing', 'Integrated Marketing', 'Lead Generation', 'Marketing Tools and Automation', 'Market Research and Analytics', 'Media Planning and Buying', 'Mobile Marketing', 'Mobile Marketing Systems (Hardware, Applications)', 'Multi Channel Marketing', 'Partnership Marketing', 'Pricing Strategy', 'Product Marketing', 'Promotions', 'Public Relations', 'Retail Marketing', 'SEM', 'SEO', 'Social Media Marketing', 'Startups', 'Systems Integration Services, Technology', 'Traditional Marketing', 'UX/UI Design']
    expect = ['Advertising', 'Agile Marketing']
    assert_equal expect, @job_function.skills_name
  end
end
