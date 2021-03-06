module SpecUtils
  def capture_stderr(&block)
    original_stderr = $stderr
    $stderr = fake = StringIO.new
    begin
      yield
    ensure
      $stderr = original_stderr
    end
    fake.string
  end

  def capture_stdout(&block)
    original_stdout = $stdout
    $stdout = fake = StringIO.new
    begin
      yield
    ensure
      $stdout = original_stdout
    end
    fake.string
  end

  def capture_stdin(&block)
    original_stdin = $stdin
    $stdin = fake = StringIO.new
    begin
      yield
    ensure
      $stdin = original_stdin
    end
    fake.string
  end
end