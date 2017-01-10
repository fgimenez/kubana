control 'apiserver_kubectl_cmd' do
  describe command('kubectl') do
    it { should exist }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end
end
