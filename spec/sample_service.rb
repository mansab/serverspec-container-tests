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

end
