class HostnameFinderOrCreator
  def initialize(name)
    @name = name
  end

  def call
    find_or_create
  end

  private

  def find_or_create
    hostname = Hostname.find_by(name: name)

    hostname ? hostname : Hostname.create!(name: name)
  end

  attr_reader :name

end