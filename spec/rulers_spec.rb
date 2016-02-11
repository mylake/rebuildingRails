require 'spec_helper'

describe Rulers do
  context 'has a version number' do
    Given(:version) { Rulers::VERSION }
    Then { version != nil}
  end

end
