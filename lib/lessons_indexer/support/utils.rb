module Kernel
  def within(path, ret = false)
    return unless block_given?
    Dir.chdir(path)
    val = yield
    Dir.chdir('..') if ret
    return val
  rescue Errno::ENOENT
    abort "The provided directory #{path} was not found! Aborting..."
  end
end