require 'spec_helper'

describe Contactually::Interactions do

  let(:interaction_json) { File.read(File.join(File.dirname(__FILE__),"fixtures/interaction.json")) }

  before(:all) do
    Contactually.configure { |c| c.access_token = 'VALID_ACCESS_TOKEN' }
    @master = Contactually::API.new
  end

  subject { described_class.new @master }
  describe '#initialize' do
    specify do
      expect(subject).to be_kind_of Contactually::Interactions
    end

    specify do
      expect(subject.instance_variable_get(:@master)).to be_kind_of Contactually::API
    end
  end

  describe '#create' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('interactions.json', :post, { interaction: { foo: :bar }}).and_return(JSON.load(interaction_json))
      subject.create({ interaction: { foo: :bar }})
      expect(@master).to have_received(:call)
    end

    it 'returns a interaction' do
      allow(@master).to receive(:call).with('interactions.json', :post, { interaction: { foo: :bar }}).and_return(JSON.load(interaction_json))
      expect(subject.create({ interaction: { foo: :bar } })).to be_kind_of Contactually::Interaction
    end
  end

  describe '#destroy' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('interactions/1.json', :delete, {})
      subject.destroy(1)
      expect(@master).to have_received(:call)
    end
  end

  describe '#show' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('interactions/1.json', :get, { foo: :bar }).and_return({ 'data' => {id: 1 }})
      subject.show(1, { foo: :bar })
      expect(@master).to have_received(:call)
    end

    it 'returns a interaction' do
      allow(@master).to receive(:call).with('interactions/1.json', :get, { foo: :bar }).and_return(JSON.load(interaction_json))
      expect(subject.show(1, { foo: :bar })).to be_kind_of Contactually::Interaction
    end
  end

  describe '#update' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('interactions/1.json', :put, { interaction: { foo: :bar }}).and_return(JSON.load(interaction_json))
      subject.update(1, { interaction: { foo: :bar } })
      expect(@master).to have_received(:call)
    end

    it 'returns a interaction from json response' do
      allow(@master).to receive(:call).with('interactions/1.json', :put, { interaction: { foo: :bar }}).and_return(JSON.load(interaction_json))
      expect(subject.update(1, { interaction: { foo: :bar }})).to be_kind_of Contactually::Interaction
    end
  end
end
