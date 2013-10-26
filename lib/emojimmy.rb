# encoding: utf-8
require 'emojimmy/version'

# Dependencies
require 'active_record'

# Modules
require 'emojimmy/mixin'

module Emojimmy
  DATA_FILE = File.expand_path('../../data/emoji.txt', __FILE__)

  # Load emoji data from config/emoji.txt and build the `text_to_emoji`
  # and `emoji_to_text` hash tables
  def self.initialize!
    content = File.read(DATA_FILE).each_line.to_a
    build_hash_tables(content)
  end

  # Loop through all emoji and replace them with
  # their matching text equivalent
  def self.emoji_to_text(content)
    @emoji_to_text.each_pair do |emoji, text|
      content = content.gsub(emoji, text)
    end

    content
  end

  # Loop through each {U+...} part in the string and
  # convert it to the matching emoji
  def self.text_to_emoji(content)
    content.gsub /({U\+[^}]+})/ do |data|
      @text_to_emoji[data]
    end
  end

private

  # Build or `emoji_to_text` and `text_to_emoji` hash tables
  def self.build_hash_tables(content)
    @emoji_to_text = {}
    @text_to_emoji = {}

    content.each do |line|
      line = line.chomp.split("\t")
      emoji = eval('"' + line[1] + '"')
      text = "{#{line[0]}}"

      @emoji_to_text[emoji] = text
      @text_to_emoji[text] = emoji
    end
  end
end

class ActiveRecord::Base
  def self.stores_emoji_characters(options = {})
    return unless table_exists?

    options[:in] ||= []
    Emojimmy::Mixin.inject_methods(self, options[:in])
  end
end
