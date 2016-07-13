require 'spec_helper'

describe Contactually::Buckets do

  let(:bucket_json) { File.read(File.join(File.dirname(__FILE__),"fixtures/bucket.json")) }
  let(:bucket_index_json) { File.read(File.join(File.dirname(__FILE__),"fixtures/buckets_index.json")) }

  before(:all) do
    Contactually.configure { |c| c.access_token = 'VALID_ACCESS_TOKEN' }
    @master = Contactually::API.new
  end

  subject { described_class.new @master }
  describe '#initialize' do
    specify do
      expect(subject).to be_kind_of Contactually::Buckets
    end

    specify do
      expect(subject.instance_variable_get(:@master)).to be_kind_of Contactually::API
    end
  end

  describe '#create' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets.json', :post, { bucket: { foo: :bar }}).and_return(JSON.load(bucket_json))
      subject.create({ bucket: { foo: :bar }})
      expect(@master).to have_received(:call)
    end

    it 'returns a bucket' do
      allow(@master).to receive(:call).with('buckets.json', :post, { bucket: { foo: :bar }}).and_return(JSON.load(bucket_json))
      expect(subject.create({ bucket: { foo: :bar } })).to be_kind_of Contactually::Bucket
    end
  end

  describe '#destroy' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets/1.json', :delete, {})
      subject.destroy(1)
      expect(@master).to have_received(:call)
    end
  end

  describe '#show' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets/1.json', :get, { foo: :bar }).and_return({ id: 1 })
      subject.show(1, { foo: :bar })
      expect(@master).to have_received(:call)
    end

    it 'returns a bucket' do
      allow(@master).to receive(:call).with('buckets/1.json', :get, { foo: :bar }).and_return(JSON.load(bucket_json))
      expect(subject.show(1, { foo: :bar })).to be_kind_of Contactually::Bucket
    end
  end

  describe '#update' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets/1.json', :put, { bucket: { foo: :bar }}).and_return(JSON.load(bucket_json))
      subject.update(1, { bucket: { foo: :bar } })
      expect(@master).to have_received(:call)
    end

    it 'returns a bucket from json response' do
      allow(@master).to receive(:call).with('buckets/1.json', :put, { bucket: { foo: :bar }}).and_return(JSON.load(bucket_json))
      expect(subject.update(1, bucket: { foo: :bar })).to be_kind_of Contactually::Bucket
    end
  end

  describe '#index' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets.json', :get, { foo: :bar }).and_return({ 'data' => [] })
      subject.index({ foo: :bar })
      expect(@master).to have_received(:call)
    end

    it 'returns buckets from json response' do
      allow(@master).to receive(:call).with('buckets.json', :get, {}).and_return(JSON.load(bucket_index_json))
      expect(subject.index({})).to be_kind_of Array
      expect(subject.index({})[0]).to be_kind_of Contactually::Bucket
    end
  end

  describe '#count' do
    it 'calls the api with correct params' do
      allow(@master).to receive(:call).with('buckets.json', :get, { limit: 1 }).and_return({ 'data' => [], 'meta' => {'total' => 120 }})
      subject.count()
      expect(@master).to have_received(:call)
    end

    it 'returns total count' do
      allow(@master).to receive(:call).with('buckets.json', :get, { limit: 1 }).and_return({ 'data' => [], 'meta' => {'total' => 120 }})
      expect(subject.count).to be 120
    end
  end
end
