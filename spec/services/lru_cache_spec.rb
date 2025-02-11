require 'rails_helper'

RSpec.describe LruCache do
  let(:lru_cache) { described_class.new(capacity) }
  let(:capacity) { 3}


  describe '#get' do
    subject { lru_cache.get(key) }
    let(:key) { :a }

    context "when key is not present" do

      it { is_expected.to eql(-1) }
    end

    context "when key is present" do
      before do
        lru_cache.put(:a, 2)
        lru_cache.put(:b, 3)
      end

      context "when verifying the values after retrieval" do
        let(:expected_outcome) do
          {
            b: 3,
            a: 2
          }
        end

        it "verifies the values" do
          expect(subject).to eql(2)
          expect(lru_cache.cache).to eql(expected_outcome)
        end
      end
    end
  end

  describe '#put' do
    subject { lru_cache.put(key, value) }

    context "when capacity is not full" do
      let(:key) { :c }
      let(:value) { 4 }

      let(:expected_outcome) do
        {
          c: 4
        }
      end

      it "verifies the values" do
        expect(subject).to eql(4)
        expect(lru_cache.cache).to eql(expected_outcome)
      end
    end

    context "when capacity is full" do
      before do
        lru_cache.put(:a, 1)
        lru_cache.put(:b, 2)
        lru_cache.put(:c, 3)
      end

      let(:key) { :d }
      let(:value) { 4 }

      let(:expected_outcome) do
        {
          b: 2,
          c: 3,
          d: 4    
        }
      end

      it "verifies the values" do
        expect(subject).to eql(4)
        expect(lru_cache.cache).to eql(expected_outcome)
      end
    end
  end

  describe '#show' do
    subject { lru_cache.show }

    before do
      lru_cache.put(:a, 2)
      lru_cache.put(:b, 3)
    end

    let(:expected_outcome) do
      {
        b: 3,
        a: 2
      }
    end

    it { is_expected.to eql(expected_outcome)}
  end
end
