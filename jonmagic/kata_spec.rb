require_relative "kata"

describe ".add" do
  it "returns 0 when called with an empty string" do
    expect(add("")).to eq(0)
  end

  it "returns 6 called with '1,2,3'" do
    expect(add("1,2,3")).to eq(6)
  end

  it "returns 6 when called with '1\n2,3'" do
    expect(add("1\n2,3")).to eq(6)
  end

  it "raises error when called with '1,\n'" do
    expect { add("1,\n") }.to raise_error(StandardError, "invalid string: 1,\n")
  end

  it "accepts delimiter as first line" do
    expect(add("//[;]\n1;2;3")).to eq(6)
  end

  it "raises error when called with '-1,-2,3'" do
    expect { add("-1,-2,3") }.to raise_error(StandardError, "invalid string: [-1.0, -2.0]")
  end

  it "drops numbers greater than 1000" do
    expect(add("1,2000,3")).to eq(4)
  end

  it "accepts any delimiter" do
    expect(add("//[***]\n1***2***3")).to eq(6)
  end

  it "accepts multiple delimiters" do
    expect(add("//[*][&]\n1*2&3")).to eq(6)
  end

  it "accepts multiple delimiters with varying lengths" do
    expect(add("//[***][&&]\n1***2&&3")).to eq(6)
  end
end
