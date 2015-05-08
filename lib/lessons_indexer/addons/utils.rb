module Kernel
  def with_messages(prior = '', after = '', delimiter = true, output = $stdout)
    return unless block_given?
    prior, after = String(prior).to_s, String(after).to_s

    output.puts prior unless prior == ''
    yield
    output.puts after unless after == ''
    output.puts "=" * 50 if delimiter
  end

  def warning(*msg)
    warn "[WARNING] #{msg.join(' ')}"
  end

  def exit_msg(*msg)
    abort "[ERROR] #{msg.join(' ')}"
  end

  def within(path, ret = false)
    return unless block_given?
    Dir.chdir(path)
    val = yield
    Dir.chdir('..') if ret
    return val
  rescue Errno::ENOENT
    exit_msg "The provided directory #{path} was not found! Aborting..."
  end
end