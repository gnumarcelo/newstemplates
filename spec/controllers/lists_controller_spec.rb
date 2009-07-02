require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe ListsController do

  it "should have been using ActiveScaffold" do
    assert_not_nil ListsController.active_scaffold_config
    assert ListsController.active_scaffold_config.model == List
  end

end
