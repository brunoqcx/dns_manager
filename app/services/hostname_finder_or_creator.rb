class HostnameFinderOrCreator

  def initialize(name)
    @name = name
  end

  def call
    find_or_create
  end

  private

  attr_reader :name

  def find_or_create
    Hostname.find_by(name: name) || Hostname.create!(name: name)
  end
end