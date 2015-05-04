require 'spec_helper'

module Kernel
  RSpec.describe "helper utils" do
    it "should respond to within" do
      expect(Kernel).to respond_to(:within)
    end
  end
end