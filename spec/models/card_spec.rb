require 'rails_helper'

describe Card do
  before (:each) do
    @card = create(:card)
  end

  context "#set_default_review_date" do
    it "set review date correct" do
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
      to eq(DateTime.current.strftime("%m/%d/%Y, %H"))
    end
  end

  context "#same_texts" do
    it "fill in translated text correct" do
      @card.send(:same_texts)
      expect(@card.translated_text).to eq("dog")
    end
  end

  context "#check_translation" do
    it "right translation" do
      expect(@card.check_translation("dog", 5000)).to be :correct
    end

    it "typo" do
      expect(@card.check_translation("djg", 5000)).to be :typo
    end

    it "wrong translation" do
      expect(@card.check_translation("cat", 5000)).to be :wrong
    end
  end
  # efactor: 2.5, interval: 1, quality: 5, repetition: 1
  context "#supermemo2_review_algorithm" do
    before do
      @card = create(:card, repetition: 0)
    end
    it "1st correct answer" do
      expect(@card.check_translation("dog", 5000)).to be :correct
      expect(@card.repetition).to eq(1)
      expect(@card.efactor).to eq(2.5)
      expect(@card.interval).to eq(1)
      expect(@card.quality).to eq(5)
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
        to eq((@card.review_date + @card.interval).strftime("%m/%d/%Y, %H"))
    end
  end
  # efactor: 2.6, interval: 6, quality: 5, repetition: 2
  context "#supermemo2_review_algorithm" do
    before do
      @card = create(:card, repetition: 1, interval: 1)
    end

    it "2nd correct answer" do
      expect(@card.check_translation("dog", 4364)).to be :correct
      expect(@card.repetition).to eq(2)
      expect(@card.efactor).to eq(2.6)
      expect(@card.interval).to eq(6)
      expect(@card.quality).to eq(5)
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
        to eq((@card.review_date + @card.interval).strftime("%m/%d/%Y, %H"))
    end
  end
  # efactor: 2.7, interval: 16, quality: 5, repetition: 3
  context "#supermemo2_review_algorithm" do
    before do
      @card = create(:card, repetition: 2, efactor: 2.6, interval: 6)
    end

    it "3d correct answer" do
      expect(@card.check_translation("dog", 4000)).to be :correct
      expect(@card.repetition).to eq(3)
      expect(@card.efactor).to eq(2.7)
      expect(@card.interval).to eq(16)
      expect(@card.quality).to eq(5)
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
        to eq((@card.review_date + @card.interval).strftime("%m/%d/%Y, %H"))
    end
  end
  # efactor: 2.8000000000000003, interval: 43, quality: 5, repetition: 4
  context "#supermemo2_review_algorithm" do
    before do
      @card = create(:card, repetition: 3, efactor: 2.7, interval: 16)
    end

    it "4th correct answer" do
      expect(@card.check_translation("dog", 3500)).to be :correct
      expect(@card.repetition).to eq(4)
      expect(@card.efactor).to eq(2.8000000000000003)
      expect(@card.interval).to eq(43)
      expect(@card.quality).to eq(5)
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
        to eq((@card.review_date + @card.interval).strftime("%m/%d/%Y, %H"))
    end
  end
  # efactor: 2.7, interval: 1, quality: 0, repetition: 1
  context "#supermemo2_review_algorithm" do
    before do
      @card = create(:card, repetition: 3, efactor: 2.7, interval: 16)
    end

    it "wrong answer" do
      expect(@card.check_translation("cat", 3500)).to be :wrong
      expect(@card.repetition).to eq(1)
      expect(@card.efactor).to eq(2.7)
      expect(@card.interval).to eq(1)
      expect(@card.quality).to eq(0)
      expect(@card.review_date.strftime("%m/%d/%Y, %H")).
        to eq((@card.review_date + @card.interval).strftime("%m/%d/%Y, %H"))
    end
  end
end