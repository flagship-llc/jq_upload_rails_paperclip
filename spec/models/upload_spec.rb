require 'spec_helper'

RSpec.describe JqUploadRailsPaperclip::Upload, :type => :model do

  it { should have_attachment(:file) }

end
