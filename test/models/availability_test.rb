# frozen_string_literal: true

require 'test_helper'

describe Availability do
  let(:user) { create(:user) }
  let(:availability) { create(:availability, user_id: user.id, start_time: '22:00') }

  def test_start_hours
    actual = availability.start_hours
    assert_equal '22', actual
  end

  def test_start_minutes
    actual = availability.start_minutes
    assert_equal '00', actual
  end

  def test_end_hours
    actual = availability.end_hours
    assert_equal '22', actual
  end

  def test_end_minutes
    actual = availability.end_minutes
    assert_equal '30', actual
  end

  def test_assign_end_time
    actual = availability.assign_end_time
    assert_equal(true, actual)
  end
end
