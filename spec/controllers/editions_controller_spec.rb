require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe EditionsController do

  it "should have been using ActiveScaffold" do
    assert_not_nil EditionsController.active_scaffold_config
    assert EditionsController.active_scaffold_config.model == Edition
  end

end
