require 'emojimmy/version'

module Emojimmy
  # Load emoji data from config/emoji.txt and build the `text_to_emoji`
  # and `emoji_to_text` hash tables
  def self.initialize!
    emoji = File.read(File.expand_path('../../data/emoji.txt', __FILE__)).each_line.to_a

    @text_to_emoji = emoji.inject({}) do |memo, item|
      item = item.chomp.split("\t")
      memo.merge "{#{item[0]}}" => eval('"' + item[1] + '"')
    end

    @emoji_to_text = emoji.inject({}) do |memo, item|
      item = item.chomp.split("\t")
      memo.merge eval('"' + item[1] + '"') => "{#{item[0]}}"
    end
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
end
