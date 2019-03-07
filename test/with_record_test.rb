require 'test_helper'

class WithRecord::Test < ActiveSupport::TestCase
  test "truth" do
    assert_kind_of Module, WithRecord
  end

  test "works" do
    u1 = User.create(name: 'John')
    u2 = User.create(name: 'Bob')

    p1 = u1.projects.create(name: 'apple')
    p2 = u2.projects.create(name: 'google')
    p3 = u2.projects.create(name: 'amazon')

    assert_equal u1.projects.with_record(p2), [p1, p2]
    assert_equal u1.projects.with_records(p2, p3), [p1, p2, p3]
    assert_equal u1.projects.with_records([p2, p3]), [p1, p2, p3]

    assert_equal Project.where(id: p1.id).with_record(p2), [p1, p2]
    assert_equal Project.where(id: p1.id).with_records(p2, p3), [p1, p2, p3]
    assert_equal Project.where(id: p1.id).with_records([p2, p3]), [p1, p2, p3]
  end
end
