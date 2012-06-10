module Fakes

  def sentence
    Faker::Lorem.sentence
  end

  def paragraphs
    Faker::Lorem.paragraphs.join("\n")
  end

  def words
    Faker::Lorem.words
  end

  def word
    words[0]
  end

end

FactoryGirl::DefinitionProxy.send(:include, Fakes)