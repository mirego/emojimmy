# encoding: utf-8
require 'emojimmy/version'

# Dependencies
require 'rumoji'
require 'active_record'

# Modules
require 'emojimmy/mixin'
require 'emojimmy/extensions'

module Emojimmy
  # Loop through all emoji and replace them with
  # their matching token
  def self.emoji_to_token(content)
    return content unless content.present?

    # Encode the string with Rumoji
    content = Rumoji.encode(content)

    # Return the text without any other weird characters
    Emojimmy.strip(content)
  end

  # Loop through each {U+...} token in the string and
  # convert it to the matching emoji
  def self.token_to_emoji(content)
    return content unless content.present?

    Rumoji.decode(content)
  end

  # Loop through each character in the string and
  # remove the all emoji ones
  def self.strip(content)
    content.chars.select do |c|
      point = c.each_codepoint.to_a.first
      point <= 65535
    end.join
  end
end
