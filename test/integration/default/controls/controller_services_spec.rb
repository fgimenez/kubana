control 'controller_services' do
  title 'Check the different ports of the services running on the controller node'
  desc 'These are the services-port mappings:
           6443, 8080: kube-apiserver
           10250: kubelet'

  [6443, 8080, 10250].each do |port|
    describe port(port) do
      it { should be_listening }
    end
  end
end
