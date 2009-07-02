require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe AuthorsController do

  it "should have been using ActiveScaffold" do
    assert_not_nil AuthorsController.active_scaffold_config
    assert AuthorsController.active_scaffold_config.model == Author
  end

end
