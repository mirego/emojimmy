# encoding: utf-8
require 'emojimmy/version'

# Dependencies
require 'active_record'

# Modules
require 'emojimmy/mixin'
require 'emojimmy/extensions'

module Emojimmy
  DATA_FILE = File.expand_path('../../data/emoji.txt', __FILE__)
  TOKEN_REGEXP = /({U\+[^}]+})/

  # Load emoji data from config/emoji.txt and build the `token_to_emoji`
  # and `emoji_to_token` hash tables
  def self.initialize!
    content = File.read(DATA_FILE).each_line.to_a
    build_hash_tables(content)
  end

  # Loop through all emoji and replace them with
  # their matching token
  def self.emoji_to_token(content)
    return content unless content.present?

    content.dup.tap do |content|
      @emoji_to_token.each_pair do |emoji, token|
        content.gsub!(emoji, token)
      end
    end
  end

  # Loop through each {U+...} token in the string and
  # convert it to the matching emoji
  def self.token_to_emoji(content)
    return content unless content.present?

    content.gsub(TOKEN_REGEXP) { |data| @token_to_emoji[data] }
  end

private

  # Build or `emoji_to_token` and `token_to_emoji` hash tables
  def self.build_hash_tables(content)
    @emoji_to_token = {}
    @token_to_emoji = {}

    content.each do |line|
      token, emoji = line.chomp.split("\t")
      token = "{#{token}}"

      # We use `eval` here to convert
      # "\\xF0\\x9F\\x98\\x81" into "\xF0\x9F\x98\x81"
      emoji = eval('"' + emoji + '"')

      @emoji_to_token[emoji] = token
      @token_to_emoji[token] = emoji
    end
  end
end
