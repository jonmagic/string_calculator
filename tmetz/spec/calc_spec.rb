require_relative "../calc"

describe StringCalculator do

  describe "add" do
    context "given an empty string" do
      it "returns zero" do
        expect(StringCalculator.Add("")).to eq(0)
      end
    end
    context "given a string with only one number" do
      it "returns that number" do
        expect(StringCalculator.Add("5")).to eq(5)
      end
    end
    context "given a string with two comma-separated numbers" do
      it "returns the sum" do
        expect(StringCalculator.Add("1,2")).to eq(3)
      end
    end
    context "given more than 2 numbers" do
      it "returns the sum" do
        expect(StringCalculator.Add("1,2,8,22")).to eq(33)
      end
    end
    context "given newline as delimiter" do
      it "returns the sum" do
        expect(StringCalculator.Add("1\n5")).to eq(6)
      end
    end
    context "given mixture of newlines and commas as delimiters" do
      it "returns the sum" do
        expect(StringCalculator.Add("1\n5,3,5\n6")).to eq(20)
      end
    end
  end
end
