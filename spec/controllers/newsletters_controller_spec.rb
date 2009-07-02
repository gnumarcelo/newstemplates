require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe NewslettersController do

  it "should have been using ActiveScaffold" do
    assert_not_nil NewslettersController.active_scaffold_config
    assert NewslettersController.active_scaffold_config.model == Newsletter
  end

end
