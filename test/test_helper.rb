# frozen_string_literal: true

require 'minitest/autorun'
require 'minitest/focus'
require 'pp_sql'

require 'minitest/reporters'

LOGGER = StringIO.new

Minitest::Reporters.use!
