require 'rails_helper'

describe Card do
  before (:each) do
    @card = create(:card)
  end

  context "#set_default_review_date" do
    before do
      Timecop.freeze(@card.review_date)
    end
    it "set review date correct" do
      expect(@card.review_date).to eq(Time.current)
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
      expect(@card.check_translation("dog")).to be :correct
      expect(@card.num_of_correct_answers).to eq(1)
      expect(@card.num_of_incorrect_answers).to eq(0)
    end

    it "typo" do
      expect(@card.check_translation("djg")).to be :typo
    end
    it "wrong translation" do
      expect(@card.check_translation("cat")).to be :wrong
      expect(@card.num_of_correct_answers).to eq(0)
      expect(@card.num_of_incorrect_answers).to eq(1)
    end
  end

  context "#update_review_date" do
    before do
      Timecop.freeze(@card.review_date)
    end
    it "1st correct answer" do
      expect(@card.check_translation("dog")).to be :correct
      expect(@card.num_of_correct_answers).to eq(1)
      expect(@card.review_date).to eq(Time.current + 12.hours)
    end
  end

  context "#update_review_date" do
    before do
      @card = create(:card, num_of_correct_answers: 2)
      Timecop.freeze(@card.review_date)
    end
    it "3d correct answer" do
      expect(@card.check_translation("dog")).to be :correct
      expect(@card.num_of_correct_answers).to eq(3)
      expect(@card.review_date).to eq(Time.current + 7.days)
    end
  end

  context "#update_review_date" do
    before do
      @card = create(:card, num_of_correct_answers: 5, num_of_incorrect_answers: 2)
      Timecop.freeze(@card.review_date)
    end

    it "wrong answer" do
      expect(@card.check_translation("cat")).to be :wrong
      expect(@card.num_of_correct_answers).to eq(0)
      expect(@card.num_of_incorrect_answers).to eq(3)
      expect(@card.review_date).to eq(Time.current + 12.hours)
    end
  end
end