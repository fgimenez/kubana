control 'controller_kubectl_cmd' do
  describe command('kubectl') do
    it { should exist }
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
  end

  describe command('kubectl --kubeconfig /etc/kubernetes/admin.conf get nodes') do
    its('stderr') { should eq '' }
    its('exit_status') { should eq 0 }
    its('stdout') { should match %r{Ready,master} }
  end
end
