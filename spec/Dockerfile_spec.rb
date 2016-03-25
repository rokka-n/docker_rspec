# spec/Dockerfile_spec.rb

require "serverspec"
require "docker"

describe "Dockerfile" do
  before(:all) do
    image = Docker::Image.build_from_dir('.')

    set :os, family: :debian
    set :backend, :docker
    set :docker_image, image.id
  end
  
  it "should install the right version of Ubuntu" do
    expect(os_version).to include("Ubuntu 14")
  end

  ['htop','wget','node', 'curl', 'nginx'].each do |package|
    it "installs package #{package}" do 
      expect(package("#{package}")).to be_installed
    end
  end

  describe port(80) do
      it { should be_listening }
  end

  def os_version
    command("cat /etc/issue").stdout
  end
end
