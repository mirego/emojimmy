require 'spec_helper'

describe Emojimmy do
  describe :text_to_emoji do
    let(:stored_comment) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }
    let(:returned_comment) { 'Hello 😁😁 you 😈 🐸!' }

    specify do
      expect(Emojimmy.text_to_emoji(stored_comment)).to eql returned_comment
    end
  end

  describe :emoji_to_text do
    let(:received_comment) { 'Hello 😁😁 you 😈 🐸!' }
    let(:stored_comment) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }

    specify do
      expect(Emojimmy.emoji_to_text(received_comment)).to eql stored_comment
    end
  end
end
