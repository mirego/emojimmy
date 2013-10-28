# encoding: utf-8
require 'spec_helper'

describe Emojimmy do
  describe :token_to_emoji do
    let(:stored_text) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }
    let(:returned_text) { 'Hello 😁😁 you 😈 🐸!' }

    subject { Emojimmy.token_to_emoji(stored_text) }
    it { should eql returned_text }
  end

  describe :emoji_to_token do
    let(:received_text) { 'Hello 😁😁 you 😈 🐸!' }
    let(:stored_text) { 'Hello {U+1F601}{U+1F601} you {U+1F608} {U+1F438}!' }

    subject { Emojimmy.emoji_to_token(received_text) }
    it { should eql stored_text }
  end
end
