# encoding: utf-8
require 'spec_helper'

describe Emojimmy do
  describe :token_to_emoji do
    let(:stored_text) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }
    let(:returned_text) { 'Hello 😁😁 you 😈 🐸!' }

    specify do
      expect(Emojimmy.token_to_emoji(stored_text)).to eql returned_text
    end
  end

  describe :emoji_to_token do
    let(:received_text) { 'Hello 😁😁 you 😈 🐸!' }
    let(:stored_text) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }

    specify do
      expect(Emojimmy.emoji_to_token(received_text)).to eql stored_text
    end
  end
end
