control 'admin_cfg' do
  describe file('/etc/kubernetes/admin.conf') do
    it { should exist }
    its('owner') { should eq 'root' }
    its('group') { should eq 'root' }
    its('content') { should match %r{/apiVersion: v1/} }
    its('content') { should match %r{/current-context: admin@kubernetes/} }
  end
end
