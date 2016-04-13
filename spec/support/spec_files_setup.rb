require 'fileutils'

module SpecFilesSetup
  def setup_env!(empty = false)
    FileUtils.mkdir_p('my_course_handouts/headings')
    unless empty
      lessons_array_with_incorrect.each do |file|
        File.new("my_course_handouts/#{file}", 'w+').close
      end

      headings_array_with_incorrect.each do |file|
        File.new("my_course_handouts/headings/#{file}", 'w+').close
      end
    end
  end

  def clear_env!
    FileUtils.remove_entry('my_course_handouts', true)
    FileUtils.remove_entry('test.md', true)
  end
end