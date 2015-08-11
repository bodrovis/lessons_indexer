module Kernel
  def with_messages(prior = '', after = '', delimiter = true, output = $stdout)
    return unless block_given?
    prior = String(prior).to_s
    after = String(after).to_s

    output.puts prior.magenta unless prior == ''
    yield
    output.puts after.green unless after == ''
    output.puts "=".yellow * 50 if delimiter
  end

  def warning(*msg)
    warn "[WARNING] #{msg.join(' ')}".cyan
  end

  def exit_msg(*msg)
    abort "[ERROR] #{msg.join(' ')}".red
  end

  def within(path, ret = false)
    return unless block_given?
    initial = Dir.getwd
    Dir.chdir(path)
    val = yield
    Dir.chdir(initial) if ret
    return val
  rescue Errno::ENOENT
    exit_msg "The provided directory #{path} was not found! Aborting..."
  end
end