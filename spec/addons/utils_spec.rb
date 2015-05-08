module Kernel
  RSpec.describe "helper utils" do
    context "#within" do
      it "should return immediately if no block is given" do
        expect(Kernel.within('/')).to eq(nil)
      end

      it "should return result of the block" do
        expect(Kernel.within('/') {1 + 1}).to eq(2)
      end
    end

    context "#with_messages" do
      let(:after_msg) {"after"}
      let(:before_msg) {"before"}
      it "should handle block and display messages and delimiter" do
        info = capture_stdout do
          with_messages(before_msg, after_msg) { 1 + 1 }
        end
        expect(info).to eq("#{before_msg}\n#{after_msg}\n#{'=' * 50}\n")
      end

      it "should not display delimiter when false is passed" do
        info = capture_stdout do
          with_messages(before_msg, after_msg, false) { 1 + 1 }
        end
        expect(info).to eq("#{before_msg}\n#{after_msg}\n")
      end
    end


    specify "#warning" do
      expect(Kernel).to respond_to(:warning)
      err = capture_stderr do
        warning "alert"
      end
      expect(err).to eq("[WARNING] alert\n")
    end

    specify "#exit_msg" do
      err = capture_stderr do
        expect(-> {exit_msg('critical')}).to raise_error(SystemExit)
      end
      expect(err).to eq("[ERROR] critical\n")
    end
  end
end