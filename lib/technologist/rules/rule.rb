class Rule
  def initialize(attributes = {})
    attributes.each { |name, value| self.send(:"#{name}=", value) }
  end

  def matches?(framework_name, repository)
    false
  end
end
