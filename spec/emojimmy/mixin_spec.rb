# encoding: utf-8
require 'spec_helper'

describe Emojimmy::Mixin do
  describe :inject_methods do
    before do
      run_migration do
        create_table(:comments, force: true) do |t|
          t.text :body
        end
      end
    end

    context 'with invalid options for `in`' do
      before do
        spawn_emojimmy_model 'Comment', :foo
      end

      specify do
        expect {
          Comment.create(body: 'Hello.')
        }.to raise_error(ArgumentError, 'Comment must respond to foo= in order for Emojimmy to store emoji characters in it.')
      end
    end

    context 'with valid options for `in`' do
      let(:args) { [:body] }

      before do
        spawn_emojimmy_model 'Comment', *args
      end

      describe :InstanceMethod do
        subject { Comment.create(body: body) }

        context 'with a single emoji' do
          let(:body) { "Hello, 😁😁 world!" }
          it { should be_persisted }
          its(:body) { should eql body }
        end

        context 'with multiple emoji' do
          let(:body) { "Hello, 😁😁😁 😍 world!" }
          it { should be_persisted }
          its(:body) { should eql body }
        end

        context 'without any emoji' do
          let(:body) { "Hello, boring world!" }
          it { should be_persisted }
          its(:body) { should eql body }
        end

        context 'with a nil value' do
          let(:body) { nil }
          it { should be_persisted }
          its(:body) { should eql body }
        end

        context 'given option with `read_attribute: false`' do
          let(:args) { [:body, {read_attribute: false}] }
          let(:body) { "Hello, 😁 world!" }
          it { should be_persisted }
          its(:body) { should eql "Hello, :grin: world!" }
        end
      end

      describe :Callback do
        subject { Comment.create(body: body) }
        let(:persisted_body) { subject.read_attribute(:body) }

        context 'with a single emoji' do
          let(:body) { "Hello, 😁 world!" }
          it { should be_persisted }
          it { expect(persisted_body).to eql "Hello, :grin: world!" }
        end

        context 'with multiple emoji' do
          let(:body) { "Hello, 😁😁 😍 world!" }
          it { should be_persisted }
          it { expect(persisted_body).to eql "Hello, :grin::grin: :heart_eyes: world!" }
        end

        context 'without any emoji' do
          let(:body) { "Hello, boring world!" }
          it { should be_persisted }
          it { expect(persisted_body).to eql "Hello, boring world!" }
        end
      end
    end
  end
end
