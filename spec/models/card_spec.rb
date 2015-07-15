require 'rails_helper'

describe Card do
  let!(:card){ FactoryGirl.create(:card) }

  context "#same_texts" do
    it "fill in translated text correct" do
      card.send(:same_texts)
      expect(card.translated_text).to eq("Dog")
    end
  end

  context "#check_translation" do
    it "right translation" do
      expect(card.check_translation("doG")).to be_truthy
    end
    it "wrong translation" do
      expect(card.check_translation("DOGgg")).to be_falsey
    end
  end

  context "#set_default_review_date" do
    it "set review date correct" do
      card.set_default_review_date
      expect(card.review_date).to eq(Date.today + 3.day)
    end
  end

  context "#update_review_date" do
    it "update review date correct" do
      card.update_review_date
      expect(card.review_date).to eq(Date.today + 3.day)
    end
  end
end