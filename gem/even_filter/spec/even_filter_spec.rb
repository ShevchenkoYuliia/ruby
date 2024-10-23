RSpec.describe EvenFilter do
  it "has a version number" do
    expect(EvenFilter::VERSION).not_to be nil
  end

  it "filters even numbers from an array" do
    result = EvenFilter.filter([1, 2, 3, 4, 5, 6])
    expect(result).to eq([2, 4, 6])
  end
end
