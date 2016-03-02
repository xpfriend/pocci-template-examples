Encoding.default_external = Encoding::UTF_8
require 'spec_helper'

context 'user' do
  context 'root' do
    @user = 'root'

    describe group(@user) do
      it { should exist }
      it { should have_gid 0 }
    end

    describe user(@user) do
      it { should exist }
      it { should have_uid 0 }
      it { should belong_to_group 'root' }
      it { should have_home_directory '/root' }
      it { should have_login_shell '/bin/bash' }
    end
  end

  context 'git' do
    @user = 'git'

    describe group(@user) do
      it { should exist }
      it { should have_gid 1000 }
    end

    describe user(@user) do
      it { should exist }
      it { should have_uid 1000 }
      it { should belong_to_group 'git' }
      it { should have_home_directory '/home/git' }
      it { should have_login_shell '/bin/bash' }
    end
  end
end
