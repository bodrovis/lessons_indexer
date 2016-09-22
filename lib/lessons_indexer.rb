require 'facets/string/titlecase'
require 'slop'
require 'colorize'
require 'messages_dictionary'

module LessonsIndexer
  class Messenger
    include MessagesDictionary
    has_messages_dictionary file: 'messages.yml',
                            dir: File.join(File.dirname(__FILE__), 'lessons_indexer/messages'),
                            transform: ->(msg) {msg}
  end
end

require 'lessons_indexer/addons/file_manager'
require 'lessons_indexer/addons/git_manager'
require 'lessons_indexer/addons/utils'

require 'lessons_indexer/models/base'
require 'lessons_indexer/models/heading'
require 'lessons_indexer/models/lesson'

require 'lessons_indexer/collections/base'
require 'lessons_indexer/collections/headings_list'
require 'lessons_indexer/collections/lessons_list'

require 'lessons_indexer/version'
require 'lessons_indexer/options'
require 'lessons_indexer/course'
require 'lessons_indexer/indexer'
require 'lessons_indexer/starter'