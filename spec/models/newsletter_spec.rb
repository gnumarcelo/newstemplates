require File.expand_path(File.dirname(__FILE__) + '/../spec_helper')

describe Newsletter do
  it { Newsletter.should have_many(:editions) }
end
