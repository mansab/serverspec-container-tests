require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :alpine
    set :backend, :docker
    set :docker_image, image.id
  end

  it "has right version of alpine" do
    expect(os_version).to include("3.9.4")
  end

  def os_version
    command("cat /etc/alpine-release").stdout
  end

  it "should have python 3.7.3" do
    expect(python_version).to include("Python 3.7.3")
  end

  def python_version
    command("python --version").stdout
  end

  describe user('app-user') do
    it { should exist }
    it { should have_login_shell '/bin/sh' }
    it { should have_home_directory '/app' }
    it { should belong_to_group 'root' }
  end

  describe file('/app/index.py') do
    it { should be_mode 644 }
    it { should be_owned_by 'app-user' }
  end

  describe process('python') do
    it { should be_running }
    its(:user) { should match(/app-user/) }
    its(:args) { should match(/\.\/index.py/) }
  end

  describe 'port 5000' do
    it 'should be open' do
      wait_for(port(5000)).to be_listening.with('tcp')
    end
  end

end
