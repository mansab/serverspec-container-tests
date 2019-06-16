require "serverspec"
require "docker"
require "docker/compose"
require "rspec/wait"

set :backend, :docker
set :docker_container, 'sample-service'

RSpec.configure do |config|
  config.wait_timeout = 15
  compose = Docker::Compose.new

  describe "sample-service" do
    set :os, family: :alpine
    set :backend, :docker
    set :docker_container, 'sample-service'
  
    config.before(:all) do
      compose.up(detached: true, build: true)
    end
  
    config.after(:all) do
      compose.kill
      compose.rm(force: true)
    end

    describe process('python') do
      it { should be_running }
      its(:user) { should match(/app-user/) }
      its(:args) { should match(/\.\/index./) }
    end
  
    describe 'port 5000' do
      it 'should be open' do
        wait_for(port(5000)).to be_listening.with('tcp')
      end
    end
  end
end
