module SpecSamples
  def sample_lessons(additional = false)
    arr = (additional ? lessons_array_additional : lessons_array)
    LessonsIndexer::Collections::LessonsList.new(arr.map do |name|
      LessonsIndexer::Models::Lesson.new(name)
    end)
  end

  def sample_headings
    LessonsIndexer::Collections::HeadingsList.new(headings_array.map do |name|
      LessonsIndexer::Models::Heading.new(name)
    end)
  end

  def lessons_array
    %w(lesson2.5.md lesson10.2.md lesson1.3.md lesson5.8.md)
  end

  def lessons_array_additional
    lessons_array.insert(2, 'lesson6.3.md')
  end

  def lessons_array_with_incorrect
    lessons_array.insert(2, 'test.txt')
  end

  def headings_array
    %w(lesson2.5.jpg lesson10.2.jpg lesson1.3.jpg lesson5.8.jpg)
  end

  def headings_array_with_incorrect
    headings_array.insert(2, 'test2.png')
  end

  def sample_options
    ['-o', 'test.md']
  end
end