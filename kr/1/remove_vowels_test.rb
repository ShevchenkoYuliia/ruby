require './remove_vowels'  
RSpec.describe 'remove_vowels' do
  it 'видаляє всі голосні з англійського тексту' do
    expect(remove_vowels('hello')).to eq('hll')
  end

  it 'видаляє всі голосні з тексту кирилицею' do
    expect(remove_vowels('привіт')).to eq('првт')
  end

  it 'правильно працює з комбінованими рядками' do
    expect(remove_vowels('hello привіт')).to eq('hll првт')
  end

  it 'не змінює рядки без голосних' do
    expect(remove_vowels('hll')).to eq('hll')
  end

  it 'правильно працює з великими і маленькими літерами' do
    expect(remove_vowels('HELLO ПривІТ')).to eq('HLL ПрвТ')
  end

  it 'обробляє порожній рядок' do
    expect(remove_vowels('')).to eq('')
  end
end