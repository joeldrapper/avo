require "rails_helper"

RSpec.feature "ExposedMethodsBaseController", type: :feature do
  describe "message" do
    let(:new_course_url) { "/admin/resources/courses/new" }

    it "create_fail_message" do
      visit new_course_url

      save

      expect(page).to have_text "Course not created!"
    end

    it "create_success_message" do
      visit new_course_url

      fill_in "course_name", with: "Great Course"
      save

      expect(current_path).to eq "/admin/resources/courses/#{Course.last.prefix_id}"
      expect(page).to have_text "Course created!"
    end

    let(:course) { create :course }
    let(:edit_course_url) { "/admin/resources/courses/#{course.prefix_id}/edit" }

    it "update_fail_message" do
      visit edit_course_url

      fill_in "course_name", with: ""
      save

      expect(page).to have_text "Course not updated!"
      expect(page).to have_text "Name can't be blank"
    end

    let(:course_url) { "/admin/resources/courses/#{course.prefix_id}" }

    it "update_success_message" do
      visit edit_course_url

      fill_in "course_name", with: "Guitar Course"
      save

      expect(current_path).to eq course_url
      expect(page).to have_text "Course updated!"
    end
  end
end
